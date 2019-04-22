<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet"  type="text/css"  href="css1/form.css"/>
		<link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/common.css" />
        <link rel="stylesheet" type="text/css" href="css/slide.css" />
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/flat-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.nouislider.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body> 
	<div align="center" class="person"> 
		<br>
		<c:if test="${level=='游客'}">
		<p><font color="white">你好，游客</font></p>
		</c:if>
		<c:if test="${level=='管理员'}">
		<p><font color="white">你好管理员,${username}</font></p>
		</c:if>
		<c:if test="${level=='会员'}">
		<p><font color="white">你好会员,${user.getUsername()}</font></p>
		</c:if>
		<a href="index.jsp" target=&quot;_top&quot;><font color="white">注销</font></a>
		<span> </span>
		<c:if test="${level=='会员'}">
		<a href="myinfo.jsp" target="main"><font color="white">我的</font></a>		
		</c:if>
	</div>	
	   <div class="left">
	   		<hr>
	   		<c:if test="${level=='游客'}">
	   		<div class="meun-item" align="center"><a href="Book.do?type=finedata" target="main">数据查询</a></div>
	   		</c:if>
	   		<c:if test="${level=='管理员'}">
	   		<div class="meun-item" align="center"><a href="Admintor.do?type=fineadmin" target="main">权限管理</a></div>
	   		<div class="meun-item" align="center"><a href="Admintor.do?type=fineuser" target="main">用户管理</a></div>
	   		<div class="meun-item" align="center"><a href="Book.do?type=finedata" target="main">数据管理</a></div>
	   		<div class="meun-item" align="center"><a href="Brolen.do?type=fineallbro" target="main">借阅管理</a></div> 
	   		 
	   		</c:if>
	   		<c:if test="${level=='会员'}">
	   		<div class="meun-item" align="center"><a href="Book.do?type=finedata" target="main">数据查询</a></div>
	   		<div class="meun-item" align="center"><a href="Brolen.do?type=finemyborrow" target="main">我的借阅</a></div> 
	   		</c:if>
	   </div>   
</body>
</html>