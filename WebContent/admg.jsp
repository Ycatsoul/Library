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
        <link rel="stylesheet" type="text/css" href="css/jquery.nouislider.css">
<%
	String errorInfo = (String)request.getAttribute("addAdmininfo");        
	if(errorInfo=="true") {
%>
<script type="text/javascript" language="javascript">
		alert("添加成功");                                            
		window.location="Admintor.do?type=fineadmin";                            // 跳转到登录界面
</script> 
<%
}
	else if(errorInfo=="false"){
%>
<script type="text/javascript" language="javascript">
		alert("添加失败,用户已存在");                                            
		window.location="Admintor.do?type=fineadmin" ;                            // 跳转到注册界面
</script> 
<%}
else if(errorInfo=="blank"){
%>
<script type="text/javascript" language="javascript">
		alert("信息不能为空");                                            
		window.location="Admintor.do?type=fineadmin" ;                            // 跳转到注册界面
</script> 
<%} else if(errorInfo=="length"){
%>
<script type="text/javascript" language="javascript">
		alert("密码长度不能少于6位");                                            
		window.location="Admintor.do?type=fineadmin" ;                            // 跳转到注册界面
</script> 
<%}else if(errorInfo=="namelength"){
	%>
	<script type="text/javascript" language="javascript">
			alert("账号长度不能少于6位");                                            
			window.location="Admintor.do?type=fineadmin" ;                            // 跳转到注册界面
	</script> 
	<%} %>
<script type="text/javascript" language="javaScript">

function del(url){

if(confirm("确定要删除？")){

window.location.href = "Admintor.do?type=delad&delid="+url;

}

document.form1.action("Admintor.do?type=delad&delid="+url);

}

</script>

<body>

 	<div role="tabpanel" class="tab-pane" id="char">

                        <div class="check-div">
                            <button class="btn btn-yellow btn-xs" style="margin-top: 10px" data-toggle="modal" data-target="#addChar">添加管理员</button>
                           
                        </div>
                        <div class="data-div">
                            <div class="row tableHeader">
                                <div class="col-xs-1 ">
                                    编码
                                </div>
                                <div class="col-xs-4">
                                    权限名
                                </div>
                                <div class="col-xs-5">
                                   用户名                     
                                </div>
                                <div class="col-xs-2">
                                    操作
                                </div>
                            </div>
                            <div class="tablebody">
                            <c:forEach items="${adlist}" var="list">
                             <div class="row">
                                    <div class="col-xs-1 ">
                                        ${list.getUserid()}
                                    </div>
                             <div class="col-xs-4">
                                    <span>管理员</span>
                            </div>
                            <div class="col-xs-5">
                                ${list.getUsername() }
                            </div>
                            <div class="col-xs-2">  
                            	<input class="btn btn-danger btn-xs" type="button" value="删除" onclick="del(${list.getUserid()})"/>                                                             
								<%-- <a class="btn btn-danger btn-xs" href="Admintor.do?type=delad&delid=${list.getUserid()}">删除</a> --%>
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
                <!--增加权限弹出窗口-->
                <div class="modal fade" id="addChar" role="dialog" aria-labelledby="gridSystemModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="gridSystemModalLabel">添加管理员</h4>
                            </div>
                            <div class="modal-body">
                                <div class="container-fluid">
                                    <form class="form-horizontal" action="Admintor.do" method="post">
                                       <input type="hidden" name="type" value="addAdmin">
                                       <div class="form-group">
                                            <label for="sOrd" class="col-xs-3 control-label">名称：</label>
                                            <div class="col-xs-6">
                                                <input type="text" name="username" class="form-control input-sm duiqi" id="sOrd" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="sOrd" class="col-xs-3 control-label">密码：</label>
                                            <div class="col-xs-6">
                                                <input type="password" name="psw" class="form-control input-sm duiqi" id="sOrd" placeholder="">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="sOrd" class="col-xs-3 control-label">确认密码：</label>
                                            <div class="col-xs-6">
                                                <input type="password" name="checkpw" class="form-control input-sm duiqi" id="sOrd" placeholder="">
                                            </div>
                                         </div> 
                                         <div class="form-group">                                                                                  
											<div class="modal-footer">
			                                <button type="button" class="btn btn-xs btn-white" data-dismiss="modal">取 消</button>
			                                <input type="submit" class="btn btn-xs btn-green" value="提交">
                           				 	</div>
                                            </div>                                          
                                    </form>
                                </div>
                            </div>                           
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
             </div>
</body>
</html>