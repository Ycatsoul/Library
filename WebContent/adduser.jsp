<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"  type="text/css"  href="css1/add.css"/>
</head>
<%
	String errorInfo = (String)request.getAttribute("addinfo");        
	if(errorInfo=="true") {
%>
<script type="text/javascript" language="javascript">
		alert("注册成功");                                            
		window.location='index.jsp';                            // 跳转到登录界面
</script> 
<%
}
	else if(errorInfo=="false"){
%>
<script type="text/javascript" language="javascript">
		alert("注册失败，用户已存在");                                            
		window.location='adduser.jsp' ;                            // 跳转到注册界面
</script> 
<%}
else if(errorInfo=="blank"){
%>
<script type="text/javascript" language="javascript">
		alert("信息不能为空");                                            
		window.location='adduser.jsp' ;                            // 跳转到注册界面
</script> 
<%} else if(errorInfo=="length"){
%>
<script type="text/javascript" language="javascript">
		alert("密码长度不能少于6位");                                            
		window.location='adduser.jsp' ;                            // 跳转到注册界面
</script> 
<%} else if(errorInfo=="namelength"){
%>
<script type="text/javascript" language="javascript">
		alert("账号长度不能少于6位");                                            
		window.location='adduser.jsp' ;                            // 跳转到注册界面
</script> 
<%}%>
<body>
	<div class="mysec" >
		<div class="mysec-main">
		<h1 align="right"><font size="7" color="white">欢迎登陆图书管理系统</font></h1>		
		<div class="login">
			<div align="center" id="centerlog">
				<form action="Login.do" method="post" >
					账号：<input type="text" name="username"><br>								
					密码：<input type="password" name="psw"><br>
					确认密码：<input type="password" name="checkpw">
					<input type="hidden" name="type" value="adduser">
					<input type="submit" value="注册" name="sumit">
					<a href="index.jsp">返回</a>									
				</form>				
			</div>
			
		</div>
		</div>
	</div>
</body>
</html>