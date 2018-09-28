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
<title>物品查询</title>
<link rel="icon" type="imag/x-icon" href="sy.ico" />
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page import="object.*"%>
<link rel="stylesheet" type="text/css" href="./css/publicTemplate.css">
<link rel="stylesheet" type="text/css" href="./css/notification/ns-default.css" />
<link rel="stylesheet" type="text/css" href="./css/notification/ns-style-growl.css" />
<link rel="stylesheet" href="/AMA/css/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="/AMA/css/itemSearch.css" type="text/css">
<script type="text/javascript" src="/AMA/js/public.js"></script>
<script type="text/javascript" src="/AMA/js/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="/AMA/js/jquery.ztree.core.js"></script>
<script src="./js/notification/modernizr.custom.js"></script>
<script src="./js/ArrayListClass.js"></script>
<script src="./js/NodesClass.js"></script>
<script type="text/javascript">
	var userId = <%=  ((User)session.getAttribute("loginUser")).getId()%>;
	function setInfo(){
		window.location.href = "<%=request.getContextPath()%>/InfoServlet";
	}
	function exit(){
		window.location.href = "<%=request.getContextPath()%>/ExitServlet";
	}	
	function recordSearch(){
		window.location.href = "<%=request.getContextPath()%>/ChangeServlet";
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
	var lArr = [
		<%
			ArrayList<LeafNode> leafNodes = (ArrayList<LeafNode>)(session.getAttribute("leafNodes"));
			if(leafNodes!=null&&leafNodes.size()>0){
				for(int i=0;i<leafNodes.size();i++){
					LeafNode node = leafNodes.get(i);
					out.print("['"+node.getId()+"','"+node.getName()+"','"+node.getPId()+"',");
					out.print("'"+node.getNickName()+"','"+node.getTotalNumber()+"','"+node.getRestNumber()+"',");
					out.print("'"+node.getUseHelp()+"','"+node.getUsePurpose()+"','"+node.getTip()+"']");
					if(i!=leafNodes.size()-1){
						out.print(",");
					}
				}
			}
		%>
	];
	var sArr = [
		<%
			ArrayList<ShelfNode> shelfNodes = (ArrayList<ShelfNode>)(session.getAttribute("shelfNodes"));
			if(shelfNodes!=null&&shelfNodes.size()>0){
				for(int i=0;i<shelfNodes.size();i++){
					ShelfNode node = shelfNodes.get(i);
					out.print("['"+node.getId()+"','"+node.getName()+"','"+node.getPId()+"',");
					out.print("'"+node.getImgPath()+"','"+node.getDescribe()+"']");
					if(i!=shelfNodes.size()-1){
						out.print(",");
					}
				}
			}
		%>
	];
	//将二维数组的值生成对象保存到ArrayList
	var lSize = <%= leafNodes.size()%>;
	var lN = 9;
	var sSize = <%= shelfNodes.size()%>;
	var sN = 5;
	var lNodes = new ArrayList();
	var sNodes = new ArrayList();
	
	initNodes(lArr,lNodes,lSize,lN);
	initNodes(sArr,sNodes,sSize,sN);
	
</script>
<!-- ztree树 -->
<script type="text/javascript">
		var setting = {
			view: {
				selectedMulti: false,
				showLine: false,
				showIcon: false,
			},
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "pId",
					rootPId: 0
				},			
			},
			callback: {
				onClick: ztreeClick,
				onExpand: ztreeOnExpand,
				onCollapse: ztreeOnCollapse
			}
		};
		var zNodes =[
			{ id:1, pId:0, name:"所有货架", open:true},
		<%
			for(int i=0;i<shelfNodes.size();i++){
				ShelfNode node = shelfNodes.get(i);
				out.print("{id:"+node.getId()+",pId:"+node.getPId()+",name:'"+node.getName()+"'},");
			}
		%>
		];
		
		function ztreeClick(event, treeId, treeNode, clickFlag) {		
			//添加详细div
			var retailBox = document.getElementById("detailBox");
			var childs = retailBox.childNodes;
			if(childs != null && childs.length>0){
				for(var i = childs.length - 1; i >= 0; i--) {  
    				retailBox.removeChild(childs[i]);  
				}  
			}
			var subNode = createDetailDivById(treeNode.id,5);
			if(subNode!=null)retailBox.appendChild(subNode);
			//添加物品div
			var box = document.getElementById("resultBox");
			//先移除已有的子结点
			childs = box.childNodes;
			if(childs != null && childs.length>0){
				for(var i = childs.length - 1; i >= 0; i--) {  
    				box.removeChild(childs[i]);  
				}  
			}
			//添加其包含的物品子结点
			if(lNodes==null||lNodes.size()<1){
				alert("error");
			}
			else{
				for(var i=0;i<lNodes.size();i++){
					var node = lNodes.get(i);
					if(node.pId==treeNode.id){
						resultDiv = createResultDivByNode(node);
						if(resultDiv!=null)box.appendChild(resultDiv);
					}
				}

			}
		}
		//通过cookie保存展开状态
		var expandStates = [];
		function ztreeOnExpand(event, treeId, treeNode) {
			if(expandStates.indexOf(treeNode.id)==-1){
				expandStates.push(treeNode.id);
			}
			
		}
		function ztreeOnCollapse(event, treeId, treeNode) {
			var index = expandStates.indexOf(treeNode.id); 
			if (index > -1)expandStates.splice(index, 1); 
		}	

		jQuery(document).ready(function(){
			jQuery.fn.zTree.init(jQuery("#mytree"), setting, zNodes);
			readCookie();
			showBorrowFlag();
		});
