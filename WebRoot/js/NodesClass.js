/**
 * 两种结点在JS里的定义和初始化
 */

// 定义两种结点对象
function LNode(id, name, pId, nickName, totalNumber, restNumber, useHelp,
		usePurpose, tip) {
	this.id = id;
	this.name = name;
	this.pId = pId;
	this.nickName = nickName;
	this.totalNumber = totalNumber;
	this.restNumber = restNumber;
	this.useHelp = useHelp;
	this.usePurpose = usePurpose;
	this.tip = tip;
}
function SNode(id, name, pId, imgPath, describe) {
	this.id = id;
	this.name = name;
	this.pId = pId;
	this.imgPath = imgPath;
	this.describe = describe;
}
// 两种数组初始化
function initNodes(arr, nodes, size, n) {
	if (arr.length == 0)
		return;
	if (n == 9) {
		for (var i = 0; i < arr.length; i++) {
			var node = new LNode(arr[i][0], arr[i][1], arr[i][2], arr[i][3],
					arr[i][4], arr[i][5], arr[i][6], arr[i][7], arr[i][8]);
			nodes.add(node);
		}
	}
	if (n == 5) {
		for (var i = 0; i < arr.length; i++) {
			var node = new SNode(arr[i][0], arr[i][1], arr[i][2], arr[i][3],
					arr[i][4]);
			nodes.add(node);
		}
	}
}