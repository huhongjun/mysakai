package OSP;

use 5.008004;
use strict;
use warnings;

our $VERSION = '0.01';

# Open Source Portfolio / Sakai Web Services
# by will trillich <will-at-serensoft-dot-com>

use strict;

use SOAP::Lite;

my $SERVER = 'localhost:8080';

=head1 NAME

OSP

=head1 SYNOPSIS

   use OSP; # Open Source Portfolio / Sakai

   my $osp = OSP->new("$server:$port")
      ->login('admin','kahunaPasswordHere');

   # look for an existing user, and create if necessary:
   my $user = $osp->call('checkForUser',$userid);
   if ( $user->result == 0 ) {
      $osp->call('addNewuser',
         $userid, $fname, $lname, $email, $type, $passwd,
      );
   }

   # create a course, three users, and assign student/access and
   # faculty/maintain roles all-at-once:
   my $course_results = $osp->course(
      title      => 'CS 352: XML/RPC with Sakai/OSP via Perl',
      descr      => 'Using Perl and SOAP for remote-procedure calls to Sakai and OSPortfolio',
      short      => 'Perl, SOAP::Lite and OSP',
      skin       => 'computer-science',
      studentry => {
         tomthumb => { # student key IS the username/login-id
            fname => 'Thomas',
            lname => 'Thumb',
            email => 'tiny@tom.not',
            passwd=> 'BigManOnCampus',
         },
         beginner => {
            fname => 'Green',
            lname => 'Horn',
            email => 'noob@nowhere.not',
            passwd=> 'TeachMeSeymour',
         },
      },
      faculty => {
         arand=>{ # faculty key == id (username/login)
            fname=>'Alisa',
            lname=>'Rosenbaum',
            email=>'galt@gulch.not',
            passwd=>'IsbMl,&Mloi,tIwnl4tsoam,naam2l4m',
         },
      },
   );
   # or a project worksite, instead:
   my $proj_results = $osp->project( ... );

   # or, do them yourself one step at a time:
   my $user_results = $osp->call('addNewUser', ...);
   my $site_results = $osp->call('addNewSite', ...);
   my $site_pages   = $osp->add_site_pages(...);
   my $join_results = $osp->add_users_to_site(...);

=head1 DESCRIPTION

This module is designed to work with Sakai/2.4 web services. With it, you can
create users, create worksites for courses, and attach users (as
maintain/faculty or access/student) to the worksites.

Uses SOAP::Lite to do the heavy lifting.

=head1 METHODS

=cut



my $true = (1==1);
my $false= (0==1);

my %pagetools;
my @pageorder;
&set_tools(
	undef, # the no-so-useful $SELF reference
	'sakai.iframe.site'       => 'Home',
	'sakai.announcements'     => 'Announcements',
	'sakai.syllabus'          => 'Syllabus',
	'sakai.schedule'          => 'Schedule',
	'sakai.discussion'        => 'Discussion',
	'sakai.assignment.grades' => 'Assignments',
	'sakai.samigo'            => 'Tests/Quizzes',
	'sakai.sections'          => 'Section Info',
	'sakai.siteinfo'          => 'Site Options',
);



sub LOGINPROXY {
	my $host = shift;
	return "$host/sakai-axis/SakaiLogin.jws?wsdl";
}

sub SCRIPTPROXY {
	my $host = shift;
	return "$host/sakai-axis/SakaiScript.jws?wsdl";
}



sub new {
	my $class = shift;

	my $host = shift || $SERVER;
	$host = "http://$host" unless $host =~ m{^\w+:/};

	my $debug = shift || '';

	return bless +{
		_server => $host,
		_soap => SOAP::Lite->new(proxy => &SCRIPTPROXY($host)),
		_debug => $debug,
	}, $class;
}

=head2 new( [ $host [, $debug] ] )

For the new() method, you can supply a host string if you don't want to use the default "localhost:8080".
If you supply only the host name by itself ('localhost') then protocols ('http://') will be prefixed as necessary.

