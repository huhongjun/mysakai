两个系统的对接，通过url传参数
sakai实现通过写一个简单的tool，把作业系统的url写入自动弹出新窗口。url规则是作业系统的，sakai把url写在sakai.properties中在jsp中读取然后把相关参数获得并且拼成url，在sakai页面展现简单说明而后点击一个连接然后弹出新窗口。

测试结果：用户id 和 课程id 符合作业系统的直接进入，不符合会提示用户：连接时间过长或登录已失败，请重新登录！