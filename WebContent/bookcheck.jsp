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
			<input readonly="readonly" type="text" value="${book.getBookid()}">			
			</td>
		</tr>
		<tr>
			<td>
			名称：
			</td>
			<td>
			<input readonly="readonly" type="text" value="${book.getBookname() }">
			</td>
		</tr>
		<tr>
			<td>
			作者：
			</td>
			<td>
			<input readonly="readonly" type="text" value=" ${book.getBookwriter()}">
			</td>
		</tr>
		<tr>
			<td>
			 出版社：
			</td>
			<td>
			<input readonly="readonly" type="text" value=" ${book.getBookpublic() }">
			</td>
		</tr>
		<tr>
			<td>
			 版本号：
			</td>
			<td>
			<input readonly="readonly" type="text" value="${book.getBookversion() }">
			</td>
		</tr>
		<tr>
			<td>
			出版日期：
			</td>
			<td>
			<input readonly="readonly" type="text" value="  ${book.getPudate() }">
			</td>
		</tr>
		<tr>
			<td>
			  价格：
			</td>
			<td>
			<input readonly="readonly" type="text" value="  ${book.getBookprice() }">
			</td>
		</tr>
		<tr>
			<td>
			  数量：
			</td>
			<td>
			<input readonly="readonly" type="text" value=" ${book.getBooknumber() }">
			</td>
		</tr>
		
		
	</table>
	<br>
	
	</div>
	
</body>
</html>