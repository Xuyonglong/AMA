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
<title>记录查询</title>
<link rel="icon" type="imag/x-icon" href="sy.ico" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="object.*"%>
<link rel="stylesheet" type="text/css" href="./css/publicTemplate.css">
<link rel="stylesheet" type="text/css"
	href="./css/notification/ns-default.css" />
<link rel="stylesheet" type="text/css"
	href="./css/notification/ns-style-growl.css" />
<link rel="stylesheet" href="/AMA/css/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="/AMA/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/AMA/js/jquery.ztree.core.js"></script>
<script src="./js/notification/modernizr.custom.js"></script>
<script src="./js/ArrayListClass.js"></script>
<script src="./js/NodesClass.js"></script>
<script type="text/javascript">
	var idLeader = <%=((User)session.getAttribute("loginUser")).isLeader()%>;
	function setInfo(){
		window.location.href = "<%=request.getContextPath()%>/InfoServlet";
	}
	function exit(){
		window.location.href = "<%=request.getContextPath()%>/ExitServlet";
	}
	function itemSearch(){
		window.location.href = "<%=request.getContextPath()%>/ItemSearchServlet";
	}
	function memberManage(){
		window.location.href = "<%=request.getContextPath()%>/MemberManageServlet";
	}
	function personalObject(){
		window.location.href = "<%=request.getContextPath()%>/PersonalObjectServlet";
	}
</script>

<!-- js中保存所有结点 -->
<script type="text/javascript">
	//获取结点的值,先保存到二维数组
	var memberChanges = [
			'流水号--学号--姓名--变动类型--变动时间',
			<%ArrayList<MemberChange> memberChanges = (ArrayList<MemberChange>)(session.getAttribute("memberChanges"));
			if(memberChanges!=null&&memberChanges.size()>0){
				for(int i=0;i<memberChanges.size();i++){
					MemberChange node = memberChanges.get(i);
					out.print("'"+node.getFlowId()+"  "+node.getUserId()+"  "+node.getUserName()+"  ");
					out.print(node.getType()+"  "+node.getTime()+"'");
					if(i!=memberChanges.size()-1){
						out.print(",");
					}
				}
			}%>
	];
	var shelfChanges = [
			<%ArrayList<ShelfChange> shelfChanges = (ArrayList<ShelfChange>)(session.getAttribute("shelfChanges"));
			if(shelfChanges!=null&&shelfChanges.size()>0){
				for(int i=0;i<shelfChanges.size();i++){
					ShelfChange node = shelfChanges.get(i);
					out.print("'"+node.getFlowId()+"  "+node.getShelfId()+"  "+node.getShelfName()+"  ");
					out.print(node.getType()+"  "+node.getTime()+"'");
					if(i!=shelfChanges.size()-1){
						out.print(",");
					}
				}
			}%>
	];
	var itemChanges = [
			'流水号--学号--姓名--物品编号--物品名称--物品数量--变动类型--变动时间',
			<%ArrayList<ItemChange> itemChanges = (ArrayList<ItemChange>)(session.getAttribute("itemChanges"));
			if(itemChanges!=null&&itemChanges.size()>0){
				for(int i=0;i<itemChanges.size();i++){
					ItemChange node = itemChanges.get(i);
					out.print("'"+node.getFlowId()+"  "+node.getUserId()+"  "+node.getUserName()+"  ");
					out.print(node.getItemId()+"  "+node.getItemName()+"  "+node.getItemNumber()+"  ");
					out.print(node.getType()+"  "+node.getTime()+"'");
					if(i!=itemChanges.size()-1){
						out.print(",");
					}
				}
			}%>
	];
</script>
<script type="text/javascript">
	function changeInner(){
		var select = document.getElementById("changeSelect");
		var box = document.getElementById("recordBox");
		//先移除已有的子结点
		var childs = box.childNodes;
		if(childs != null && childs.length>0){
			for(var i = childs.length - 1; i >= 0; i--) {  
    			box.removeChild(childs[i]);  
			}  
		}
		var value = select.value;
		var nodes = null;
		if(value=="tc"){
			nodes = memberChanges;
		}
		else if(value=="ic"){
			nodes = itemChanges;
		}
		else if(value=="sc"){
			nodes = shelfChanges;
		}
		else{
			showSimpleNotification("系统错误！");
			return;
		}
		if(nodes!=null&&nodes.length>0){
			for(var i=0;i<nodes.length;i++){			
				var resultDiv = document.createElement("div");
				resultDiv.className = "record";
				resultDiv.innerHTML = nodes[i];
				box.appendChild(resultDiv);
			}
		}

	}
	

	jQuery(document).ready(function() {
		changeInner();
	});
</script>


<style type="text/css">
#mainPart #changeSelect{
	float: left;
	margin-left: 28%;
	margin-top: 30px;
	width: 180px;
	height: 50px;
	font-size: 20px;
}
#mainPart #recordBox{
	float: left;
	margin-left: 28%;
	margin-top: 20px;
	width: 600px;
	height: 400px;
	min-width:600px;
	overflow-y:scroll;
	overflow-x:auto;
	white-space:nowrap;
/* 	background-color:red; */
	border:1px;
	border-color:gray;
	border-style: solid;
	
}

#mainPart #recordBox .record{
	height: 25px;
/* 	background-color:green; */
}


</style>

</head>

<body>
	<div id="header" style="min-width:1311px;">
		<div id="logoBox" class="box">
			<div id="logo">AMA</div>
		</div>
		<div id="navigation" class="box">
			<ul>
				<li>
					<div class="label">
						<div class="name" onclick="itemSearch()" style='cursor:pointer;'>物品查询</div>
						<div class="line"></div>
					</div>
				</li>
				<%
					if(((User)session.getAttribute("loginUser")).isLeader()){
						String strLi1 = "<li><div class='label'><div class='name' style='cursor:pointer;' onclick='memberManage()'>人员管理</div><div class='line'  ></div></div></li>";
						String strLi2 = "<li><div class='label'><div class='name' style='cursor:pointer;'>仓库管理</div><div class='line'></div></div></li>";
						String strLi3 = "<li><div class='label'><div class='name' id='nameActive'>记录查询</div><div class='line' id='lineActive'></div></div></li>";
						out.print(strLi1);
//						out.print(strLi2);
						out.print(strLi3);
						out.flush();
				}
				%>
				<li>
					<div class="label">
						<div class="name" style='cursor:pointer;' onclick="personalObject()">我的物品</div>
						<div class="line"></div>
					</div>
				</li>
			</ul>
		</div>
		<div class="box" id="userBox">
			<div id="userName"><%=((User)session.getAttribute("loginUser")).getName()%></div>
			<input type="button" class="imgButton" id="exit" onclick="exit()" />
			<input type="button" class="imgButton" id="setting"
				onclick="setInfo()" />
		</div>
	</div>
	<!-- 下面是内容板块  -->
	<div id="mainPart" style="min-width:1311px;">
		<select id="changeSelect" onChange="changeInner()">
			<option value="ic">物品变动</option>
			<option value="tc">人员变动</option>
<!-- 			<option value="sc">货架变动</option> -->
		</select>
		<div id="recordBox"></div>
	</div>
	<!-- 内容板块结束  -->
	<div class="footer">
		<div class="help">
			<a href="/AMA/jsp/help.jsp">帮助</a>
		</div>
	</div>
	<!-- 隐藏的弹出框 -->

</body>
<script src="./js/notification/classie.js"></script>
<script src="./js/notification/notificationFx.js"></script>
<script src="./js/notification/showNotification.js"></script>
<script language="javascript">
        // 防止页面后退
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
</script>
</html>
