<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"  type="text/css"  href="css1/bagim.css"/>
</head>
<%
	String errorInfo = (String)request.getAttribute("loginfo");        
	if(errorInfo != null) {
%>
<script type="text/javascript" language="javascript">
		alert("账号或者密码错误，请重新输入");                                            
		window.location='index.jsp' ;                            // 跳转到登录界面
</script> 
<%
}
%>
<body >
	<div class="mysec" >
		<div class="mysec-main">
		<h1 align="right"><font size="7" color="white">欢迎登陆图书管理系统</font></h1>		
		<div class="login">
			<div align="center">
				<form action="Login.do" method="post" >
				<input type="hidden" name="type" value="login">
					账号：<input type="text" name="username"><br>								
					密码：<input type="password" name="psw">
					<input type="submit" value="登陆" name="sumit"><br>
					<a href="adduser.jsp">会员注册</a>
					<a href="Login.do">游客进入</a>
				</form>
				
			</div>
		</div>
		</div>
	</div>
</body>
</html>