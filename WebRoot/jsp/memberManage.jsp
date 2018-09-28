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
<title>人员管理</title>
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
<script type="text/javascript" src="/AMA/js/jquery.min.js"></script>
<script type="text/javascript" src="/AMA/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/AMA/js/jquery.ztree.core.js"></script>
<script src="./js/notification/modernizr.custom.js"></script>
<script src="./js/ArrayListClass.js"></script>
<script src="./js/NodesClass.js"></script>
<script type="text/javascript">
	var idLeader = <%=((User)session.getAttribute("loginUser")).isLeader()%>;
	var leaderID = <%=((User)session.getAttribute("loginUser")).getId()%>;
	function setInfo(){
		window.location.href = "<%=request.getContextPath()%>/InfoServlet";
	}
	function exit(){
		window.location.href = "<%=request.getContextPath()%>/ExitServlet";
	}
	function itemSearch(){
		window.location.href = "<%=request.getContextPath()%>/ItemSearchServlet";
	}
	function recordSearch(){
		window.location.href = "<%=request.getContextPath()%>/ChangeServlet";
	}
	function personalObject(){
		window.location.href = "<%=request.getContextPath()%>/PersonalObjectServlet";
	}
</script>
<!-- 获取所有人员 -->
<script type="text/javascript">
	var strMember1 = '<%= session.getAttribute("nowMembers") %>'; //加单引号表示对象转换为字符串
	var nowMembers = JSON.parse(strMember1).nowMembers;   //获取现任人员的数组对象
	var strMember2 = '<%= session.getAttribute("outMembers") %>'; //加单引号表示对象转换为字符串
	var outMembers = JSON.parse(strMember2).outMembers;  //获取退部人员的数组对象
	//将人员的数组对象加载到列表里
	function loadMembers(members){
		var box = document.getElementById("tableBox");
		//先移除已有的子结点
		var childs = box.childNodes;
		if(childs != null && childs.length>0){
		for(var i = childs.length - 1; i >= 0; i--) {  
    			box.removeChild(childs[i]);  
			}  
		}
		if(members!=null)
		for(var i=0;i<members.length;i++){			
			var memDiv = creativeMemberDivByObj(members[i]);
			if(memDiv!=null)box.appendChild(memDiv);
		}
	}
	
	function creativeMemberDivByObj(member){
		if(member==null)return null;
		else{
			var memDiv = document.createElement("div");
			memDiv.className = "member";
			memDiv.onmouseover = function(){showBlue(this)};
			memDiv.onmouseout = function(){showBlack(this)};
// 			alert(JSON.stringify(member));
			var str = "<input type=\"text\" name=\"name\" class=\"nameBlock\" disabled=\"disabled\" value=";
			str += member.name+">";
			str += "<input type=\"text\" name=\"id\" class=\"idBlock\" disabled=\"disabled\" value=";
			str	+= member.id+">";
			str += "<input type=\"text\" name=\"phone\" class=\"phoneBlock\" disabled=\"disabled\" value="
			str += member.phone+">";
			str += "<input type=\"text\" name=\"isLeader\" class=\"isLeaderBlock\" disabled=\"disabled\" value="
			str	+= (member.leader?"管理员":"用户")+">";
			str += "<input type=\"text\" name=\"inTime\" class=\"inTimeBlock\" disabled=\"disabled\" value="
			str += member.inTime+">";
			var buttonDiv = document.createElement("div");
			buttonDiv.className = "editButton";
			buttonDiv.onclick = function(){edit(this)};
			memDiv.innerHTML = str;
			memDiv.appendChild(buttonDiv);
			return memDiv;
		}
	}
</script>
<script type="text/javascript">

	

	jQuery(document).ready(function() {
		//默认加载现任成员
		loadMembers(nowMembers);
	});
</script>


<style type="text/css">
#mainPart #membersBlock{
	float:left;
	margin-left:15%;
	margin-top:0;
	width:600px;
	height:540px;
/* 	background-color:red; */
}

#mainPart #membersBlock #leaveMemberBlock{
	float:left;
	width:100%;
	height:50px;
	background-color:white;
}

#mainPart #membersBlock #membersBox{
	float:left;
	width:100%;
	height:450px;
