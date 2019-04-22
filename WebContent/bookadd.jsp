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
<title>添加图书</title>
</head>
<%
	String errorInfo = (String)request.getAttribute("addresult");        
	if(errorInfo=="ok") {
%>
<script type="text/javascript" language="javascript">
		alert("	添加成功");                                            
		window.location="Book.do?type=finedata";                            // 跳转到登录界面
</script> 
<%
}
	else if(errorInfo=="no"){
%>
<script type="text/javascript" language="javascript">
		alert("添加失败");                                            
		window.location="Book.do?type=finedata" ;                            // 跳转到注册界面
</script> 
<%}
else if(errorInfo=="feifa"){
%>
<script type="text/javascript" language="javascript">
		alert("输入不正确");                                            
		window.location="Book.do?type=finedata" ;                            // 跳转到注册界面
</script> 
<%} else if(errorInfo=="blank"){%>
<script type="text/javascript" language="javascript">
		alert("输入不能为空");                                            
		window.location="Book.do?type=finedata";                            // 跳转到注册界面
</script> 
<%} %>
<body>
	<div class="check-div">
	
 	</div>
 	<div align="center">
 	<form action="Book.do" method="get">
 		<input type="hidden" name="type" value="addbook">
	<table align="center" class="dataintable">
		
		<tr>
			<td>
			*名称：
			</td>
			<td>
			<input name="bookname" type="text" >
			<p align="right" style="font-size: 1;display: inline;color: red" >(*为必填项)</p>
			</td>
		</tr>
		<tr>
			<td>
			*作者：
			</td>
			<td>
			<input name="bookwriter" type="text" >
			</td>
		</tr>
		<tr>
			<td>
			 出版社：
			</td>
			<td>
			<input  name="bookpublic" type="text"  >
			</td>
		</tr>
		<tr>
			<td>
			 版本号：
			</td>
			<td>
			<input name="bookversion"  type="text"  >
			</td>
		</tr>
		<tr>
			<td>
			出版日期：
			</td>
			<td>
			<input name="pudate" type="text" >
			</td>
		</tr>
		<tr>
			<td>
			  *价格：
			</td>
			<td>
			<input name="bookprice" type="text" >
			</td>
		</tr>
		<tr>
			<td>
			  *数量：
			</td>
			<td>
			<input name="booknumber" type="text" >
			</td>
		</tr>
	</table>
	<br>
	<div align="center">
	<input type="submit" class="btn btn-xs btn-green" value="提交">
	<button class="btn btn-yellow btn-xs"><a href="Book.do?type=finedata">返回</a></button>
	</div>
	</form>
	<br>
	<div>
	</div>
	</div>
	
</body>
</html>