</script>
<!-- 动态创建结果框的div和详细信息的div -->
<script>
function createResultDivByNode(lNode) {
	var resultDiv = document.createElement("div");
	resultDiv.id = lNode.id;
	resultDiv.className = "resultItem";
	resultDiv.onmouseover = function() {
		this.style.color = "blue";
	};
	resultDiv.onmouseout = function() {
		this.style.color = "black";
	};
	// 先显示物品名字
	var str = "<span class='itemName' style='cursor:pointer;' onclick='showItemDetail("
			+ lNode.id + ")'>&nbsp" + lNode.name + "</span>";
	// 从底向上寻找位置名字
	str += "<span class='itemLocation'>";
	var pidTemp = lNode.pId;
	var pNode;
	var locationName = "";
	while (pidTemp != 1) {
		if (sNodes == null)
			break;
		for (var j = 0; j < sNodes.size(); j++) {
			if (sNodes.get(j).id == pidTemp) {
				pNode = sNodes.get(j);
				break;
			}
		}
		str += pNode.name + "&nbsp";
		locationName += pNode.name+"_";
		pidTemp = pNode.pId;
	}
	str += "</span>";
	// 添加当前数量和总数
	str += "<span class='itemNumber'>" + lNode.restNumber + "/"
			+ lNode.totalNumber + "</span>";
	// 添加借出链接
	if (lNode.restNumber > 0) {
		str += "<a href='javascript:void(0)' onclick=showBorrowBlock('"+ userId+"','"
			+lNode.id+"','"+lNode.name+"','"+lNode.restNumber+"','"
			+lNode.totalNumber+"','"+lNode.pId+"','"+locationName+"')>借出</a>";
	}
	resultDiv.innerHTML = str;
	return resultDiv;
}

function createResultDivById(ID) {
	if (lNodes == null)
		return null;
	var lNode;
	for (var i = 0; i < lNodes.size(); i++) {
		if (lNodes.get(i).id == ID) {
			lNode = lNodes.get(i);
			break;
		}
	}
	if (lNode == null)
		return null;
	return createResultDivByNode(lNode);
}

function createDetailDivByNode(node, n) {
	if (node == null)
		return null;
	// 创建物品的详细
	if (n == 9) {
		var detailDiv = document.createElement("div");
		detailDiv.id = node.id + "_9";
		detailDiv.className = "detailItemBlock";
		var str = "<p>物品编号: " + node.id + "</p>";
		str += "<p>物品名称: " + node.name + "</p>";
		str += "<p>物品俗称: " + node.nickName + "</p>";
		str += "<p>物品总数: " + node.totalNumber + "</p>";
		str += "<p>剩余数量: " + node.restNumber + "</p>";
		str += "<p>物品用途: " + node.usePurpose + "</p>";
		str += "<p>使用帮助: " + node.useHelp + "</p>";
		str += "<p>其他: " + node.tip + "</p>";
		detailDiv.innerHTML = str;
		return detailDiv;
	}
	// 创建货架的详细
	if (n == 5) {
		var detailDiv = document.createElement("div");
		detailDiv.id = node.id + "_5";
		detailDiv.className = "detailShelfBlock";
		var imagePath;
		if (detailDiv.imgPath == null) {
			imagePath = "./img/ui/mainPage/noImg.jpg";
		} else {
			imagePath = "<%=request.getContextPath()%>/img/upload/shelf/"
					+ detailDiv.imgPath;
		}
		var str = "<div class='imgBlock' style='background:url(" + imagePath
				+ ")'></div>";
		str += "<p>货架编号: " + node.id + "</p>";
		str += "<p>货架名称: " + node.name + "</p>";
		str += "<p>货架描述: " + node.describe + "</p>";
		detailDiv.innerHTML = str;
		return detailDiv;
	}
}

