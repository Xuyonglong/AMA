<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"  isErrorPage="true"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>AMALogin</title>
    <link rel="icon" type="imag/x-icon" href="sy.ico" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" type="text/css" href="./css/login.css">

	<% 
		response.setHeader("Cache-Control", "no-cache"); 
		response.setHeader("Cache-Control", "no-store"); 
		response.setDateHeader("Expires", 0); 
		response.setHeader("Pragma", "no-cache"); 
	%> 
  </head>
  
  <body>
  	<div class = "in_center" id="minBox">
  	<br/><br/><br/>
  	<p style = "font-family:Microsoft YaHei UI; font-size:40px">AMA物资管理系统</p>
  	
  	<br>
  	<form style = "text-align:center" action="/AMA/LoginServlet" method="post" onsubmit="return check(this)">
  		<input type="hidden" name="returnUrl" value='${param.returnUrl }'/>
		<input type = "text" name = "id" placeholder = " 学号" id="id">
		<br><br>
		<input type = "password" name = "password" placeholder = " 密码" id="password">
		<br/><br/>
		<button class = "button" type = "submit" value = "submit">登录</button>
		<br/><br/>
		<span style="color:red;display:none" id="warning"></span>
	</form>
	
  	</div>
  	
  	<p class = "footer" style = "font-family:Microsoft YaHei UI; text-align:center;">Copyright © 2018 All Rights Reserved<br>软件工程专业又双叒叕施工小队</p>
  
  </body>
  	<script> 
  	    function check(form) {
        	if (form.id.value == '') {
            	showError(-1);
            	form.id.focus();
            	return false;
        	}
        	if (form.password.value == '') {
            	showError(-2);
            	form.password.focus();
            	return false;
        	}
        	return true;
    	}
    	
    	function showError(flag){
    		var message = "";
			switch (flag) {
			case -1:
				message = "用户名不能为空！";
				break;
			case -2:
				message = "密码不能为空！";
				break;
			case -3:
				message = "用户名或密码错误！";
				break;
			default: message="";
			}
			//script写上面将无法获取到
			var span = document.getElementById("warning");
			span.innerHTML = message;
			span.style.display="";
			setTimeout(function(){span.style.display="none";},3000);
    	}

		//检查是否错误		
  		var flag = <%=session.getAttribute("errorFlag")%>;
  		if(flag!=null){
  			document.getElementById("id").value = <%=session.getAttribute("oldId")%>;
  			document.getElementById("password").value = <%=session.getAttribute("oldPassword")%>;
  			showError(flag);
			<% session.removeAttribute("errorFlag"); %>
			flag = null;
  		}
  		
	</script>
<script language="javascript">
        // 防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
</script>
</html>
