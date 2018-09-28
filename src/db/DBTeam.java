package db;

import java.util.ArrayList;

import object.LeafNode;
import object.Member;
import object.PersonObject;
import object.ShelfNode;
import object.SupNode;

public class DBTeam {
	// 成员获取货架、物品信息所需方法

	// 调用DBUtil方法的对象
	public DBUtil DBUtil = null;

	public DBTeam() {
		DBUtil = new DBUtil();
	}

	/*
	 * 获取所有货架和物品
	 */
	public ArrayList<SupNode> getNodes() {
		ArrayList<SupNode> supArr = new ArrayList<SupNode>();

		// 获取货架信息
		String shelf_sql = "select * from L where l_no != 1;";
		ArrayList<ArrayList<String>> shelfArr = DBUtil.getResult(
				DBUtil.getRs(shelf_sql), 5);

		if (shelfArr != null && shelfArr.size() > 0) {
			for (int i = 0; i < shelfArr.size(); i++) {
				String id = shelfArr.get(i).get(0);
				String pId = shelfArr.get(i).get(4);
				String name = shelfArr.get(i).get(1);
				String imgPath = shelfArr.get(i).get(2);
				String describe = shelfArr.get(i).get(3);
				supArr.add(new ShelfNode(id, pId, name, imgPath, describe));
			}
		}

		// 获取物品信息
		String leaf_sql = "select O.o_no,l_no,o_name,o_nickname,o_total,o_leftnum,"
				+ "o_guide,o_use,o_notice from O,OL where O.o_no = OL.o_no;";
		ArrayList<ArrayList<String>> leafArr = DBUtil.getResult(
				DBUtil.getRs(leaf_sql), 9);

		if (leafArr != null && leafArr.size() > 0) {
			for (int i = 0; i < leafArr.size(); i++) {
				String id = leafArr.get(i).get(0);
				String location = leafArr.get(i).get(1);
				String name = leafArr.get(i).get(2);
				String nickName = leafArr.get(i).get(3);
				int totalNumber = Integer.valueOf(leafArr.get(i).get(4));
				int restNumber = Integer.valueOf(leafArr.get(i).get(5));
				String useHelp = leafArr.get(i).get(6);
				String usePurpose = leafArr.get(i).get(7);
				String tip = leafArr.get(i).get(8);
				supArr.add(new LeafNode(id, location, name, nickName,
						totalNumber, restNumber, useHelp, usePurpose, tip));
			}
		}
		return supArr;
	}

	/*
	 * 获取所有成员,不包括管理员,包括退部人员
	 */
	public ArrayList<Member> getMembers(){
		ArrayList<Member> member = new ArrayList<Member>();
		String sql = "select tm_sno,tm_name,tm_phone,tm_status,in_date,out_date,out_reason from TM where tm_status != '2';";
		ArrayList<ArrayList<String>> memberArr = DBUtil.getResult(
				DBUtil.getRs(sql), 7);
		if( memberArr != null && memberArr.size() > 0 ){
			for(int i=0;i<memberArr.size();i++){
				String id = memberArr.get(i).get(0);
				String name = memberArr.get(i).get(1);
				String phone = memberArr.get(i).get(2);
				int tempStatus = Integer.valueOf(memberArr.get(i).get(3));
				boolean isLeader = false;
				if(tempStatus == 1){
					isLeader = true;
				}
				String inTime = memberArr.get(i).get(4);
				String outTime = memberArr.get(i).get(5);
				String outReason = memberArr.get(i).get(6);
				member.add(new Member(id,name,phone,isLeader,inTime,outTime,outReason));
			}
		}
		return member;
	}

	/*
	 * 添加用户
	 */
	public boolean addMember(String id,String name,String phone){
		boolean isSucceed = false;
		String inDate = DBUtil.getDate();
		String checksql = "select tm_sno from TM where tm_sno = '"+id+"';"; 
		ArrayList<ArrayList<String>> tempArr = DBUtil.getResult(
				DBUtil.getRs(checksql), 1);
		if(tempArr != null && tempArr.size()>0){
			isSucceed = false;
		}
		else{//数据库中没有当前添加的用户
			String sql = "insert into TM(tm_sno,tm_name,tm_phone,in_date) values('"+id+"','"+name+"','"+phone+"','"+inDate+"');";
			String nowTime = DBUtil.getTime();
			String nowDate = DBUtil.getDate();
			String mcSQL = "insert into MC values('"+nowTime+"','"+id+"','2','"+nowDate+"');";
			if(DBUtil.executeSQL(sql) == 1 && DBUtil.executeSQL(mcSQL) == 1){
				isSucceed = true; 
			}
		}
			
		return isSucceed;
	}
	