function createDetailDivById(ID, n) {
	// 创建物品的详细
	if (n == 9) {
		if (lNodes == null)
			return null;
		for (var j = 0; j < lNodes.size(); j++) {
			if (lNodes.get(j).id == ID) {
				return createDetailDivByNode(lNodes.get(j), n);
			}
		}
	}
	// 创建货架的详细
	if (n == 5) {
		if (sNodes == null)
			return null;
		for (var j = 0; j < sNodes.size(); j++) {
			if (sNodes.get(j).id == ID) {
				return createDetailDivByNode(sNodes.get(j), n);
			}
		}
	}
	return null;
}
// 添加物品详细div
function showItemDetail(ID) {
	var retailBox = document.getElementById("detailBox");
	var childs = retailBox.childNodes;
	if (childs != null && childs.length > 0) {
		for (var i = childs.length - 1; i >= 0; i--) {
			retailBox.removeChild(childs[i]);
		}
	}
	var subNode = createDetailDivById(ID, 9);
	if (subNode != null)
		retailBox.appendChild(subNode);
}
</script>

<script>
function showMap(){
	document.getElementById("map").style.display = "block";
}
function hideMap(){
	document.getElementById("map").style.display = "none";
}
</script>

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
						<div class="name" id="nameActive">物品查询</div>
						<div class="line" id="lineActive"></div>
					</div>
				</li>
<% if(((User)session.getAttribute("loginUser")).isLeader()){
				String strLi1 = "<li><div class='label'><div class='name' style='cursor:pointer;' onclick='memberManage()'>人员管理</div><div class='line'></div></div></li>";
				String strLi2 = "<li><div class='label'><div class='name' style='cursor:pointer;'>仓库管理</div><div class='line'></div></div></li>";
				String strLi3 = "<li><div class='label'><div class='name' onclick='recordSearch()' style='cursor:pointer;'>记录查询</div><div class='line'></div></div></li>";
				out.print(strLi1);
//				out.print(strLi2);
				out.print(strLi3);
				out.flush();
}%>
				<li>
					<div class="label">
						<div class="name" style='cursor:pointer;' onclick="personalObject()">我的物品</div>
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
	<div id="mainPart" style="min-width:1311px;">
		<iframe name="hiddenFrame" style="display:none"></iframe>
		<div id="searchBlock">
			<div id="searchBox">
				<form action="/AMA/ItemHandingServlet" method="post" onsubmit="return checkSearch(this)" target="hiddenFrame">
					<input type="hidden"  name="type" value="search">
					<input type="text" placeholder=" 查找"  id="searchInput" name="searchInput"/>
					<button id="searchButton" class = "button" type = "submit" value = "submit"></button>
				</form>
			</div>
		</div>
		<div id="treeBlock">
			<div id="mytree" class="ztree"></div>	
		</div>	
		<div id="resultBlock">
			<div id="resultBox"></div>
			<div id="mapMsg"><a href="javascript:void(0)" onMouseOver="showMap()" onMouseOut="hideMap()">找不到房间？</a></div>
		</div>	
		<div id="map"></div>
		<div id = "detailBlock">
			<p style="font-weight:bold;">详细信息</p><br/>
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
	<div id="fade" class="black_overlay"></div>
	<div id="light" class="white_content">
		<input type="button" id="close" onclick="hideBorrowBlock()"/>
		<div id="inBox">
			<p style="font-size:20px; font-weight:bold;">物品借出</p>
			<form action="/AMA/ItemHandingServlet" method="post" onsubmit="return checkBorrow(this)">
				<input type="hidden"  name="type" value="borrow">
				<input type="hidden"  name="userId" value="" id="userId">
				<input type="hidden"  name="itemId" value="" id="itemId">
				<input type="hidden"  name="shelfId" value="" id="shelfId">
				<br/>
				<p id="msg"></p>
				<br/>
				数量:&nbsp 
				<span id="numberBox">
					<input type="button" id="subButton" onclick="subNumber()">
					<input type=" text" id="number" value="1" name="number"
						onkeyup="this.value=this.value.replace(/\D/g,'')" 
						onafterpaste="this.value=this.value.replace(/\D/g,'')">
					<input type="button" id="addButton" onclick="addNumber()">
				</span>
				&nbsp&nbspMAX:<span id="maxNumber"></span>
				<br/><br/><br/><br/>
				<button class = "button" id="confirm" type = "submit" value = "submit">确认</button>
			</form>
		</div>
	</div>