/* 	background-color:green; */
	border:1px;
	border-color:gray;
	border-style: solid;
	padding-top:10px;
	padding-left:7px;
	padding-bottom:10px;
}

#mainPart #membersBlock #membersBox #tableHeader{
	float:left;
	width:98%;
	height:23px;
	background-color:#F1F1F1;	
}

#mainPart #membersBlock #membersBox #tableHeader .spanBlock{
	float:left;
	display:inline-block;  
	height:23px;
	border-left:1px;
	border-color:#CECECE;
	border-style: solid;
}
#mainPart #membersBlock #membersBox #tableBox{
	float:left;
	margin-top:5px;
	width:100%;
	height:380px;
/* 	background-color:green; */
	overflow-y:scroll;
}

#mainPart #membersBlock #membersBox #tableBox .member{
	float:left;
	width:100%;
	height:30px;
}

#mainPart #membersBlock #membersBox #tableBox .member .nameBlock{
	float:left;
	display:inline-block; 
	width:101px;
	height:30px;
	font-weight:bold;
	background-color:white;
	border:0;
	white-space: nowrap; 
	overflow: hidden;
	text-overflow: ellipsis;
	max-width:101px;
}

#mainPart #membersBlock #membersBox #tableBox .member .idBlock{
	float:left;
	display:inline-block; 
	width:111px;
	height:30px;
	background-color:white;
	border:0;
}

#mainPart #membersBlock #membersBox #tableBox .member .phoneBlock{
	float:left;
	display:inline-block; 
	width:151px;
	height:30px;
	background-color:white;
	border:0;
}

#mainPart #membersBlock #membersBox #tableBox .member .isLeaderBlock{
	float:left;
	display:inline-block; 
	width:81px;
	height:30px;
	background-color:white;
	border:0;
}

#mainPart #membersBlock #membersBox #tableBox .member .inTimeBlock{
	float:left;
	display:inline-block; 
	width:91px;
	height:30px;
	background-color:white;
	border:0;
}

#mainPart #membersBlock #membersBox #tableBox .member .editButton{
	float:left;
	display:inline-block; 
	width:30px;
	height:30px;
	border:0;
	background: url(./img/ui/mainPage/edit.png);
	cursor:pointer;
}

#mainPart #membersBlock #membersBox #addBox{
	float:left;
	width:50px;
	height:50px;
	background: url(./img/ui/mainPage/addMember.png);
	cursor:pointer;
}

#mainPart #detailBlock{
	float:left;
	margin-left:30px;
	margin-top:50px;
	width:300px;
	height:470px;
	border:1px;
	border-color:#CECECE;
	border-style: solid;
/* 	background-color:green; */
}

#mainPart #detailBlock #detailBox{
	float:left;
	width:300px;
	height: 465px;
/* 	background-color:red; */
}

#mainPart #detailBlock #detailBox .msg{
	width:100%;
	margin-top:5px;
}
#mainPart #detailBlock #detailBox .items{
	padding-left:10px;
	width:290px;
	height:100px;
	max-height:100px;
	overflow-y:scroll;
	overflow-x:auto;
/* 	background-color:red; */
	
}

#mainPart #detailBlock #detailBox .whiteBox{
	width:100%;
	height:150px;
}

#mainPart #detailBlock #detailBox .whiteLine{
	width:100%;
	height:20.8px;
}

#mainPart #detailBlock #detailBox .saveButton{
	float:left;
	margin-left:20px;
	padding-top:13px;
	width: 120px;
	height:35px;
	color:white;
	background-color:#5b9dcc;
	cursor: pointer;
	text-align:center;
	font-size:18px;
}

#mainPart #detailBlock #detailBox .delButton{
	float:left;
	margin-left:20px;
	padding-top:13px;
	width: 120px;
	height:35px;
	color:white;
	cursor: pointer;
	text-align:center;
	font-size:18px;
	background-color:#cb5c70;
}

.black_overlay {
	display: none;
	position: absolute;
	top: 0%;
	left: 0%;
	width: 100%;
	height: 100%;
	background-color: black;
	z-index: 991;
	-moz-opacity: 0.1;
	opacity: .10;
	filter: alpha(opacity = 10);
}

