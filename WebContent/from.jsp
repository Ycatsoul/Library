<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8">
<title>管理界面</title>
</head>
<frameset frame rows="56,*,33" cols="*" framespacing="1" frameborder="Yes" border="1" bordercolor="#00659C">
  <frame name="Top" scrolling="no" noresize target="contents" src="top.jsp" >
  <frameset id=GaobeiSysTem cols="180,*" framespacing="0" frameborder="Yes" border="1" bordercolor="#00659C">
    <frame name="Left" target="left" src="left.jsp" scrolling="no" marginwidth="0" marginheight="0">   
    <c:if test="${level=='管理员'}">
    <frame name="main" scrolling="auto" noresize src="admg.jsp">
    </c:if>
     <c:if test="${level=='会员'||level=='游客'}">
    <frame name="main" scrolling="auto" noresize src="bookmg.jsp">
    </c:if>
  </frameset>
  <frame name="GaobeiSys_Bottom" scrolling="no" noresize target="contents" src="">
  <noframes>
  <body>
  
  </body>
  </noframes>
</frameset>
</html>