</body>
<script src="./js/notification/classie.js"></script>
<script src="./js/notification/notificationFx.js"></script>
<script src="./js/notification/showNotification.js"></script>
<script>
 	function checkSearch(form){
 		if(form.searchInput.value==""){
 			showSimpleNotification("搜索不能为空！");
 			return false;
 		}
 		return true;
 	}
 	
 	function showSearch(){
 		var length=arguments.length;
 		if(length<1)return;
 		if(length==1&&arguments[0]==-1){
 			showSimpleNotification("没有找到！");
 			return;
 		}
 		//添加物品div
		var box = document.getElementById("resultBox");
		//先移除已有的子结点
		var childs = box.childNodes;
		if(childs != null && childs.length>0){
		for(var i = childs.length - 1; i >= 0; i--) {  
    			box.removeChild(childs[i]);  
			}  
		}
		for(var i=0;i<length;i++){			
			var resultDiv = createResultDivById(arguments[i]);
			if(resultDiv!=null)box.appendChild(resultDiv);
		}
 	}
</script>
<script>
 	//弹出借出框
	function showBorrowBlock(userId,itemId,itemName,restNumber,totalNumber,pId,locationName){
		document.getElementById("userId").value = userId;
		document.getElementById("itemId").value = itemId;
		document.getElementById("shelfId").value = pId;
		document.getElementById("msg").innerHTML = locationName.replace(/_/g, " ")+" 的 " + itemName;
		document.getElementById("maxNumber").innerHTML = restNumber;
		document.getElementById("light").style.display='block';
		document.getElementById("fade").style.display='block';
		document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
	}
 	
 	function hideBorrowBlock(){
 		clearBorrowBox();
 		document.getElementById("light").style.display='none';
		document.getElementById("fade").style.display='none';
		document.body.style.overflow="";
 	}
 	
 	function addNumber(){
 		var number = parseInt(document.getElementById("number").value);
 		if(number==null||number==""||isNaN(number)){
 			number = 1;
 		}
 		else{
 		 	var maxValue = parseInt(document.getElementById("maxNumber").innerHTML);
			if(maxValue<=number){
 				number = maxValue; 
 			}
 			else{
 				number++;
 			}
 		}
 		document.getElementById("number").value = number;
 	}
 	

	function subNumber() {
		var number = parseInt(document.getElementById("number").value);
		var maxValue = parseInt(document.getElementById("maxNumber").innerHTML);
		if (number == null || number == "" || isNaN(number)) {
			number = 1;
		} else {
			if (maxValue <= number) {
				number = maxValue;
			}
			if (number <= 1) {
				number = 1;
			} else {
				number--;
			}
		}
		document.getElementById("number").value = number;
	}

	function checkBorrow(form) {
		var maxValue = parseInt(document.getElementById("maxNumber").innerHTML);
		var number = parseInt(document.getElementById("number").value);
		if (number<=maxValue&&number>0) {
			//先将当前页面保存到cookie
			saveCookie();
			return true;
		} else {
			showSimpleNotification("数目有误！");
			return false;
		}
	}

	function clearBorrowBox() {
		document.getElementById("number").value = 1;
	}