.white_content {
	display: none;
	position: absolute;
	top: 27%;
	left: 32%;
	width: 30%;
	height: 40%;
	padding: 10px;
	background-color: white;
	z-index: 992;
	min-width:390px;
}

.white_content #close {
	float: right;
	width: 30px;
	height: 30px;
	background: url(./img/ui/mainPage/close.png);
	border: 0;
	cursor: pointer;
	outline: none;
}

.white_content #inBox {
	font-family: "宋体";
	margin-top: 40px;
	margin-left: 20px;
	min-width: 372px;
}

.white_content #inBox #sure {
	height: 37px;
	width: 190px;
	background-color: #668be0;
	border: 0;
	color: white;
	cursor: pointer;
	outline: none;
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
						String strLi1 = "<li><div class='label'><div class='name'  id='nameActive'>人员管理</div><div class='line' id='lineActive' ></div></div></li>";
						String strLi2 = "<li><div class='label'><div class='name' style='cursor:pointer;'>仓库管理</div><div class='line'></div></div></li>";
						String strLi3 = "<li><div class='label'><div class='name' style='cursor:pointer;' onclick='recordSearch()'>记录查询</div><div class='line' ></div></div></li>";
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
		<div id="membersBlock">
			<div id="leaveMemberBlock" >
				<input type="checkbox" style=" float:left;zoom: 1.6; margin-top:10px;" id="leave" onclick="checkLeave()" /> 
				<span style="float:left;margin-top:12px;font-size:18px;">查看已退部人员</span>
			</div>
			<div id="membersBox">
				<div id="tableHeader">
					<span class="spanBlock"  style="width:100px;">&nbsp姓名</span>
					<span class="spanBlock"  style="width:110px;">&nbsp学号</span>
					<span class="spanBlock"  style="width:150px;">&nbsp电话</span>
					<span class="spanBlock"  style="width:80px;">&nbsp身份</span>
					<span class="spanBlock"  style="width:110px;">&nbsp入队时间</span>
				</div>
				<div id="tableBox"></div>
				<div id="addBox" onclick=showAddMem()></div>
			</div>
		</div>
		<div id="detailBlock">
			<p style="font-size:20px;">&nbsp;详细信息</p>
			<div id="detailBox"></div>
		</div>
	</div>
	<!-- 内容板块结束  -->
	<div class="footer">
		<div class="help">
			<a href="/AMA/jsp/help.jsp">帮助</a>
		</div>
	</div>
	<!-- 隐藏的弹出框 -->
	<iframe name="hiddenFrame" style="display:none"></iframe>
	<div id="fade" class="black_overlay"></div>
	<!-- 添加框 -->
	<div id="addMemberBlock" class="white_content">
		<input type="button" id="close" onclick="hideAddMem()"/>
		<div id="inBox">
			<p style="font-size:20px; font-weight:bold;">添加成员</p>
			<br/><br/>
			<form action="/AMA/AddMemberServlet" method="post" onsubmit="return checkAdd(this)" target="hiddenFrame">
				<input type="hidden"  name="type" value="resetPassword">
				学号<input type="text" name="AddId" id="AddId" style="font-size:16px;margin-left: 100px;" />
				<br/><br/>
				姓名<input type="text" name = "AddName" id="AddName" style="font-size:16px;margin-left: 100px;" />
				<br/><br/>
				电话<input type="text" name= "AddPhone" id="AddPhone" style="font-size:16px;margin-left: 100px;" />
				<br/><br/>
				<button class = "button" id="sure" type = "submit" value = "submit" style="margin-left: 136px;">确认</button>
				<br/>
			</form>
		</div>
	</div>
	<!-- 重置密码框 -->
	<div id="resetPwdBlock" class="white_content">
		<input type="button" id="close" onclick="hideResetPwd()"/>
		<div id="inBox">
			<p style="font-size:20px; font-weight:bold;">重置密码</p>
			<br/><br/>
			<form action="/AMA/ResetPasswordServlet" method="post" target="hiddenFrame">
				<input type="hidden"  name="resetId" id="resetId" value="">
				重置后密码为“111111”，是否确认？
				<br/><br/>
				<br/><br/>
				<br/><br/>
				<button class = "button" id="sure" type = "submit" value = "submit" style="margin-left: 130px;">确认</button>
				<br/>
			</form>
		</div>
	</div>
	<!-- 删除成员框 -->
	<div id="delMemberBlock" class="white_content">
		<input type="button" id="close" onclick="hideDel()" />
		<div id="inBox">
			<p style="font-size:20px; font-weight:bold;">删除成员</p>
			<br />
			<br />
			<form action="/AMA/DelMemberServlet" method="post"
				onsubmit="return checkDel(this)" target="hiddenFrame">
				<input type="hidden" name="outId" id="outId" value=""> 
				退部原因<input type="text" name="outReasonInput" id="outReasonInput" style="font-size:16px;margin-left: 100px;" /> 
				<br /><br /> <br /><br /><br /><br />
				<button class="button" id="sure" type="submit" value="submit"
					style="margin-left: 136px;">确认</button>
				<br />
			</form>
		</div>
	</div>
	<!-- 移交权限框 -->
	<div id="changeLeaderBlock" class="white_content">
		<input type="button" id="close" onclick="hideChangeLeader()" />
		<div id="inBox">
			<p style="font-size:20px; font-weight:bold;">移交管理员</p>
			<br />
			<br />
			<form action="/AMA/ChangeLeaderServlet" method="post"
				onsubmit="return checkChangeLeader(this)" target="hiddenFrame">
				<input type="hidden" name="newLeaderId" id="newLeaderId" value=""> 
				<input type="hidden" name="oldLeaderId" id="oldLeaderId" value="">
				移交后您将变为普通用户并自动退出,请输入密码确认：<br /><br /><br />
				<input type="password" name="leaderPwd" id="leaderPwd" style="font-size:16px;margin-left: 100px;" /> 
				<br /><br /> <br /><br />
				<button class="button" id="sure" type="submit" value="submit"
					style="margin-left: 100px;">确认</button>
				<br />
			</form>
		</div>
	</div>