	/*
	 * 删除用户
	 */
	public boolean deleteMember(String id,String outReason){
		boolean isSucceed = false;
		String nowDate = DBUtil.getDate();
		String nowTime = DBUtil.getTime();
		String checksql = "select tm_sno from TM where tm_sno = '"+id+"' and out_date = '9999-01-01';";
		ArrayList<ArrayList<String>> tempArr = DBUtil.getResult(
				DBUtil.getRs(checksql), 1);
		if(tempArr != null && tempArr.size()>0){//数据库中有当前要删除的用户
			String sql = "update TM set out_date = '"+nowDate+"',out_reason = '"+outReason+"' where tm_sno = '"+id+"';";
			String insert_sql = "insert into MC values('"+nowTime+"','"+id+"','1','"+nowDate+"');";
			if(DBUtil.executeSQL(sql) == 1 && DBUtil.executeSQL(insert_sql) ==1 ){
				isSucceed =true;
			}
		}	
		return isSucceed;
	}
	
	/*
	 * 模糊搜索物品,匹配字符越多排位越靠前
	 */
	public ArrayList<LeafNode> getLeafNodes(String queryString) {
		ArrayList<LeafNode> leafArr = new ArrayList<LeafNode>();// 存储最终返回结果
		String queryArr[] = queryString.split("\\s+");// 去除空格

		class ObjectRange {// 用于存储物品及对应查询出的顺序的索引的内部类
			private int index;// 先直接查找所有物品，按先后顺序形成物品索引
			private int range;// 物品的匹配度
			private String obj_str;// 物品所有信息组合的字符串

			public ObjectRange(int index, String obj_str) {
				this.index = index;
				this.range = 0;// 匹配度默认为0
				this.obj_str = obj_str;
			}

			public int getIndex() {
				return this.index;
			}

			public int getRange() {
				return this.range;
			}

			public String getLeafObj() {
				return this.obj_str;
			}

			public int getStrTokenNum(int end) {// 获取当前位置是物品表的第几个字段
				int num = 0;
				for (int i = 0; i < end; i++) {
					if (this.obj_str.charAt(i) == '?') {
						num++;
					}
				}
				return num;
			}

			public void setRange(int range) {
				this.range += range;
			}
		}

		if (queryArr != null && queryArr.length > 0) {
			// 首先搜索所有物品，存放地点的同类物品视为不同
			String leaf_sql = "select O.o_no,OL.l_no,o_name,o_nickname,o_total,o_leftnum,"
					+ "o_guide,o_use,o_notice,l_name from O,OL,L where O.o_no = OL.o_no and OL.l_no = L.l_no;";
			ArrayList<ArrayList<String>> tempArr = DBUtil.getResult(
					DBUtil.getRs(leaf_sql), 10);
			ArrayList<LeafNode> tempLeafStr = new ArrayList<LeafNode>();// 记录所有物品
			ArrayList<ObjectRange> objectArr = new ArrayList<ObjectRange>();// 记录物品和对应搜索顺序索引

			if (tempArr != null && tempArr.size() > 0) {
				for (int i = 0; i < tempArr.size(); i++) {
					String id = tempArr.get(i).get(0);
					String location = tempArr.get(i).get(9);
					String name = tempArr.get(i).get(2);
					String nickName = tempArr.get(i).get(3);
					int totalNumber = Integer.valueOf(tempArr.get(i).get(4));
					int restNumber = Integer.valueOf(tempArr.get(i).get(5));
					String useHelp = tempArr.get(i).get(6);
					String usePurpose = tempArr.get(i).get(7);
					String tip = tempArr.get(i).get(8);
					String temp = "?" + name + "?" + location + "?" + id + "?"
							+ nickName + "?"
							+ totalNumber// 物品所有信息的合成字符串
							+ "?" + restNumber + "?" + useHelp + "?"
							+ usePurpose + "?" + tip;
					LeafNode leafNode = new LeafNode(id, location, name,
							nickName, totalNumber, restNumber, useHelp,
							usePurpose, tip);
					tempLeafStr.add(leafNode);
					objectArr.add(new ObjectRange(i, temp));
				}
				// 计算每个物品结点匹配度
				for (int i = 0; i < queryArr.length; i++) {
					for (int j = 0; j < objectArr.size(); j++) {
						if (objectArr.get(j).getLeafObj().indexOf(queryArr[i]) != -1) {// 如果包含查询字符串中的字符
							// 匹配成功匹配度增加,在前面的搜索字段具有更高的优先级
							objectArr.get(j).setRange(((queryArr.length - i) * 9 - objectArr.get(j).getStrTokenNum(objectArr.get(j).getLeafObj().indexOf(queryArr[i]))));
						}
					}
				}
				// 按匹配度从高到低存储
				for (int i = 0; i < tempLeafStr.size(); i++) {
					for (int j = 0; j < objectArr.size(); j++) {
						if (objectArr.get(j).getRange() > objectArr.get(0)
								.getRange()) {
							ObjectRange tempObj = objectArr.get(j);
							objectArr.set(j, objectArr.get(0));
							objectArr.set(0, tempObj);
						}
					}
					// 每次取出匹配度最高的物品结点
					if (objectArr.get(0).getRange() > 0) {
						leafArr.add(tempLeafStr
								.get(objectArr.get(0).getIndex()));
						objectArr.remove(0);
					}
				}
			}
		}
		return leafArr;
	}