</script>
<script type="text/javascript">
	//物品借出事件，保存当前一些状态到cookie	
	function saveCookie(){
		//保存ztree展开的状态
		document.cookie = "expandStates="+JSON.stringify(expandStates);
		//保存ztree选中状态
		document.cookie = "selectedStates="+JSON.stringify(getSelectedStates());
		//保存结果框的物品
		document.cookie = "resultItems="+JSON.stringify(getResultItems());
		//保存详细框的物品
		document.cookie = "detail="+JSON.stringify(getDetail());
		//保存搜索框的文字
		document.cookie = "searchStr="+JSON.stringify(getSearchStr());
	}
	
	function getSelectedStates(){
		var treeObj = jQuery.fn.zTree.getZTreeObj("mytree");
		if(treeObj==null)return "";
		var selectedNodes = treeObj.getSelectedNodes();
		if(selectedNodes==null)return "";
		var selectedStates = [];
		for(var i=0;i<selectedNodes.length;i++){
			selectedStates.push(selectedNodes[i].id);
		}
		return selectedStates;
	}
	
	function getResultItems(){
		var box = document.getElementById("resultBox");
		childs = box.childNodes;
		if(childs==null||childs.length<=0)return "";
		var resultItems = [];
		for(var i=0;i<childs.length;i++){
			resultItems.push(childs[i].id);
		}
		return resultItems;
	}
	
	function getDetail(){
		var detailBox = document.getElementById("detailBox");
		childs = detailBox.childNodes;
		if(childs==null||childs.length<=0)return "";
		var detail = [];
		var oldId = childs[0].id;
		detail = oldId.split("_");  //前一个为id,后一个为n
		return detail;
	}
	
	function getSearchStr(){
		var str = document.getElementById("searchInput").value;
		//编码防止输入有非法字符
		var codedStr = escape(str);
		return codedStr;
	}
	
	//设置是否读取cookie
	var isReadCookie = <%= request.getParameter("isReadCookie")%>;
	//页面加载时调用
	function readCookie() {
		if (isReadCookie != null && isReadCookie == 1) {
			//恢复展开结点
			var oldExpandStates = JSON.parse(getCookie("expandStates"));
			if (oldExpandStates != null && oldExpandStates != "") {
				var treeObj = jQuery.fn.zTree.getZTreeObj("mytree");
				if (treeObj != null) {
					for (var i = 0; i < oldExpandStates.length; i++) {
						var node = treeObj.getNodeByParam("id",
								oldExpandStates[i], null);
						if (node != null){
							treeObj.expandNode(node, true,false,false,true);
						}
					}
				}

			}
			//恢复选中结点
			var oldSelectedStates = JSON.parse(getCookie("selectedStates"));
			if (oldSelectedStates != null && oldSelectedStates != "") {
				var treeObj2 = jQuery.fn.zTree.getZTreeObj("mytree");
				if (treeObj2 != null) {
					for (var i = 0; i < oldSelectedStates.length; i++) {
						var node = treeObj2.getNodeByParam("id",
								oldSelectedStates[i], null);
						if (node != null)
							treeObj2.selectNode(node, true, false);
					}
				}

			}
			//恢复结果框的物品
			var oldResultItems = JSON.parse(getCookie("resultItems"));
			if (oldResultItems != null && oldResultItems != "") {
				var box = document.getElementById("resultBox");
				if (box != null) {
					for (var i = 0; i < oldResultItems.length; i++) {
						var node = createResultDivById(oldResultItems[i]);
						if (node != null)
							box.appendChild(node);
					}
				}
			}
			//恢复详细框
			var oldDetail= JSON.parse(getCookie("detail"));
			if (oldDetail != null && oldDetail != ""&&oldDetail.length>1) {
				var box = document.getElementById("detailBox");
				if (box != null) {
					var node = createDetailDivById(oldDetail[0], oldDetail[1]);
					if (node != null)box.appendChild(node);
				}
			}
			//恢复搜索框
			var oldSearchStr= JSON.parse(getCookie("searchStr"));
			if (oldSearchStr != null && oldSearchStr != "") {
				var str = unescape(oldSearchStr);
				document.getElementById("searchInput").value = str;
			}
			isReadCookie = null;
		}
	}

	//根据名字寻找cookie
	function getCookie(c_name) {
		if (document.cookie.length > 0) {
			c_start = document.cookie.indexOf(c_name + "=");
			if (c_start != -1) {
				c_start = c_start + c_name.length + 1;
				c_end = document.cookie.indexOf(";", c_start);
				if (c_end == -1)
					c_end = document.cookie.length;
				return unescape(document.cookie.substring(c_start, c_end));
			}
		}
		return "";
	}
	
	//读取借出的提示信息
	var borrowFlag = <%= session.getAttribute("borrowFlag")%>;
	function showBorrowFlag(){
		if(borrowFlag==null)return;
		if(borrowFlag==0){
			showSimpleNotification("借出成功！");
			borrowFlag = null;
		}
		else if(borrowFlag==-1){
			showSimpleNotification("借出失败！");
			borrowFlag = null;
		}
		else {
			showSimpleNotification("系统出错！");
			borrowFlag = null;
		}
		//清空提示
		<%
			session.removeAttribute("borrowFlag");
		%>
		
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
