<%@ page language="java" import="java.util.*,object.User" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>user</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta charset="utf-8">
	<link rel="stylesheet" href="/AMA/css/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="/AMA/js/jquery-1.4.4.min.js"></script>
	<script type="text/javascript" src="/AMA/js/jquery.ztree.core.js"></script>
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
				key: {
					title: "t"
				}
				
			},
			callback: {
				onClick: onClick
			}
		};

		var zNodes =[
			{ id:1, pId:0, name:"父节点1 - 展开", open:true},
			{ id:11, pId:1, name:"父节点11 - 折叠"},
			{ id:111, pId:11, name:"叶子节点111"},
			{ id:112, pId:11, name:"叶子节点112"},
			{ id:113, pId:11, name:"叶子节点113"},
			{ id:114, pId:11, name:"叶子节点114"},
			{ id:12, pId:1, name:"父节点12 - 折叠" ,isParent:true},
			{ id:121, pId:12, name:"叶子节点121"},
			{ id:122, pId:12, name:"叶子节点122"},
			{ id:123, pId:12, name:"叶子节点123"},
			{ id:124, pId:12, name:"叶子节点124"},
			{ id:13, pId:1, name:"父节点13 - 没有子节点", isParent:true},
			{ id:2, pId:0, name:"父节点2 - 折叠"},
			{ id:21, pId:2, name:"父节点21 - 展开", open:true},
			{ id:211, pId:21, name:"叶子节点211"},
			{ id:212, pId:21, name:"叶子节点212"},
			{ id:213, pId:21, name:"叶子节点213"},
			{ id:214, pId:21, name:"叶子节点214"},
			{ id:22, pId:2, name:"父节点22 - 折叠"},
			{ id:221, pId:22, name:"叶子节点221"},
			{ id:222, pId:22, name:"叶子节点222"},
			{ id:223, pId:22, name:"叶子节点223"},
			{ id:224, pId:22, name:"叶子节点224"},
			{ id:23, pId:2, name:"父节点23 - 折叠"},
			{ id:231, pId:23, name:"叶子节点231"},
			{ id:232, pId:23, name:"叶子节点232"},
			{ id:233, pId:23, name:"叶子节点233"},
			{ id:234, pId:23, name:"叶子节点234"},
			{ id:3, pId:0, name:"父节点3 - 没有子节点", isParent:true}
		];
		
		function onClick(event, treeId, treeNode, clickFlag) {
			var div = document.getElementById("showBox");
			var span = document.createElement("div");
			span.innerHTML = treeNode.id+"被点击";  
        	div.appendChild(span);  
        	
		}

		jQuery(document).ready(function(){
			jQuery.fn.zTree.init(jQuery("#ztree"), setting, zNodes);
		});
	</script>
	<script type="text/javascript">
		function checkFileExtension(file) {  
    		var validExtensions = new Array(".jpg", ".png",".jpeg",".gif");  
    		var fileExtension = file.value;  
    		alert(fileExtension);
    		if(fileExtension==null){
    			alert("null");
    			return false;
    		}
    		fileExtension = fileExtension.substring(fileExtension.lastIndexOf('.'));  
    		if (validExtensions.indexOf(fileExtension) < 0) {  
      			// Alert massage to user.  
      			alert("Only " + validExtensions.toString() + " types are allowed.");  
      			// Clean file info.  
      			file.value = "";  
      			return false;  
    		} else {  
        		return true;  
    }  
}
	</script>
    <script type="text/javascript">      
 
    	function callback(name){          
         	alert("图片上传成功");  
         	var imgNode = document.createElement("img");
         	imgNode.style.width = "200px";
         	imgNode.style.height = "200px";
         	imgNode.src = "<%=request.getContextPath()%>/img/upload/shelf/"+name;
         	document.getElementById("showImg").appendChild(imgNode);
    	}; 
    	
    	function callback2(nodes){
    		if(nodes==null)alert("null");
    		else{
    			var node = nodes[0];
    			if(node==null)alert("null2");
    			else{
    				alert(node);
    			}
    		}
    	}
        
	</script>
  </head>
  
  <body>
    This is my JSP page. <br>
    <%
    	User loginUser = (User)session.getAttribute("loginUser");
		out.println("welcome: "+loginUser.getName());
     %>
     <div id="ztree" class="ztree"></div>
     <div id="showBox" name="show">这里用来显示信息<br/></div>
     <div>
    	<form action="/AMA/UploadServlet" method="post" enctype="multipart/form-data" target="uploadFrame">
    		上传图片<input type="file" name="imgs" accept=".jpg,.gif,png" onchange="checkFileExtension(this)"/></br>
    		图片说明<input type="text" name="node"/></br>
    		<input type="submit" value="上传"/></br>
    	</form>
    	<iframe name="uploadFrame" style="display:none"></iframe>
     </div>
     <div id="showImg" name="show">这里用来显示图片<br/></div>
     
  </body>

</html>
