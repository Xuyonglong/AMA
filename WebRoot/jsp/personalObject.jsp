<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>我的物品</title>
    <link rel="icon" type="imag/x-icon" href="sy.ico" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<%@ page import="object.*"%>
<link rel="stylesheet" type="text/css" href="./css/publicTemplate.css">
<link rel="stylesheet" type="text/css"
	href="./css/notification/ns-default.css" />
<link rel="stylesheet" type="text/css"
	href="./css/notification/ns-style-growl.css" />
<script src="./js/notification/modernizr.custom.js"></script>
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
	function recordSearch(){
		window.location.href = "<%=request.getContextPath()%>/ChangeServlet";
	}
	function personalObject(){
		window.location.href = "<%=request.getContextPath()%>/PersonalObjectServlet";
	}
</script>
<style type="text/css">

#mainPart #object {
	width: 79%;
	min-width: 1050px;
	height: auto;
	border: 1px solid #DEDEDE;
	margin: 2% 10% 2% 10%;
	bottom: 0px;
	float: left;
	background-color: white;
}

#mainPart #object .myDiv {
	height: 200px;
	width: 150px;
	float: left;
	border: 2px solid #DEDEDE;
	margin: 20px 10px 20px 10px;
}

#mainPart #object .myDiv .inmyDivforImg {
	height: 170px;
	width: 150px;
	float: left;
	background: url(./img/ui/mainPage/noImage2.jpg);
}

#mainPart #object .myDiv .inmyDivforName {
	height: 30px;
	width: 150px;
	float: left;
	bottom: 0px;
	background-color: #CBCBCB;
}

#mainPart #object .myDiv .inmyDivforName p {
	height: 25px;
	width: 150px;
	float: left;
	bottom: 0px;
	margin: 4px 0% 0% 1px;
	text-align: center;
	font: "等线";
	font-size: 15px;
}

#mainPart #object .myDiv .inmyDivforImg .invisibleDiv {
	height: 170px;
	width: 150px;
	float: left;
	-moz-opacity: 0.8;
	opacity: .80;
	filter: alpha(opacity = 80);
}

.invisibleA {
	font-family: "等线";
	font-size: 20px;
	color: white;
	float: left;
	border: 1px solid white;
	margin-left: 55px;
	margin-top: 70px;
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
	width: 230px;
	height: auto;
	padding: 10px;
	background-color: white;
	z-index: 992;
	min-width: 200px;
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
	min-width: 250px;
}

/* .white_content #inBox #landr { */
/* 	width: 280px; */
/* 	height: 150px; */
/* 	margin: 0 0 0 0; */
/* } */

.white_content #inBox #leftDiv {
	float: left;
	width: 200px;
	height: 70px;
	margin-left: 0px;
	margin-top: 0px;
}


.white_content #inBox #rightDiv {
	float: left;
	width: 145px;
	margin-top: 0px;
	margin-left: 10px;
	height: 26px;
}

.white_content #inBox #rightDiv #addButton{
	float:left;
	width: 25px;
	height:25px;
	background: url(./img/ui/mainPage/add.png);
	border:0;
}

.white_content #inBox #rightDiv #subButton{
	float:left;
	width: 25px;
	height:25px;
	background: url(./img/ui/mainPage/sub.png);
	border:0;
}

.white_content #inBox #buttonDiv {
	float: left;
	width: 250px;
	margin-top: 0px;
	margin-left: 0px;
}

.white_content #inBox #rightDiv #number{
	float:left;
	height: 25px;
	width: 50px;
	text-align: center;
}