</body>
<script src="./js/notification/classie.js"></script>
<script src="./js/notification/notificationFx.js"></script>
<script src="./js/notification/showNotification.js"></script>
<!-- 人员项动态效果 -->
<script type="text/javascript">
	function showBlue(Div){
		var childs = Div.childNodes;
		if(childs != null && childs.length>0){
		for(var i = childs.length - 1; i >= 0; i--) { 
// 				有些子节点为空白元素 
    			switch(childs[i].name){
    			case "name":
    			case "id":
    			case "phone":
    			case "isLeader":
    			case "inTime": childs[i].style.color="blue";break;
    			default:;
    			}  
			}  
		}
	}
	function showBlack(Div){
		var childs = Div.childNodes;
		if(childs != null && childs.length>0){
		for(var i = childs.length - 1; i >= 0; i--) {  
				//有些子节点为空白元素
    			switch(childs[i].name){
    			case "name":
    			case "id":
    			case "phone":
    			case "isLeader":
    			case "inTime": childs[i].style.color="black";break;
    			default:;
    			}  
			}  
		}
	}






	function edit(editButton) {
		//先取消原来开启的编辑框
		if (editEle != null) {
			cancelEdit(editEle);
		}
		//获取id
		var Div = editButton.parentNode;
		var memberId;
		var childs = Div.childNodes;
		if (childs != null && childs.length > 0) {
			for (var i = childs.length - 1; i >= 0; i--) {
				// 有些子节点为空白元素
				if (childs[i].name == "id") {
					memberId = childs[i].value;
				}
			}
		}
		var isNow = false;
		if (getOutTimeById(memberId) == "9999-01-01") {
			isNow = true;
		}
		//现任队员可以被修改信息
		if (isNow) {
			for (var i = childs.length - 1; i >= 0; i--) {
				if (childs[i].name == "name") {
// 					childs[i].disabled = false;
					childs[i].style.border = "0px solid #CECECE";
					oldName = childs[i].value;
				}
				if (childs[i].name == "phone") {
// 					childs[i].disabled = false;
					childs[i].style.border = "0px solid #CECECE";
					oldPhone = childs[i].value;
				}
			}
			editEle = Div;
		}
		ajaxGetPersonalItems(memberId);
	}
	//鼠标点击其他区域时取消编辑框,并恢复旧数据
	var oldName;
	var oldPhone;
	function cancelEdit(memDiv) {
		if (memDiv == null)
			return;
		var childs = memDiv.childNodes;
		if (childs != null && childs.length > 0) {
			for (var i = childs.length - 1; i >= 0; i--) {
				if (childs[i].name == "name") {
					childs[i].disabled = true;
					childs[i].style.border = "0px solid #CECECE";
					childs[i].value = oldName;
				}
				if (childs[i].name == "phone") {
					childs[i].disabled = true;
					childs[i].style.border = "0px solid #CECECE";
					childs[i].value = oldPhone;
				}
			}
		}
	}
