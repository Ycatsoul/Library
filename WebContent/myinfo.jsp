<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/common.css" />
        <link rel="stylesheet" type="text/css" href="css/slide.css" />
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/flat-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.nouislider.css">
        <link rel="stylesheet" type="text/css" href="css1/form.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	String errorInfo = (String)request.getAttribute("changeresult");        
	if(errorInfo=="ok") {
%>
<script type="text/javascript" language="javascript">
		alert("修改成功,请重新登录"); 
		window.open('index.jsp','_top')
		//window.location='index.jsp';                            // 跳转到登录界面
</script> 
<%
}
	else if(errorInfo=="no"){
%>
<script type="text/javascript" language="javascript">
		alert("修改失败");                                            
		window.location='myinfo.jsp' ;                            // 跳转到注册界面
</script> 
<%}
else if(errorInfo=="blank"){
%>
<script type="text/javascript" language="javascript">
		alert("输入不能为空");                                            
		window.location='myinfo.jsp' ;                            // 跳转到注册界面
</script> 
<%} else if(errorInfo=="same"){
	%>
	<script type="text/javascript" language="javascript">
			alert("密码一致!");                                            
			window.location='myinfo.jsp' ;                            // 跳转到注册界面
	</script> 
	<%} %>   
<body>
	<div class="check-div" class="daoh" style="height: 30px">
	
	<div align="left" style="margin-top: 15px;margin-bottom: 10px;height: 10px;">
	<button class="btn btn-yellow btn-xs"><a href="Book.do?type=finedata">返回</a></button>
 	<button  class="btn btn-yellow btn-xs"><a href="Userdo?type=openchange">修改密码</a></button>
	</div>
 	</div>
 	<br>
 	<div align="center">
 	<form action="Userdo" method="post">
 	<input type="hidden" name="type" value="changepw">
 	<input type="hidden" name="userid" value="${user.getUserid()}">
	<table align="center" class="dataintable">
		<tr>
			<td>
			  账号：
			</td>
			<td>
			<input readonly="readonly" type="text" value="  ${user.getUsername()}">
			</td>
		</tr>
		<tr>
			<td>
			  权限：
			</td>
			<td>
			<input readonly="readonly" type="text" value=" ${level}">
			</td>
		</tr>
		<c:if test='${openpw=="true"}'>
			<tr>
			<td>
			  请输入旧密码：
			</td>
			<td>
			<input  type="password" name="oldpw">
			</td>
		</tr>
		<tr>
			<td>
			  请输入新密码：
			</td>
			<td>
			<input  type="password" name="newpw">
			</td>
		</tr>
		<tr>
			<td>
			</td>
			<td>
			<input class="btn btn-yellow btn-xs" type="submit" value="提交">
			</td>
		</tr>
		</c:if>
	</table>
		</form>
	<br>
	
	
	</div>
</body>
</html>