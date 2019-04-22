<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
		<script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
		<link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/common.css" />
        <link rel="stylesheet" type="text/css" href="css/slide.css" />
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/flat-ui.min.css" />
        <link rel="stylesheet" type="text/css" href="css/jquery.nouislider.css">
        <link rel="stylesheet" type="text/css" href="css1/form.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="check-div" class="daoh" style="height: 30px">
	
	<div align="left" style="margin-top: 15px;margin-bottom: 10px;height: 10px;">
	<button class="btn btn-yellow btn-xs"><a href="Book.do?type=finedata">返回</a></button>
 	
	</div>
	
 	</div>
 	<div align="center">
	<table align="center" class="dataintable">
		<tr>
			<td>
			  <i>图书号:</i>
			</td>
			<td>
				名称：		
			</td>
			<td>
			 	 状态：
			</td>
			
			<td>
			 	 操作：
			</td>
			
		</tr>
		<c:forEach items="${brolist}" var="list">
		<tr>
			<td>
			  <i>${list.getBook().getBookid()}</i>
			</td>
			<td>
				${list.getBook().getBookname() }
			</td>
			<td>
			 	 ${list.getState()}
			</td>
			<td>
			<c:if test="${list.getState()=='申请借阅'}">
			 	<button class="btn btn-yellow btn-xs"><a href="Brolen.do?type=returnbro&retid=${list.getId()}&bookid=${list.getBook().getBookid()}">取消</a></button>
			</c:if><c:if test="${list.getState()=='已借阅'}">
			 	<button class="btn btn-yellow btn-xs"><a href="Brolen.do?type=applybor&retid=${list.getId()}">退还</a></button>
			</c:if>
			</td>
		</tr>
		</c:forEach>
	</table>
	<br>
	
	</div>
	
</body>
</html>