A second argument can determine 'debug'ness: 1 (yes, spew debug info) or 0 (no, don't). It's off by default.

Returns the OSP object.

Here we include the option to turn on debugging:

  my $osp = OSP->new( 'my.server:8080', 1 );

=cut



sub login {
	my $self = shift;
	my $host = $self->{_server};

	my $userid = shift || die "Missing user id to log in to $host as";
	my $passwd = shift || die "Need password for user $userid at $host";
	my $crypt  = crypt( $passwd, '%@' );
	$self->{_userid} ||= '';
	$self->{_crypt}  ||= '';

	# skip it if we're already logged in as this user
	unless ( $userid eq $self->{_userid}  and  $crypt eq $self->{_crypt} ) {
		my $proxy = &LOGINPROXY( $host );
		my $loginsoap = SOAP::Lite->new( proxy => $proxy );

		my $sessionid = $loginsoap->login( $userid, $passwd )->result()
			or die "Can't log in as $userid to server $host";

		$self->{_userid} = $userid;
		$self->{_crypt}  = $crypt;
		$self->{_session}= SOAP::Data->value( $sessionid )->type( 'string' );
	}

	return $self;
}

=head2 login( $username, $password )

To establish an authenticated session, you'll need to supply a username and password to the login() method.

Returns the OSP object, for convenience.

  my $osp = OSP->new('http://my.host.here:7777');
  $osp->login('admin','SnazzyPassword');

This does the same thing:

  my $osp = OSP->new('http://my.host.here:7777')
               ->login('admin','SnazzyPassword');

=cut



# parse 'subroutine defs' from java source code to get method call names and args:
my %methods = &load_methods(); #closure

#print $_.':'.$methods{$m}{$_}."\n" for @{$methods{$m}{_}}

sub call {
	my $self = shift;
	my $method = shift;

	die "No such method $method"
		unless $methods{$method};

	die "Wrong number of args for $method(@{$methods{$method}{_}})\n\t[@_]"
		unless @{$methods{$method}{_}} == @_;

	my $debug = $self->{_debug};
	my $sessionid = $self->{_session};
	my $soap = $self->{_soap};

	# @debug will have "value:type" for each arg
	# @arg will have SOAP::Data->value->type() set per method definitions
	my @debug = ();
	my @arg = map {
			# get VAL of arg N:
			my $val = $_[$_]; # from @_
			# get NAME of arg N:
			my $arg = $methods{$method}{_}[$_];
			# get TYPE of arg N:
			my $typ = $methods{$method}{ $arg };
			if    ( $typ =~ /boolean|logical/ ) { $val = $val ? $true : $false }
			elsif ( $typ =~ /\b(int(eger)|long|short)\b/ ) { $val += 0 }
			elsif ( $typ =~ /\b(float|decimal|money|double)\b/ ) { $val += 0.0 };
			push @debug,"$arg=($typ)'$val'" if $debug;
			# set datatype of the incoming value, to that type
			SOAP::Data->value( $val )->type( $typ )
			# SOAP::Data->value($_[$_])->type($methods{$method}{ $methods{$method}{_}[$_] })
		} $[ .. $#_;

	unshift @arg, $sessionid;

	print STDERR "Method $method:",join ' ',map{"[$_]"} @debug if $debug;
	my $rv = $soap->$method( @arg );
	print STDERR ' = {',scalar( $rv ),"}\n" if $debug;

	return $rv;
}

=head2 call( $methodname, @argvalues )

Here's the main workhorse. This is how you call a "web service" on the Sakai/OSP Server.

  my $site = $osp->call('addNewSite',
    #worksite id:
    'CS151',
    #worksite title:
    'CS 151: Introduction to Perl',
    #worksite description:
    'CS 151: An introduciton to the swiss army chainsaw of programming languages',
    #worksite 'short description':
    'CS151: Intro to Perl',
    );
  if ( $site->result ne 'success' ) { ... }

  my $user = $osp->call('checkForUser','barneyrubble');
  if ( $user->result == 0 ) {
     $osp->call('addNewuser', ...);
  }

All of the subroutines defined in SakaiScript.jws (at least, those that include
a reference to "sessionid" as the first argument) are callable via this call()
method.

Each arg is 'coerced' to the expected type (as directed by the source-code
definitions of the java routines that we call as methods). See SakaiScript.jws
for specifics. Coersion is via SOAP::Data->value( $val )->type( $type ).
Thus, for example, booleans will never be mis-parsed as integers or strings.

=cut



sub add_site_pages {
	# one tool per page (page is eponymous with the tool)
	my $self = shift;
	my $site = shift;

	@_ % 2 && die "Mismatched number of tool=>page args for site $site";

	my %check = @_;
	my $backwards = 0;
	if ( grep !/^(osp|sakai)\.\w+/, keys %check ) {
		$backwards = 1;
		%check = reverse @_;
		if ( grep !/^(osp|sakai)\.\w+/, keys %check ) {
			die 'args to add_site_pages must ALL be "osp.tool=>Name" format';
		}
	}

	my %pages = ();

	while ( @_ ) {

		my $tool = shift;
		my $page = shift # page name == tool name
			or die "Missing page for site[$site] tool[$tool]";
		($tool,$page) = ($page,$tool) if $backwards;

		#addNewPageToSite(
		#	String sessionid,
		#	String siteid,
		#	String pagetitle,
		#	int pagelayout)
		$pages{$page}{added} =
			$self->call('addNewPageToSite', $site, $page, 0);

		#addNewToolToPage(
		#	String sessionid,
		#	String siteid,
		#	String pagetitle,
		#	String tooltitle,
		#	String toolid,
		#	String layouthints)
		$pages{$page}{tool} =
			$self->call('addNewToolToPage', $site, $page, $page, $tool, '');

	}

	return \%pages;

}

=head2 add_site_pages( $site, $tool_id=>$pagename, ...)

Here's where you populate a worksite with tools. This makes it easier for the
faculty to set up the site, as much of the grunt work is handled already. note
that there are currently (Oct 2007) no web-service facilities to talk to the
tools after they're added to a site -- we're just getting the site started for
faculty to finish up on:

  my $success = $osp->add_site_pages('CS151',
    'sakai.iframe.site'       => 'Home',
    'sakai.announcements'     => 'Announcements',
    'sakai.syllabus'          => 'Syllabus',
    'sakai.schedule'          => 'Schedule',
    'sakai.samigo'            => 'Tests/Quizzes',
    'osp.matrix'              => 'Enter the Matrix',
    'sakai.metaobj'           => 'Forms',
    'osp.presTemplate'        => 'Portfolio Templates',
    'osp.presLayout'          => 'Portfolio Layouts',
    'osp.presentation'        => 'Portfolios',
    'sakai.siteinfo'          => 'Site Options',
    );

If you mistakenly swap the tools with the page-names, they'll be straightened out for you:

  my $success = $osp->add_site_pages('CS151',
    'Announcements' => 'sakai.announcements',
    'Syllabus'      => 'sakai.syllabus',
    );

It looks for /\w+(\.\w+)*/ to determine if it's found the tools. Both
examples above would still work just fine. This one might not:

  my $trouble = $osp->add_site_pages('CS151',
    'web.content.com'  =>  'sakai.iframe', # which is the tool, which is the name?
    );

NOTE: There's no facility at the moment to have more than one tool on a page
(you can't set up Home to have several synoptic tools as yet, for example).
Again, after the worksite is created it's a snap to add more pages and/or
tools, it's just not automatic with OSP.pm. Yet.

=cut



sub add_users_to_site {
	my $self = shift;
	my $site = shift;
	my %joined = ();

	while ( @_ ) {
		my $userid = shift;
		my $role   = shift or die "No role for userid $userid at site $site?";

		#my $memberof = $self->call('getSitesUserCanAccess',
		#	$userid, # user id
		#	);
		#unless ( $memberof->? ) {
	#addMemberToSiteWithRole(String sessionid, String siteid, String eid, String roleid) throws AxisFault
			$joined{$userid} = $self->call('addMemberToSiteWithRole',
				$site,   # String siteid,
				$userid, # String userid,
				$role,   # String roleid
				);
		#}
	}

	return \%joined;
}

=head2 add_users_to_site( $site, $user=>$role, ... )

Once you've got your users in the system, and you have a site for them to
join (it'll appear in their membership tool on their 'my workspace') you
sign them up for the class like this:

  my $members = $osp->add_users_to_site('CS151',
    (map{$_ => 'access'}   keys %students),
    (map{$_ => 'maintain'} keys %faculty ),
  );

The results of each 'join' are returned in a hashref:

  foreach ( keys %$members ) {
    if ( $_->result eq 'success' ) {
      ...
    } else {
        ...
    }
  }

=cut



sub course  { splice @_, 1, 0, 'course' ; &newsite; }
sub project { splice @_, 1, 0, 'project'; &newsite; }

=head2 course( ... )

=head2 project( ... )

All keys are required:

  $rv = $osp->course(
    title => 'Civ Eng 495: Bridges',
    descr => 'Civil Engineering 495: Study and design of Bridge-Building',
    short => 'Civ Eng 495: Bridge-Building',
    skin => 'engineering',
    students => {
      bsmith=>{ # student key IS the id (userid/login)
        fname=>'Betty',
        lname=>'Stoll',
        email=>'bettys@flint.not',
        passwd=>'discovery-of-freedom',
      },
      jadams=>{
        fname=>'John',
        lname=>'Adams',
        email=>'jqa@independence.not',
        passwd=>'sixthPres',
      },
    },
    faculty => {
      arand=>{ # faculty key IS id (username/login)
        fname=>'Alisa',
        lname=>'Rosenbaum',
        email=>'galt@gulch.not',
        passwd=>'IsbMl,&Mloi,tIwnl4tsoam,naam2l4m',
      },
    },
  );

Call $osp->course() to create a course worksite, or $osp->project() to create
a project worksite.

A worksite ID can be supplied (such as 'CS386a-FA2007'). If none is supplied,
a site ID is created based on the current time and worksite title
(yyyy-mm-dd-hh-mm-ss-title). This is not a human-readable field; it can contain
any distinct string of characters to uniquely identify this worksite.

All other keys are required; there are no defaults. That is, you must specify
worksite title, description (descr), short description (short), and skin; if
you specify students and/or faculty, they must each have first-name (fname),
last-name (lname), email and password (passwd).

Note that keys for 'faculty' and 'student' can be abbreviated to the first three
letters -- the rest are ignored (so you could use stu=>{} or stupendous=>{} if
you like). All others require exact spellings.

Any number of students can be specified; any number of faculty can be
specified.

=over 4

Returns a hashref:

  {
    addedsite => $site,
    addedpages=> $pages,
    addeduser => \%user,
    membership=> $joined,
    timers    => {...},
  }

=item addedsite => {site_id_string=>soap_create_results}

The key is a site id and its corresponding value is the result of adding
(or trying to add) the site.  Note that site IDs are conjured up at runtime to
be unique (and contain no spaces -- turns out, that's a no-no) but finding it
is easy:

  my $newsiteID = (keys %{$rv{addedsite}})[0];

=item addedpages => {pagename=>{added=>create_page_results,tool=>create_tool_results},...}

Each key is a page name with a two-part hashref as the value:
'added' is the key for the results of the create_page_attempt
and 'tool' is the key for the results of the add_tool_to_page attempt.
For example:

  $rv->{addedpages}{Schedule}{added}->result == Create_Schedule_Page_Results
  $rv->{addedpages}{Schedule}{tool}->result  == Add_Schedule_Tool_Results

=item addeduser => {userid=>soap_create_results,userid2=>...}

Each key is a user id, and the value is the result of adding (or trying to add) the user
to the system.

  $rv->{addeduser}{user-id-here}->result == Create_User_Results

=item membership => {userid=>add_user_to_site_results,...}

Each key is a user id, and the value is the result of trying to add the user to the site.

  $rv->{membership}{user-id-here}->result == Join_User_To_Site_Results

=item timer => {...}

This hash contains five items of its own in case you're wondering about system load
or timing info:

- wall = wall-clock seconds required to create site/pagetools/users/memberships
- user = seconds of user-time used at the CPU
- sys  = seconds of system-times used at the CPU
- cuser= user-time of all child processes (should be 0)
- csys = sys-time of all child processes (should be 0)

=back

=cut



sub newsite {
	my $self = shift;
	my $TYPE = shift; # course or project

	die "$TYPE: Need PAIRS of key=>val args -- but got an odd number of args instead"
		if @_ % 2;

	my @times = (time,times);

	my %site = (); my @site=qw/title descr short skin/;
	my %stu  = (); my @user=qw/fname lname email passwd/;
	my %fac  = ();

	my @bad  = (); # track prpoblems and accumulate them for one report

	while ( @_ ) {
		my $key = shift;
		my $arg = shift;
		unless ( defined $arg ) {
			push(@bad, "$TYPE site requires key=>val pairs (key $key missing val)");
			next;
		}

		if ( $key =~ /^stu/i ) {
			ref( $arg ) =~ /HASH/
				? %stu = (%stu, %$arg) # in case there's multiple stu=> args
				: push @bad, "Arg value for $key (studentry) should be HASHREF, not $arg"
				;
		} elsif ( $key =~ /^fac/i ) {
			ref( $arg ) =~ /HASH/
				? %fac = (%fac, %$arg) # in case there's multiple fac=> args
				: push @bad, "Arg value for $key (faculty) should be HASHREF, not $arg"
				;
		} else {
			$site{$key} = $arg;
		}
	}

	my $id = $site{id};
	unless (defined($id)) {
		my @now = reverse( (localtime)[0..5] );
		$now[0]+=1900;
		$now[1]++;
		$now[$_] = sprintf('%02d',$now[$_]) for 1 .. 5;
		$id = join('-', @now, $site{title});
		$id =~ s/\s+//g;
	}

	# any problems? accumulate them ALL for our dying words, if any...
	push @bad,map{"Missing key '$_' for $TYPE site $id"}
		grep !exists($site{$_}), @site;
	for my $stu ( keys %stu ) {
		if ( ref($stu{$stu}) =~ /HASH/ ) {
			push @bad,map{"Student $stu missing key '$_' ($TYPE site $id)"}
				grep !exists($stu{$stu}{$_}), @user;
		} else {
			push @bad,"Student $stu refers to $stu{$stu} which should be a HASHREF";
		}
	}
	for my $fac ( keys %fac ) {
		if ( ref($fac{$fac}) =~ /HASH/ ) {
			push @bad,map{"Faculty $fac missing key '$_' ($TYPE site $id)"}
				grep !exists($fac{$fac}{$_}), @user
		} else {
			push @bad,"Faculty $fac refers to $fac{$fac} which should be a HASHREF";
		}
	}

	# comes the death scene:
	if ( @bad ) {
		# any bad news is fatal:
		die join "\n", @bad;
	}

	# NOTE that NOTHING has been done behind the scenes yet -- OSP
	# and Sakai are unmolested so far... and so we begin:

	# first thing we try is to create the worksite -- if it doesn't
	# work, we bail
	my $site = $self->call('addNewSite',
		$id,     ,        # String siteid,
		$site{title},     # String title,
		$site{descr},     # String description,
		$site{short},     # String shortdesc,
		'',               # String iconurl,
		'',               # String infourl,
		'',               # boolean joinable,
		'access',         # String joinerrole,
		'YES',            # boolean published,
		'',               # boolean publicview,
		$site{skin},      # String skin,
		$TYPE,            # String type)
		);

	if ( $site->result !~ /success/ ) {
		die "$TYPE: creating worksite $id/$site{title} failed: $site->result";
	}

	my $pages = $self->add_site_pages(
		$id,
		map { $_ => $pagetools{$_} } @pageorder
		);

	my %user = ();

	#addNewUser( String sessionid,            String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	#addNewUser( String sessionid, String id ,String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault

	# create users -- simply fails if user already exists
	foreach my $hashref ( \%stu, \%fac ) {
		foreach my $id ( keys %$hashref ) {
			$user{$id} = $self->call('addNewUser',
				$id,                        # String eid,
				$hashref->{$id}{fname},     # String firstname,
				$hashref->{$id}{lname},     # String lastname,
				$hashref->{$id}{email},     # String email,
				'registered',               # String type,
				$hashref->{$id}{passwd},    # String password)
				);
		}
	}

	my ($patrician,$plebian) =
		($TYPE eq 'course')
		? ('Instructor','Student')
		: ('maintain','access');
	my $joined = $self->add_users_to_site( $id,
		(map{$_ => $patrician} keys %fac ),
		(map{$_ => $plebian  } keys %stu ),
		);

	@times = map{$_ - shift(@times)} (time,times);

	return {
		addeduser => \%user,
		addedsite => $site,
		addedpages=> $pages,
		membership=> $joined,
		timers=>{
			wall =>shift(@times),
			user =>shift(@times),
			sys  =>shift(@times),
			cuser=>shift(@times),
			csys =>shift(@times),
		},
	};

}

=head2 newsite()

The newsite() subroutine is the big kahuna that both project() and course()
rely on to do all the smoke-and-mirrors. You shouldn't call this puppy yourself.
Internal affairs, keep out.

=cut



sub set_tools {
	my $self = shift;
	die 'Need tool.id=>"Tool Name" pairs for set_tools'
		if @_ % 2;

	my %check = @_;
	my $backwards = 0;
	if ( grep !/^(osp|sakai)\.\w+/, keys %check ) {
		$backwards = 1;
		%check = reverse @_;
		if ( grep !/^(osp|sakai)\.\w+/, keys %check ) {
			die 'args to set_tools must ALL be "osp.tool=>Name" format';
		}
	}

	%pagetools = ();
	@pageorder = ();
	while ( @_ ) {
		my $tool = shift;
		my $name = shift;
		($tool,$name) = ($name,$tool) if $backwards;
		push @pageorder, $tool;
		$pagetools{$tool} = $name;
	}
}

=head2 set_tools( tool.id=>ReadableName, tool.id=>ReadableName... )

The set_tools routine sets the pages/tools that will be created
when a worksite is created. Without any calls to 'set_tools'
the defaults are:

  'sakai.iframe.site'       => 'Home',
  'sakai.announcements'     => 'Announcements',
  'sakai.syllabus'          => 'Syllabus',
  'sakai.schedule'          => 'Schedule',
  'sakai.discussion'        => 'Discussion',
  'sakai.assignment.grades' => 'Assignments',
  'sakai.samigo'            => 'Tests/Quizzes',
  'sakai.siteinfo'          => 'Site Options',

To override this (there's no mechanism to add to or remove from the collection;
it's reset-from-scratch for now):

  $osp->set_tools(
    'osp.matrix'       => 'Enter the Matrix',
    'sakai.metaobj'    => 'Forms',
    'osp.presTemplate' => 'Portfolio Templates',
    'osp.presLayout'   => 'Portfolio Layouts',
    'osp.presentation' => 'Portfolios',
    'sakai.siteinfo'   => 'Site Options',
  );

The next call to $osp->course() (or $osp->project()) would create a worksite
with these six tools on it.

NOTE: Presumes all tools start with "osp-dot" or "sakai-dot" -- to
differentiate between tool-name and human-friendly-name. Notably 'blogger' does
not fit this pattern.  Of course, faculty can turn on (and off) any tools/pages
they want, later; this is just a shortcut to get them started with a useful
handful right out-of-the-box.

NOTE: There's no facility at the moment to have more than one tool on a page
(you can't set up Home to have several synoptic tools as yet, for example).
Again, after the worksite is created it's a snap to add more pages and/or
tools, it's just not automatic with OSP.pm. Yet.

=cut



# sub load_methods parses source-code definitions of java web services routines
# for use in call(), so we can enforce proper data types (notably BOOLEAN) for
# xml rpc calls...
#
# $method{METHOD}{_} => arg sequence [arg1 arg2 ... argn]
# $method{METHOD}{argn} = 'datatype'
# e.g. $method{changeUserPassword}{_} === [userid,password]
#      $method{changeUserPassword}{password} === 'string'
#      $method{changeUserPassword}{userid} === 'string'
# 
# note we omit SESSIONID from arg list altho we only
# pull in methods which use it

sub load_methods {
	return map {
		s/^\s*(\w+)\(// or die "bad method specification $_";
		my $method = $1;
		s/\).*//;
		# put 'string var','int var' etc into @seq for now:
		my @seq = map{
			s/^\s+//;
			s/\s+$//;
			$_
			} grep !/\bsessionid\b/, split ',';
		# now build %arg while zapping datatype from @seq:
		my %args = map{ s/(\w+)\s+(\w+)/$2/; $2 => lc($1) } @seq;
		$method => {
			_ => [@seq],
			%args
		}
	} grep /\bsessionid\b/, split /\n/, <<'METHODS';
	addNewUser( String sessionid, String id ,String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	addNewUser( String sessionid, String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	removeUser( String sessionid, String eid) throws AxisFault
	changeUserInfo( String sessionid, String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	changeUserName( String sessionid, String eid, String firstname, String lastname) throws AxisFault
	changeUserEmail( String sessionid, String eid, String email) throws AxisFault
	changeUserType( String sessionid, String eid, String type) throws AxisFault
	changeUserPassword( String sessionid, String eid, String password) throws AxisFault
	getUserEmail( String sessionid ) throws AxisFault
	getUserDisplayName( String sessionid ) throws AxisFault
	addNewAuthzGroup(String sessionid, String groupid) throws AxisFault
	removeAuthzGroup( String sessionid, String authzgroupid) throws AxisFault
	addNewRoleToAuthzGroup( String sessionid, String authzgroupid, String roleid, String description) throws AxisFault
	removeAllRolesFromAuthzGroup( String sessionid, String authzgroupid) throws AxisFault
	removeRoleFromAuthzGroup( String sessionid, String authzgroupid, String roleid) throws AxisFault
	allowFunctionForRole( String sessionid, String authzgroupid, String roleid, String function) throws AxisFault
	disallowAllFunctionsForRole( String sessionid, String authzgroupid, String roleid) throws AxisFault
	disallowFunctionForRole( String sessionid, String authzgroupid, String roleid, String function) throws AxisFault
	setRoleDescription( String sessionid, String authzgroupid, String roleid, String description) throws AxisFault
	addMemberToAuthzGroupWithRole( String sessionid, String eid, String authzgroupid, String roleid) throws AxisFault
	removeMemberFromAuthzGroup( String sessionid, String eid, String authzgroupid) throws AxisFault
	removeAllMembersFromAuthzGroup( String sessionid, String authzgroupid) throws AxisFault
	setRoleForAuthzGroupMaintenance( String sessionid, String authzgroupid, String roleid) throws AxisFault
	addMemberToSiteWithRole(String sessionid, String siteid, String eid, String roleid) throws AxisFault
	addNewSite( String sessionid, String siteid, String title, String description, String shortdesc, String iconurl, String infourl, boolean joinable, String joinerrole, boolean published, boolean publicview, String skin, String type) throws AxisFault
	removeSite( String sessionid, String siteid) throws AxisFault
	copySite( String sessionid, String siteidtocopy, String newsiteid, String title, String description, String shortdesc, String iconurl, String infourl, boolean joinable, String joinerrole, boolean published, boolean publicview, String skin, String type) throws AxisFault
	addNewPageToSite( String sessionid, String siteid, String pagetitle, int pagelayout) throws AxisFault
	removePageFromSite( String sessionid, String siteid, String pagetitle) throws AxisFault
	addNewToolToPage( String sessionid, String siteid, String pagetitle, String tooltitle, String toolid, String layouthints) throws AxisFault
	addConfigPropertyToTool( String sessionid, String siteid, String pagetitle, String tooltitle, String propname, String propvalue) throws AxisFault
	checkForUser(String sessionid, String eid) throws AxisFault
	checkForSite(String sessionid, String siteid) throws AxisFault
	checkForMemberInAuthzGroupWithRole(String sessionid, String eid, String authzgroupid, String role) throws AxisFault
	getSitesUserCanAccess(String sessionid)
METHODS
# NOTE the data above comes from an edited version of the output from
# using grep:
#	grep public SakaiScript.jws
# i.e. when SakaiScript.jws changes, we need to update the above list/data as well.
}

=head2 load_methods()

Internal routine, keep out. Fills the %methods hash with method names and arg names/datatypes.

=head1 BUGS/CAVEATS/etc

The data is yours, and the risk is yours.  It might not destroy things. Always
test thoroguhly on a staging server before going live!

=head1 AUTHOR

Written by Will Trillich <will-at-serensoft-dot-com> in May of 2006.

=head1 SEE ALSO

SOAP::Lite

=head1 COPYRIGHT and LICENSE

Copyright (C) 2007 by Will Trillich

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.

=cut



__END__

blogger	Blogger
osp.evaluation	Evaluations
osp.exposedmatrix	Exposed OSP Matrix
osp.exposedwizard	Exposed OSP Wizard
osp.glossary	Glossary
osp.guidance.sample	Guidance Sample
osp.matrix	Matrices
osp.presTemplate	Portfolio Templates
osp.presentation	Portfolios
osp.reports	Reports
osp.sample.jsf.widgets	OSP 2.0 JSF Tags
osp.synoptic	Synoptic
osp.synoptic.design.publish	Design and Publish
osp.wizard	Wizards
sakai.admin.prefs	Administrator's Preferences Tool
sakai.aliases	Admin: Alias Editor
sakai.announcements	Announcements
sakai.archive	Admin: Archive Tool
sakai.assignment	Assignments
sakai.assignment.grades	Assignments
sakai.chat	Chat Room
sakai.createuser	New Account
sakai.discussion	Discussion
sakai.dropbox	Drop Box
sakai.forums	Forums
sakai.gradebook.testservice	Gradebook Service Test
sakai.gradebook.tool	Gradebook
sakai.help	Help Documentation
sakai.iframe	Web Content
sakai.iframe.myworkspace	My Workspace Information Display
sakai.iframe.service	Service Information Display
sakai.iframe.site	Site Information Display
sakai.mailbox	Email Archive
sakai.mailtool	Mailtool
sakai.membership	Membership
sakai.memory	Admin: Memory / Cache Tool
sakai.messagecenter	Messages & Forums
sakai.messages	Messages
sakai.metaobj	Forms
sakai.motd	Message Of The Day
sakai.news	News
sakai.online	Admin: On-Line
sakai.podcasts	Podcasts
sakai.poll	Polls
sakai.postem	Post'Em
sakai.preferences	Preferences Tool
sakai.presence	Presence Tool
sakai.presentation	Presentation
sakai.privacy	Privacy Status
sakai.profile	Profile
sakai.realms	Admin: Realms Editor
sakai.resources	Resources
sakai.rutgers.linktool	Link Tool
sakai.rutgers.testlink	Test Link
sakai.rwiki	Wiki
sakai.samigo	Tests & Quizzes
sakai.sample.tool.jsf	Simple JSF sample tool
sakai.sample.tool.servlet	Simple Sample Servlet Tool
sakai.sample.tool.servlet2	Simple Sample Servlet Tool 2
sakai.schedule	Schedule
sakai.scheduler	Job Scheduler Based On Quartz
sakai.search	Search
sakai.sections	Section Info
sakai.singleuser	Account
sakai.site.roster	Roster
sakai.sitebrowser	Site Browser
sakai.siteinfo	Site Info
sakai.sites	Admin: Sites Editor
sakai.sitesetup	Worksite Setup
sakai.su	Admin: Become User
sakai.summary.calendar	Calendar
sakai.syllabus	Syllabus
sakai.synoptic.announcement	Recent Announcements
sakai.synoptic.chat	Recent Chat Messages
sakai.synoptic.discussion	Recent Discussion Items
sakai.synoptic.messagecenter	Messages & Forums Notifications
sakai.test.tools.OSIDUnitTest	Sakai OSID Unit Test Servlet
sakai.usermembership	User Membership
sakai.users	Admin: User Editor


WEB SERVICES
SakaiLogin.jws
	public String login(String id,String pw) 
	public boolean UsageSessionService_loginDirect(String userId, String userEid, String ipAddress, String userAgent)
	public boolean logout(String id) 

SakaiPortalLogin.jws:public class SakaiPortalLogin {
	public String loginAndCreate(String id, String pw, String firstName, String lastName, String eMail)
	public String login(String id,String pw) 
	public boolean UsageSessionService_loginDirect(String userId, String userEid, String ipAddress, String userAgent)

SakaiScript.jws
	public String checkSession(String id) {
	public String addNewUser( String sessionid, String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	public String addNewUser( String sessionid, String id ,String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	public String removeUser( String sessionid, String eid) throws AxisFault
	public String changeUserInfo( String sessionid, String eid, String firstname, String lastname, String email, String type, String password) throws AxisFault
	public String changeUserName( String sessionid, String eid, String firstname, String lastname) throws AxisFault
	public String changeUserEmail( String sessionid, String eid, String email) throws AxisFault
	public String changeUserType( String sessionid, String eid, String type) throws AxisFault
	public String changeUserPassword( String sessionid, String eid, String password) throws AxisFault
	public String getUserEmail( String sessionid ) throws AxisFault
	public String getUserDisplayName( String sessionid ) throws AxisFault
	public String addNewAuthzGroup(String sessionid, String groupid) throws AxisFault
	public String removeAuthzGroup( String sessionid, String authzgroupid) throws AxisFault
	public String addNewRoleToAuthzGroup( String sessionid, String authzgroupid, String roleid, String description) throws AxisFault
	public String removeAllRolesFromAuthzGroup( String sessionid, String authzgroupid) throws AxisFault
	public String removeRoleFromAuthzGroup( String sessionid, String authzgroupid, String roleid) throws AxisFault
	public String allowFunctionForRole( String sessionid, String authzgroupid, String roleid, String function) throws AxisFault
	public String disallowAllFunctionsForRole( String sessionid, String authzgroupid, String roleid) throws AxisFault
	public String disallowFunctionForRole( String sessionid, String authzgroupid, String roleid, String function) throws AxisFault
	public String setRoleDescription( String sessionid, String authzgroupid, String roleid, String description) throws AxisFault
	public String addMemberToAuthzGroupWithRole( String sessionid, String eid, String authzgroupid, String roleid) throws AxisFault
	public String removeMemberFromAuthzGroup( String sessionid, String eid, String authzgroupid) throws AxisFault
	public String removeAllMembersFromAuthzGroup( String sessionid, String authzgroupid) throws AxisFault
	public String setRoleForAuthzGroupMaintenance( String sessionid, String authzgroupid, String roleid) throws AxisFault
	public String addMemberToSiteWithRole(String sessionid, String siteid, String eid, String roleid) throws AxisFault
	public String addNewSite( String sessionid, String siteid, String title, String description, String shortdesc, String iconurl, String infourl, boolean joinable, String joinerrole, boolean published, boolean publicview, String skin, String type) throws AxisFault
	public String removeSite( String sessionid, String siteid) throws AxisFault
	public String copySite( String sessionid, String siteidtocopy, String newsiteid, String title, String description, String shortdesc, String iconurl, String infourl, boolean joinable, String joinerrole, boolean published, boolean publicview, String skin, String type) throws AxisFault
	public String addNewPageToSite( String sessionid, String siteid, String pagetitle, int pagelayout) throws AxisFault
	public String removePageFromSite( String sessionid, String siteid, String pagetitle) throws AxisFault
	public String addNewToolToPage( String sessionid, String siteid, String pagetitle, String tooltitle, String toolid, String layouthints) throws AxisFault
	public String addConfigPropertyToTool( String sessionid, String siteid, String pagetitle, String tooltitle, String propname, String propvalue) throws AxisFault
	public boolean checkForUser(String sessionid, String eid) throws AxisFault
	public boolean checkForSite(String sessionid, String siteid) throws AxisFault
	public boolean checkForMemberInAuthzGroupWithRole(String sessionid, String eid, String authzgroupid, String role) throws AxisFault
	public String getSitesUserCanAccess(String sessionid)

SakaiSession.jws
	public String checkSession(String id) {
	public String getSessionUser(String id) {

SakaiSite.jws
	public String joinAllSites(String id)
	public String getSitesDom(String id, String search, int first, int last) 
	public String getToolsDom(String id, String search, int first, int last) 

WSSession.jws
	public int getActiveUserCount(String sessionId, int elapsed)