.white_content #inBox #confirm {
	margin-left: 10px;
	margin-top: 10px;
	height: 37px;
	width: 100px;
	background-color: #668be0;
	border: 0;
	color: white;
	cursor: pointer;
	outline: none;
}
</style>
	<script type="text/javascript">
		var arr = [
	<%ArrayList<PersonObject> po = (ArrayList<PersonObject>) (session
					.getAttribute("PersonObject"));
			if (po.size() > 0) {
				out.print("[");
				out.print("'" + po.get(0).getPId() + "','");
				out.print(po.get(0).getOId() + "','");
				out.print(po.get(0).getOName() + "','");
				out.print(po.get(0).getShelfId() + "','");
				out.print(po.get(0).getShelfName() + "','");
				out.print(po.get(0).getNum() + "','");
				out.print(po.get(0).getImgPath() + "']");
				for (int i = 1; i < po.size(); i++) {
					out.print(",['");
					out.print(po.get(i).getPId() + "','");
					out.print(po.get(i).getOId() + "','");
					out.print(po.get(i).getOName() + "','");
					out.print(po.get(i).getShelfId() + "','");
					out.print(po.get(i).getShelfName() + "','");
					out.print(po.get(i).getNum() + "','");
					out.print(po.get(i).getImgPath() + "']");
				}
			}%>];
			
	    //鼠标移动到物品上
	    function onChange(i){
	        i.firstChild.style.display="block";
	        i.firstChild.style.background="#999999";
	    }
	    //鼠标离开物品
	    function outChange(i){
	        i.firstChild.style.display="none";
	        i.firstChild.style.background="white";
	    }
	    //创建div块
	    function cDiv(i){
            var oDiv=document.createElement("div");
            oDiv.id='div'+i;
            oDiv.className="myDiv"; 
            var inDivforImg = document.createElement("div");
            inDivforImg.id="inDiv"+i;
            inDivforImg.className="inmyDivforImg";
            var invisibleDiv = document.createElement("div");
            invisibleDiv.id="invD"+i;
            invisibleDiv.className = "invisibleDiv";
            invisibleDiv.style.display="none";
            invisibleDiv.innerHTML = "<a id=\""+i+"\" class=\"invisibleA\" href='javascript:void(0)' onclick=showReturnBlock(this)>归还</a>";
            inDivforImg.appendChild(invisibleDiv);
            inDivforImg.onmouseover = function(){onChange(this)};
            inDivforImg.onmouseout = function(){outChange(this)};
            oDiv.appendChild(inDivforImg);
             
            var inDivforName = document.createElement("div");
            inDivforName.className="inmyDivforName";
            var p = document.createElement("p");
            p.innerHTML = arr[i-1][2];
            inDivforName.appendChild(p);
            oDiv.appendChild(inDivforName);
            object.appendChild(oDiv);
        }
        function getIndex(i){
            var index = i.id;
            return index;
            
        }
        //移除div块
        function removeE(i){
	        var id=i; 
	        document.body.removeChild(document.getElementById('div'+id)); // 拼接 id 
        }
        //清楚归还界面的信息
        function clearReturnBox(){
 			document.getElementById("number").value = 0;
 		}
 		//展示归还界面
 		function showReturnBlock(i){
 		    var index = getIndex(i);
 		    var shelfName = arr[index-1][4];
 		    var itemName = arr[index-1][2];
			document.getElementById("userId").value = arr[index-1][0];
			document.getElementById("itemId").value = arr[index-1][1];
			document.getElementById("itemName").value = itemName;
			document.getElementById("shelfId").value = arr[index-1][3];
			document.getElementById("shelfName").value = shelfName;
			document.getElementById("maxNumber").value = arr[index-1][5];
			document.getElementById("firstP").innerHTML = "物品:"+itemName;
			document.getElementById("secondP").innerHTML = "已借数量:"+arr[index-1][5];
			document.getElementById("fourthP").innerHTML = arr[index-1][4];
			document.getElementById("light").style.display='block';
			document.getElementById("fade").style.display='block';
			document.body.style.overflow="hidden";//隐藏页面水平和垂直滚动条
		}
		//隐藏归还界面
        function hideReturnBlock(){
 			clearReturnBox();
 			document.getElementById("light").style.display='none';
			document.getElementById("fade").style.display='none';
			document.body.style.overflow="";
 	    }
 	    //+号增加数量

		function addNumber() {
			var number = parseInt(document.getElementById("number").value);
			var maxValue = parseInt(document.getElementById("maxNumber").value);
			if (number == null || number == "" || isNaN(number)) {
				number = 1;
			} else {
				if (maxValue <= number) {
					number = maxValue;
				} else {
					number++;
				}
			}
			document.getElementById("number").value = number;
		}
		//-号减少数量

		function subNumber() {
			var number = parseInt(document.getElementById("number").value);
			var maxValue = parseInt(document.getElementById("maxNumber").value);
			if (number == null || number == "" || isNaN(number)) {
				number = 1;
			} else {
				if (maxValue <= number) {
					number = maxValue;
				}
				if (number <= 0) {
					number = 0;
				} else {
					number--;
				}
			}
			document.getElementById("number").value = number;
		}
		//检查归还是否正确
		function checkReturn(form) {
			var maxValue = parseInt(document.getElementById("maxNumber").value);
			var number = parseInt(document.getElementById("number").value);
			if (number<=maxValue&&number>0) {
				return true;
			} else {
				showSimpleNotification("数目有误！");
				return false;
			}
		}
		//展示错误信息
		var isSucceed =
	<%=session.getAttribute("isSucceed")%>;
 		function showError(){
            if(isSucceed != null){
            	if(isSucceed){		   
 					showSimpleNotification("归还成功");
 				}
 				else{	   
 				 	showSimpleNotification("归还失败");
 				}
            }	
            <%session.removeAttribute("isSucceed");
              session.removeAttribute("itemName");
              session.removeAttribute("shelfName");
              session.removeAttribute("returnNum");
            %>	
 		}
 		
 		 var num = arr.length;
 		//初始化加载物品框     
		function load() {
			if (num > 0) {
				for (var i = 1; i <= num; i++) {
					cDiv(i);
				}
			}
			else{
				//没有东西的时候显示
				var	 messageNode = document.createElement("p");
				messageNode.innerHTML = "您还未借出物品。";
				messageNode.style.fontSize = "25px";
				var box = document.getElementById("object");
				box.appendChild(messageNode);
			}
			showError();
		}
		window.onload = load;
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
						<div class="name" onclick="itemSearch()" style='cursor:pointer;'>物品查询</div>
						<div class="line"></div>
					</div>
				</li>
				<%
					if(((User)session.getAttribute("loginUser")).isLeader()){
						String strLi1 = "<li><div class='label'><div class='name' style='cursor:pointer;' onclick='memberManage()'>人员管理</div><div class='line'  ></div></div></li>";
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
						<div class="name"  id='nameActive'>我的物品</div>
						<div class="line" id='lineActive'></div>
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
		<div id="object">
		</div>
	</div>	
	<!-- 内容板块结束  -->
	<div class="footer">
		<div class="help">
			<a href="/AMA/jsp/help.jsp">帮助</a>
		</div>
	</div>
	<!-- 下面是隐藏框 -->
	<div id="fade" class="black_overlay"></div>
	<div id="light" class="white_content" display:none>
		<input type="button" id="close" onclick="hideReturnBlock()" />
		<div id="inBox">
			<form action="/AMA/ReturnServlet" method="post" onsubmit="return checkReturn(this)">
				<input type="hidden"  name="type" value="return">
				<input type="hidden"  name="userId" value="" id="userId">
				<input type="hidden"  name="itemId" value="" id="itemId">
				<input type="hidden"  name="shelfId" value="" id="shelfId">
				<input type="hidden"  name="shelfName" value="" id="shelfName">
				<input type="hidden"  name="itemName" value="" id="itemName">
				<div id="leftDiv">
					<p id="firstP"></p>
					<p id="secondP"></p>
					<p id="thirdP">归还到:<span id="fourthP"></span></p>
					
				</div>
				<div id="rightDiv">
					<span id="numberBox">
					<input type="button" id="subButton" onclick="subNumber()">
					<input type=" text" id="number" value="0" name="number"
						onkeyup="this.value=this.value.replace(/\D/g,'')" 
						onafterpaste="this.value=this.value.replace(/\D/g,'')">
					<input type="button" id="addButton" onclick="addNumber()">
					</span>
					&nbsp&nbsp
					<span id="maxNumber"></span>
			    </div>
			   <div id="buttonDiv">
			   		<button class = "button" id="confirm" type = "submit" value = "submit">确认</button>
			   </div>
			</form>
		</div>
	</div>
  </body>
  <script type="text/javascript">
  	
  </script>
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