</script>
<!-- ajax请求详细信息 -->
<script type="text/javascript">
	function ajaxGetPersonalItems(memberId) {
		$.ajax({
			type : "post",
			url : "/AMA/AjaxMemberDetailServlet",
			data : {
				memberId : memberId
			},
			statusCode : {
				404 : function() {
					showSimpleNotification("请求页面发生异常！");
				}
			},
			success : function(result,status) {
				var str = result;
// 				alert(str);
                var memberItems = JSON.parse(str).memberItems;  //用这个方法可以把json字符串解析成对象。
				showPersonalItems(memberId, memberItems);
			}
		});
	}
	

	function showPersonalItems(memberId, memberItems) {
		var box = document.getElementById("detailBox");
		//标识当前是哪个成员的详细框
		var idDiv = document.createElement("input");
		idDiv.type = "hidden";
		idDiv.id = memberId;
		idDiv.name = "detailId";
		box.appendChild(idDiv);
		//先移除已有的子结点
		var childs = box.childNodes;
		if (childs != null && childs.length > 0) {
			for (var i = childs.length - 1; i >= 0; i--) {
				box.removeChild(childs[i]);
			}
		}
		var msg = document.createElement("div");
		msg.innerHTML = "持有物品：";
		msg.className = "msg";
		box.appendChild(msg);
		var items = document.createElement("div");
		items.className = "items";
		
		//判断是否有物品
		if (memberItems == null || memberItems.length < 1) {
			items.innerHTML = "无";
		} else {
			var str="";
			for (var i = 0; i < memberItems.length; i++) {
				str += memberItems[i].OName+"*"+memberItems[i].num+"<br>";
			}
			items.innerHTML = str;
		}
		box.appendChild(items);
		//添加退部时间和原因
		var msg2 = document.createElement("div");
		var outTime = getOutTimeById(memberId);
// 		alert(outTime);
		msg2.innerHTML = "退部时间：" + outTime;
		msg2.className = "msg";
		box.appendChild(msg2);
		var msg3 = document.createElement("div");
		msg3.innerHTML = "退部原因：" + getOutReasonById(memberId);
		msg3.className = "msg";
		box.appendChild(msg3);
		var br = document.createElement("br");
		box.appendChild(br);
		//添加操作
		
		if(outTime=="9999-01-01"){
			//重置密码
			var reset = document.createElement("a");
			reset.innerHTML = "重置密码";
			reset.href="javascript:void(0)";
			reset.onclick = function(){showResetPwd(memberId)};
			box.appendChild(reset);
			var changeLead = document.createElement("a");
			var isLeader = getIsLeaderById(memberId);
			if(!isLeader){
				//移交权限
				changeLead.innerHTML = "移交权限";
				changeLead.href="javascript:void(0)";
				changeLead.onclick = function(){showChangeLeader(memberId)};
				changeLead.style.float = "right";
				box.appendChild(changeLead);
			}
			//空白结点占位
			var whiteBox = document.createElement("div");
			whiteBox.className = "whiteBox";
			box.appendChild(whiteBox);
			//保存修改
			var saveButton = document.createElement("div");
			saveButton.className = "saveButton";
			saveButton.innerHTML = "保存修改";
			saveButton.onclick = function(){};
// 			box.appendChild(saveButton);
			
			if(!isLeader){
				//删除成员
				var delButton = document.createElement("div");
				delButton.className = "delButton";
				delButton.innerHTML = "删除成员";
				delButton.onclick = function(){showDel(memberId)};
				box.appendChild(delButton);
			}
		}
	}
	
	function getOutTimeById(memberId){
		if(nowMembers!=null||nowMembers.length>0){
			for(var i=0;i<nowMembers.length;i++){
				if(nowMembers[i].id==memberId)
					return nowMembers[i].outTime;
			}
		}
		if(outMembers!=null||outMembers.length>0){
			for(var i=0;i<outMembers.length;i++){
				if(outMembers[i].id==memberId)
					return outMembers[i].outTime;
			}
		}
	}
	
	function getOutReasonById(memberId){
		if(nowMembers!=null||nowMembers.length>0){
			for(var i=0;i<nowMembers.length;i++){
				if(nowMembers[i].id==memberId)
					return nowMembers[i].outReason;
			}
		}
		if(outMembers!=null||outMembers.length>0){
			for(var i=0;i<outMembers.length;i++){
				if(outMembers[i].id==memberId)
					return outMembers[i].outReason;
			}
		}
	}
	
	function getIsLeaderById(memberId){
		if(nowMembers!=null||nowMembers.length>0){
			for(var i=0;i<nowMembers.length;i++){
				if(nowMembers[i].id==memberId)
					return nowMembers[i].leader;
			}
		}
		else return false;
	}
