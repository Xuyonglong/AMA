	//分别可以控制消息内容，上边距和左边距，底色，文字颜色，显示时长
	//右上角的close需要找 ns-style-growl.css 的
	/**
	*	.ns-effect-jelly .ns-close::before,
	*	.ns-effect-jelly .ns-close::after {
	*		background: #5699bc;
	*	}
	*    进行静态修改
	*/

	function showNotification(msg, topValue, leftValue, bgColor, textColor, ttlV){
		 {		
			 	//移除已有的提示框
			 	var noteDiv = document.getElementById('myNoteDiv');
			 	if(noteDiv!=null){
			 		document.body.removeChild(noteDiv);
			 	}
				// create the notification
				var notification = new NotificationFx({
					message : '<p>'+msg+'</p>',
					layout : 'growl',
					effect : 'jelly',
					type : 'notice', // notice, warning, error or success
					ttl : (ttlV!=null?ttlV:'4000'),
					bgColorOfDiv: (bgColor!=null?bgColor:'#97d2f1'),
					fontColor: (textColor!=null?textColor:'white'),
					topV: (topValue!=null?topValue:'30%'),
					leftV: (leftValue!=null?leftValue:'45%'),
					idFlag: 'myNoteDiv',
				});
				// show the notification
				notification.show();

			}
	}
	
	function showSimpleNotification(msg){
		showNotification(msg, '30%', '45%', '#97d2f1', 'white', '3000');
	}
	
	