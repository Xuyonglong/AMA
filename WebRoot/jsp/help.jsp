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
	<title>帮助</title>
	<link rel="icon" type="imag/x-icon" href="sy.ico" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ page import="object.User" %>
	<link rel="stylesheet" type="text/css" href="./css/publicTemplate.css">
	<link rel="stylesheet" type="text/css" href="./css/notification/ns-default.css" />
	<link rel="stylesheet" type="text/css" href="./css/notification/ns-style-growl.css" />
	<script src="./js/notification/modernizr.custom.js"></script>

<script type="text/javascript">
	function setInfo(){
		window.location.href = "<%=request.getContextPath()%>/InfoServlet";
	}
	function exit(){
		window.location.href = "<%=request.getContextPath()%>/ExitServlet";
	}
</script>
<style type="text/css">
#mainPart #amalogo{
	float:right;
	margin-top:30px;
	margin-right:8%;
	width: 600px;
	height:520px;
	min-width:600px;
	min-height:520px;
	background:url(./img/ui/logo/amaLogoss.png);
 	border:0;
}

#mainPart #sylogo{
	float:left;
	margin-top:30px;
	margin-left:10%;
	width: 400px;
	height:500px;
	min-width:400px;
	min-height:500px;
	background:url(./img/ui/logo/SYLogo.png);
 	border:0;
}

</style>

</head>

<body style="min-width:1255px;">
	<div id="header">
		<div id="logoBox" class="box">
			<div id="logo">AMA</div>
		</div>
		<div id="navigation" class="box">
			<ul>
				<li>
					<div class="label">
						<div class="name" style="font-size:30px;">帮助</div>
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
	<div id="mainPart" >
		<div id="sylogo"></div>
		<div id="amalogo"></div>
	</div>	
	<!-- 内容板块结束  -->
	<div class="footer">
		<div class="help">
			<a href="/AMA/ItemSearchServlet">返回</a>
		</div>
	</div>
</body>
<script language="javascript">
        // 防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
</script>
</html>