</script>
<!-- 监听页面点击事件 -->
<script type="text/javascript">
var editEle;  //当前编辑的元素
document.onclick=function(e){
	var e = e||window.event;
	//循环检查点击的元素是否在指定div中，不在则取消编辑状态
	var temp = e.target;
	var flag = false;
	var retailBlock = document.getElementById("detailBlock");
	while(temp!=document.body){
		if(temp==editEle||temp==retailBlock){
// 			alert("6");
			flag = true;
			break;
		}
		else{
			temp = temp.parentNode;
		}
	}
	if(!flag){
		cancelEdit(editEle);
	}

}
</script>
<!-- 监听是否查看退部成员事件 -->
<script type="text/javascript">
function checkLeave(){
	var checked = document.getElementById("leave").checked;
	if(checked){
		loadMembers(outMembers);
	}
	else{
		loadMembers(nowMembers);
	}
}
</script>
<!-- 人员添加和其消息反馈 -->
<script type="text/javascript">
	function showAddMem(){
		document.getElementById('addMemberBlock').style.display='block';
		document.getElementById('fade').style.display='block';
		document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
	}
	function hideAddMem(){
		document.getElementById('addMemberBlock').style.display='none';
		document.getElementById('fade').style.display='none';
		document.body.style.overflow="";
		clearAddMem();
	}
	function clearAddMem(){
		document.getElementById('AddId').value = "";
		document.getElementById('AddName').value = "";
		document.getElementById('AddPhone').value = "";
	}
  	function checkAdd(form) {
        if (form.AddId.value == '') {
            showSimpleNotification("学号不能为空！");
            form.AddId.focus();
            return false;
        }
        if (form.AddName.value == '') {
            showSimpleNotification("姓名不能为空！");
            form.AddName.focus();
            return false;
        }
        if (form.AddPhone.value == '') {
            showSimpleNotification("电话不能为空！");
            form.AddPhone.focus();
            return false;
        }
        if (form.AddId.value.length>10) {
            showSimpleNotification("学号长度小于等于10位！");
            form.AddId.focus();
            return false;
        }
        if (form.AddName.value.length>15) {
            showSimpleNotification("姓名长度小于等于15位！");
            form.AddName.focus();
            return false;
        }
        if(!(/^[0-9]*$/.test(form.AddId.value))){
    		showSimpleNotification("学号输入有误！");
    		form.AddId.focus();
    		return false;
    	}
        if (form.AddPhone.value.length!=11) {
            showSimpleNotification("电话长度必须为11位！");
            form.AddPhone.focus();
            return false;
        }
        if(!(/^1[3|4|5|7|8]\d{9}$/.test(form.AddPhone.value))){
    		showSimpleNotification("电话输入有误！");
    		form.AddPhone.focus();
    		return false;
    	}
        return true;
    }
    
    function addCallBack(flag){
    	if(flag==0){
    		showSimpleNotification("添加成功！");
    		ajaxGetNowMembers();
    		
    	}
    	else{
    		showSimpleNotification("添加失败！");
    	}
    }
    
    //刷新已有用户
    function ajaxGetNowMembers() {
		$.ajax({
			type : "post",
			url : "/AMA/AjaxGetMembersServlet",
			data : {
			},
			statusCode : {
				404 : function() {
					showSimpleNotification("请求页面发生异常！");
				}
			},
			success : function(result,status) {
				var str = result;
// 				alert(str);
                nowMembers = JSON.parse(str).nowMembers; 
                outMembers = JSON.parse(str).outMembers;
                loadMembers(nowMembers);
			}
		});
	}



