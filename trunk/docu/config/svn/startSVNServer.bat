
rem svnadmin create D:\ADeveloper\Workspace4all\subversionRepo
rem svn import /tmp/myproject file:///path/to/repos/myproject -m "initial import"
rem svn checkout file:///path/to/repos/myproject/trunk myproject
rem A second option is to run svnserve as a standalone ¡°daemon¡± process. Use the -d option for this:

rem Once the svnserve program is running, it makes every repository on your system available to the network. A client needs to specify an absolute path in the repository URL. For example, if a repository is located at /usr/local/repositories/project1, then a client would reach it via svn://host.example.com/usr/local/repositories/project1 . To increase security, you can pass the -r option to svnserve, which restricts it to exporting only repositories below that path:

svnserve -d -r "d:\svn_repo"