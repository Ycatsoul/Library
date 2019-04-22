<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

 <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
<link href="css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/common.css" />
        <link rel="stylesheet" type="text/css" href="css/slide.css" />
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/flat-ui.min.css" />
<%
	String errorInfo = (String)request.getAttribute("addAdmininfo");        
	if(errorInfo=="true") {
%>
<script type="text/javascript" language="javascript">
		alert("添加成功");                                            
		window.location='Book.do?type=finedata';                            // 跳转到登录界面
</script> 
<%
}
	else if(errorInfo=="false"){
%>
<script type="text/javascript" language="javascript">
		alert("添加失败,用户已存在");                                            
		window.location='Book.do?type=finedata' ;                            // 跳转到注册界面
</script> 
<%}
else if(errorInfo=="blank"){
%>
<script type="text/javascript" language="javascript">
		alert("信息不能为空");                                            
		window.location='Book.do?type=finedata' ;                            // 跳转到注册界面
</script> 
<%} %> 
<%
	String broresult = (String)request.getAttribute("broresult");        
	if(broresult=="ok") {
%>
<script type="text/javascript" language="javascript">
		alert("借阅成功，申请已提交");                                            
		window.location='Book.do?type=finedata';                            // 跳转到登录界面
</script> 
<%
}
	else if(broresult=="no"){
%>
<script type="text/javascript" language="javascript">
		alert("借阅失败");                                            
		window.location='Book.do?type=finedata' ;                            // 跳转到注册界面
</script> 
<%}
else if(broresult=="fill"){
%>
<script type="text/javascript" language="javascript">
		alert("借阅失败，数量不足");                                            
		window.location='Book.do?type=finedata' ;                            // 跳转到注册界面
</script> 
<%} %> 
<script type="text/javascript" language="javaScript">

function del(url){

if(confirm("确定要删除该图书？")){

window.location.href = "Book.do?type=delbook&delid="+url;

}

document.form1.action("Book.do?type=delbook&delid="+url);

}

</script>
<body>

 	<div role="tabpanel" class="tab-pane" id="char">
						<c:if test="${level=='管理员'}">
                        <div style="margin-left: 30px">                       	
                            <button class="btn btn-yellow btn-xs" ><a href="bookadd.jsp">添加数据</a></button>
                        </div>
                        </c:if>
                            <form  action="Book.do" style="margin-bottom: 10px;margin-top: 10px	">
							          <input type="hidden" name="type" value="finebook">
							          <input type="text" name="bookname" style="margin-left: 30px;width: 260px" placeholder="Search">
							          <button type="submit" class="btn-green btn-xs">检索</button>
							 </form>  
							 </div>                      	
                        <div class="data-div">
                            <div class="row tableHeader">
                                <div class="col-xs-1 ">
                                   图书号
                                </div>
                                <div class="col-xs-1">
                                    名称
                                </div>
                                <div class="col-xs-1">
                                   作者                     
                                </div>
                                <div class="col-xs-2">
                                    出版社
                                </div>
                                <div class="col-xs-1">
                                    版本号
                                </div>
                                <div class="col-xs-1">
                                    出版日期
                                </div>
                                <div class="col-xs-1">
                                    价格
                                </div>
                                <div class="col-xs-1">
               	 数量                    
                                </div>
                                <c:if test="${level=='管理员'}">
                                <div class="col-xs-1">
               	 已借阅                   
                                </div>
                                </c:if>
                                <c:if test="${level=='管理员'||level=='会员'}">
                                <div class="col-xs-1">
               	 操作                   
                                </div>
                                </c:if>
                            </div>
                            <div class="tablebody">
                            <c:forEach items="${booklist}" var="list">
                             <div class="row">
                                    <div class="col-xs-1 ">
                                        ${list.getBookid()}
                                    </div>                            
		                            <div class="col-xs-1">
		                                <a href="Book.do?type=checkbook&bookid=${list.getBookid()}">${list.getBookname() }</a>
		                            </div>
		                            <div class="col-xs-1">
		                                ${list.getBookwriter()}
		                            </div>		                           
		                            <div class="col-xs-2">
		                                ${list.getBookpublic() }
		                            </div>
		                            <div class="col-xs-1">
		                                ${list.getBookversion() }
		                            </div>
		                            <div class="col-xs-1">
		                                ${list.getPudate() }
		                            </div>
		                            <div class="col-xs-1">
		                                ${list.getBookprice() }
		                            </div>
		                            <c:if test="${level=='管理员'}">
		                            <div class="col-xs-1">
		                                ${list.getBooknumber() }
		                            </div>
		                            </c:if>
		                             <c:if test="${level=='会员'||level=='游客'}">
		                            <div class="col-xs-1">
		                                ${list.getBooknumber()-list.getBorrownumber()}
		                            </div>
		                            </c:if>
		                            <c:if test="${level=='管理员'}">
		                            <div class="col-xs-1">
		                                ${list.getBorrownumber()}
		                            </div>
		                            </c:if>
                            <div class="col-xs-2">
                            	<c:if test="${level=='管理员'}">   
                            	<input class="btn btn-danger btn-xs" type="button" value="删除" onclick="del(${list.getBookid()})"/>                             	                                                             
								<%-- <a class="btn btn-danger btn-xs" href="Book.do?type=delbook&delid=${list.getBookid()}">删除</a> --%>
								<a class="btn btn-yellow btn-xs" href="Book.do?type=changedata&bookid=${list.getBookid()}">修改</a>
								</c:if>
								<c:if test="${level=='会员'}">                              	                                                             
								<a class="btn btn-green btn-xs" href="Brolen.do?type=borrow&borid=${list.getBookid()}">借阅</a>
								
								</c:if>
                            </div>
                        	</div>
                        </c:forEach>
                    </div>
                </div>
                <!--页码块-->
                <footer class="footer">
                    <ul class="pagination">
                        <li>
                            <select>
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                                <option>7</option>
                                <option>8</option>
                                <option>9</option>
                                <option>10</option>
                            </select>
                            页
                        </li>
                        <li class="gray">
                            共20页
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-left">
                            </i>
                        </li>
                        <li>
                            <i class="glyphicon glyphicon-menu-right">
                            </i>
                        </li>
                    </ul>
                </footer>
                
</body>
</html>