</script>
<!-- 重置密码和其消息反馈 -->
<script>
	function showResetPwd(memberId){
		document.getElementById('resetId').value = memberId;
		document.getElementById('resetPwdBlock').style.display='block';
		document.getElementById('fade').style.display='block';
		document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
	}
	function hideResetPwd(){
		document.getElementById('resetPwdBlock').style.display='none';
		document.getElementById('fade').style.display='none';
		document.body.style.overflow="";
	}
    function resetPwdCallBack(flag){
    	if(flag==0){
    		showSimpleNotification("重置成功！");
    	}
    	else{
    		showSimpleNotification("重置失败！");
    	}
    }
</script>
<!-- 删除成员 -->
<script>
	function showDel(memberId){
		document.getElementById('outId').value = memberId;
		document.getElementById('delMemberBlock').style.display='block';
		document.getElementById('fade').style.display='block';
		document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
	}
	function hideDel(){
		document.getElementById('delMemberBlock').style.display='none';
		document.getElementById('fade').style.display='none';
		document.body.style.overflow="";
		clearDel();
	}
	function checkDel(form){
	    if (form.outReasonInput.value == '') {
            showSimpleNotification("退部原因不能为空！");
            form.outReasonInput.focus();
            return false;
        }
        return true;
	}
	function clearDel(){
		document.getElementById('outReasonInput').value = "";
	}
    function delCallBack(flag){
    	if(flag==0){
    		showSimpleNotification("删除成功！");
    		ajaxGetOutMembers();
    	}
    	else{
    		showSimpleNotification("删除失败！");
    	}
    }
	//刷新离队用户
    function ajaxGetOutMembers() {
		$.ajax({
			type : "post",
			url : "/AMA/AjaxGetMembersServlet",
			data : {
			},
			statusCode : {
				404 : function() {
					showSimpleNotification("请求页面发生异常！");
				}
			},
			success : function(result,status) {
				var str = result;
                nowMembers = JSON.parse(str).nowMembers; 
                outMembers = JSON.parse(str).outMembers;
                document.getElementById("leave").checked = true;
                loadMembers(outMembers);
                var box = document.getElementById("detailBox");
				//移除已有的子结点
				var childs = box.childNodes;
					if (childs != null && childs.length > 0) {
						for (var i = childs.length - 1; i >= 0; i--) {
							box.removeChild(childs[i]);
					}	
				}
				hideDel();
			}
		});
	}
</script>
<!-- 移交权限 -->
<script type="text/javascript">
	function showChangeLeader(memberId){
		document.getElementById('oldLeaderId').value = leaderID;
		document.getElementById('newLeaderId').value = memberId;
		document.getElementById('changeLeaderBlock').style.display='block';
		document.getElementById('fade').style.display='block';
		document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
	}
	function hideChangeLeader(){
		document.getElementById('changeLeaderBlock').style.display='none';
		document.getElementById('fade').style.display='none';
		document.body.style.overflow="";
		clearChangeLeader();
	}
	function checkChangeLeader(form){
	    if (form.leaderPwd.value == '') {
            showSimpleNotification("密码不能为空！");
            form.leaderPwd.focus();
            return false;
        }
        return true;
	}
	function clearChangeLeader(){
		document.getElementById('leaderPwd').value = "";
	}
    function changeLeaderCallBack(flag){
    	if(flag==0){
    		showSimpleNotification("移交成功！");
    		setTimeout(exit,2000);
    		
    	}
    	else if(flag==-1){
    		showSimpleNotification("密码错误！");
    	}
    	else{
    		showSimpleNotification("系统出错！");
    	}
    }

</script>
<!-- 保存信息修改 -->
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
