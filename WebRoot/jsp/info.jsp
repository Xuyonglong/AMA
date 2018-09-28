<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<base href="<%=basePath%>">
	<title>个人信息</title>
	<link rel="icon" type="imag/x-icon" href="sy.ico" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ page import="object.User" %>
	<link rel="stylesheet" type="text/css" href="./css/publicTemplate.css">
	<link rel="stylesheet" type="text/css" href="./css/info.css">
	<link rel="stylesheet" type="text/css" href="./css/notification/ns-default.css" />
	<link rel="stylesheet" type="text/css" href="./css/notification/ns-style-growl.css" />
	<script src="./js/notification/modernizr.custom.js"></script>

<script type="text/javascript">
	function setInfo(){
		location.reload();
	}
	function exit(){
		window.location.href = "<%=request.getContextPath()%>/ExitServlet";
	}
	
	function returnBack(){
		window.location.href = "<%=request.getContextPath()%>/ItemSearchServlet";
	}
	function showResetPwd(){
		document.getElementById('light').style.display='block';
		document.getElementById('fade').style.display='block';
		document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
	}
	function hideResetPwd(){
		document.getElementById('light').style.display='none';
		document.getElementById('fade').style.display='none';
		document.body.style.overflow="";
		clearResetPwd();
	}
	function clearResetPwd(){
		document.getElementById('oldPassword').value = "";
		document.getElementById('newPassword').value = "";
		document.getElementById('surePassword').value = "";
	}
</script>


</head>

<body>
	<div id="header">
		<div id="logoBox" class="box">
			<div id="logo">AMA</div>
		</div>
		<div id="navigation" class="box">
			<ul>
				<li>
					<div class="label">
						<div class="name" style="font-size:30px;">个人信息</div>
						<div class="line"></div>
					</div>
				</li>
			</ul>
		</div>
		<div class="box" id="userBox">
			<div id="userName"><%= ((User)session.getAttribute("loginUser")).getName() %></div>
			<input type="button" class="imgButton" id="exit" onclick="exit()"/>
			<input type="button" class="imgButton" id="setting" onclick="setInfo()"/> 		
		</div>
	</div>
	<!-- 下面是内容板块  -->
	<div id="mainPart">
		<div id="infoBox">
		 	姓名&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%= ((User)session.getAttribute("loginUser")).getName() %>
		 	<br/><br/><br/>
		 	学号&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%= ((User)session.getAttribute("loginUser")).getId() %>
		 	<br/><br/><br/>
		 	身份&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<%= ((User)session.getAttribute("loginUser")).isLeader()?"管理员":"用户" %>
		 	<br/><br/><br/>
		 	<form action="/AMA/ResetInfoServlet" method="post" onsubmit="return check2(this)" target="resetInfoFrame">
		 	电话&nbsp&nbsp&nbsp&nbsp&nbsp
		 		<input type="text" id="phone" name="phone" style="font-size:18px" value="<%= ((User)session.getAttribute("loginUser")).getPhone() %>"/>
		 		<span style="color:red;">*</span>
			<br/><br/><br/>
			密码&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="javascript:void(0)" id="setPassword" onClick="showResetPwd()">修改密码</a>
			<br/><br/><br/><br/><br/><br/><br/><br/><br/>
			
				<input type="hidden"  name="type" value="resetPhone">
				<input type="submit" id="savePhone" value="保存" />&nbsp&nbsp
<!-- 				<input type="button" id="out" value="退部" /> -->
				<br/><br/>
			</form>
		</div>
		<input type="button" id="return" onclick="returnBack()" alt="返回上级页面"/>
		
	</div>	
	<!-- 内容板块结束  -->
	<div class="footer">
		<div class="help">
			<a href="/AMA/jsp/help.jsp">帮助</a>
		</div>
	</div>
	<div id="fade" class="black_overlay"></div>
	<div id="light" class="white_content">
		<input type="button" id="close" onclick="hideResetPwd()"/>
		<div id="inBox">
			<p style="font-size:20px; font-weight:bold;">更改密码</p>
			<br/><br/>
			<form action="/AMA/ResetInfoServlet" method="post" onsubmit="return check(this)" target="resetInfoFrame">
				<input type="hidden"  name="type" value="resetPassword">
				原密码<input type="password" name="oldPassword" id="oldPassword" style="font-size:16px;margin-left: 100px;" />
				<br/><br/>
				新密码<input type="password" name = "newPassword" id="newPassword" style="font-size:16px;margin-left: 100px;" />
				<br/><br/>
				确认密码<input type="password" name= "surePassword" id="surePassword" style="font-size:16px;margin-left: 84px;" />
				<br/><br/>
				<button class = "button" id="sure" type = "submit" value = "submit">确认</button>
				<br/>
			</form>
		</div>
	</div>
	<iframe name="resetInfoFrame" style="display:none"></iframe>
</body>
	<script src="./js/notification/classie.js"></script>
	<script src="./js/notification/notificationFx.js"></script>
	<script src="./js/notification/showNotification.js"></script>
<script> 
  	function check(form) {
        if (form.oldPassword.value == '') {
            showError(-1);
            form.oldPassword.focus();
            return false;
        }
        if (form.newPassword.value == '') {
            showError(-2);
            form.newPassword.focus();
            return false;
        }
        if (form.surePassword.value == '') {
            showError(-3);
            form.surePassword.focus();
            return false;
        }
        if (form.newPassword.value == form.oldPassword.value) {
            showError(-4);
            form.newPassword.focus();
            return false;
        }
        if (form.newPassword.value != form.surePassword.value) {
            showError(-5);
            form.surePassword.focus();
            return false;
        }
        return true;
    }
    
    function showError(flag){
    	var message = "";
		switch (flag) {
		case -1:
			message = "原密码不能为空！";
			break;
		case -2:
			message = "新密码不能为空！";
			break;
		case -3:
			message = "确认密码不能为空！";
			break;
		case -4:
			message = "新密码与原密码相同！";
			break;
		case -5:
			message = "两次新密码不相同！";
			break;
		case -6:
			message = "原密码错误！";
			break;
		case 0:
			message = "修改成功！";
			clearResetPwd();
			break;
		default: message="";
		}
		//script写上面将无法获取到
		showSimpleNotification(message);

    }
    var oldPhone = '<%= ((User)session.getAttribute("loginUser")).getPhone() %>';
    function check2(form){
    	var phone = form.phone.value;
    	if(phone==""){
    		showError2(-1);
    		return false;
    	}
    	if(phone.length!=11){
    		showError2(-2);
    		return false;
    	}
    	if(!(/^1[3|4|5|7|8]\d{9}$/.test(phone))){
    		showError2(-3);
    		return false;
    	}
    	return true;
    }
    function showError2(flag){
    	var message = "";
    	switch (flag) {
		case -1:
			message = "电话不能为空！";
			break;
		case -2:
			message = "电话必须为11位！";
			break;
		case -3:
			message = "电话填写错误！";
			break;
		case -4:
			message = "系统错误！";
			break;
		case 0:
			message = "电话保存成功！";
			oldPhone = document.getElementById("phone").value;
			break;		
		default: message="";
		}
		//script写上面将无法获取到
		showSimpleNotification(message);
		//恢复原来的电话
		setTimeout(function(){
			if(flag<0){
    			document.getElementById("phone").value = oldPhone;
    		}
		},1000);

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