	/*
	 * 获取个人拥有的物品
	 */
	public ArrayList<PersonObject> getMyLeafNodes(String id) {
		ArrayList<PersonObject> leafArr = new ArrayList<PersonObject>();// 返回查询结果

		String sql = "select tm_sno,MO.o_no,o_name,mo_num,mo_date,OL.l_no,l_name from O,MO,OL,L where O.o_no = MO.o_no and O.o_no = OL.o_no and OL.l_no = L.l_no and tm_sno = '"
				+ id + "';";
		ArrayList<ArrayList<String>> tempArr = DBUtil.getResult(
				DBUtil.getRs(sql), 7);
		if (tempArr != null && tempArr.size() > 0) {
			for (int i = 0; i < tempArr.size(); i++) {
				String pId = tempArr.get(i).get(0);
				String oId = tempArr.get(i).get(1);
				String oName = tempArr.get(i).get(2);
				int num = Integer.valueOf(tempArr.get(i).get(3));
				String date = tempArr.get(i).get(4);
				String shelfId = tempArr.get(i).get(5);
				String shelfName = tempArr.get(i).get(6);
				leafArr.add(new PersonObject(pId,oId,oName,shelfId,shelfName,num,date));
			}
		}
		return leafArr;
	}

	
	/*
	 * 借出物品
	 */
	public boolean borrowItems(String userId, String itemId, String shelfId, String number){
		boolean success = false;
		String sql = "select O.o_no,l_no,o_leftnum from O,OL where O.o_no = OL.o_no and O.o_no = "+itemId+" and l_no = "+shelfId+";";
		ArrayList<ArrayList<String>> itemArr = DBUtil.getResult(DBUtil.getRs(sql),3);
		if( itemArr != null && itemArr.size() > 0){
			if( Integer.valueOf(itemArr.get(0).get(2)) >= Integer.valueOf(number)){
				//更新物品数量
				String update_sql = "update O set o_leftnum = (o_leftnum-"+number+") where o_no ="+itemId+";";
				int success1 = DBUtil.executeSQL(update_sql);
				//插入物品操作记录
				String nowTime = DBUtil.getTime();
				String nowDate = DBUtil.getDetailedDate();
				String insertRecord1 = "insert into OI values('"+nowTime+"','"+userId+"',"+itemId+","+number+",'2','"+nowDate+"');";
				int success2 = DBUtil.executeSQL(insertRecord1);
				//插入我的物品记录
				int success3 = 0;
				String query = "select tm_sno,o_no from MO where tm_sno = '"+userId+"' and o_no ="+itemId+";";
				ArrayList<ArrayList<String>> myOArr = DBUtil.getResult(DBUtil.getRs(query),2);
				if(myOArr != null && myOArr.size() > 0){
					String updateMo = "update MO set mo_num = (mo_num +"+number+") where tm_sno = '"+userId+"' and o_no = "+itemId+";";
					success3 = DBUtil.executeSQL(updateMo);
				}
				else{
					String insertRecord2 = "insert into MO values('"+userId+"',"+itemId+","+number+",'"+nowDate+"');";
					success3 = DBUtil.executeSQL(insertRecord2);
				}
							
				if( success1 == 1 && success2 ==1 && success3 ==1 ){
					success = true;
				}
				
			}
		}
		return success;
	}
	
	
	/*
	 * 归还物品
	 */
	public boolean returnObj(String uId,String oId,int oNum){
		boolean success = false;
		String searchMo = "select tm_sno,o_no,mo_num from MO where tm_sno = '"+uId+"' and o_no = "+oId+";";
		ArrayList<ArrayList<String>> tempArr = DBUtil.getResult(DBUtil.getRs(searchMo),3);
		if(tempArr != null && tempArr.size() > 0){
			if(Integer.valueOf(tempArr.get(0).get(2)) >= oNum){
				String updateO = "update O set o_leftnum = (o_leftnum+"+oNum+") where o_no = "+oId+";";
				String time = DBUtil.getTime();
				String date = DBUtil.getDetailedDate();
				String insert_sql = "insert into OI values('"+time+"','"+uId+"',"+oId+","+oNum+",3,'"+date+"');";
				String updateMo = "update MO set mo_num = (mo_num-"+oNum+") where o_no = "+oId+";";
				String deleteMo = "delete from MO where mo_num = 0;";
				int success1 = DBUtil.executeSQL(updateO);
				int success2 = DBUtil.executeSQL(insert_sql);
				int success3 = DBUtil.executeSQL(updateMo);
				int success4 = DBUtil.executeSQL(deleteMo);
				if(success1 == 1 && success2 == 1 && success3 == 1 && success4 == 1){
					success =true;
				}
			}
		}		
		return success;
	}

}
