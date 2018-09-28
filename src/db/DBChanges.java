package db;

import java.util.ArrayList;

import object.ItemChange;
import object.MemberChange;
import object.ShelfChange;

public class DBChanges {
	//获取信息变动所需方法
	
	public DBUtil DBUtil = null;

	public DBChanges() {
		DBUtil = new DBUtil();
	}
	
	/*
	 * 获取三种变动表
	 */
	public boolean getChanges(ArrayList<MemberChange> memberChanges,ArrayList<ShelfChange> shelfChanges,ArrayList<ItemChange> itemChanges){
		boolean success = true;
		String searchMC = "select mc_no,MC.tm_sno,tm_name,mc_type,mc_date from MC,TM where MC.tm_sno = TM.tm_sno order by mc_date desc;";
		ArrayList<ArrayList<String>> mcArr = DBUtil.getResult(
				DBUtil.getRs(searchMC), 5);
		String searchSC = "select lc_no,LC.l_no,l_name,lc_type,lc_date from LC,L where LC.l_no = L.l_no order by lc_date desc;";
		ArrayList<ArrayList<String>> lcArr = DBUtil.getResult(
				DBUtil.getRs(searchSC), 5);
		String searchIC = "select oi_no,OI.tm_sno,tm_name,OI.o_no,o_name,oi_num,oi_type,oi_date from OI,O,TM where OI.o_no = O.o_no and OI.tm_sno = TM.tm_sno order by oi_date desc;";
		ArrayList<ArrayList<String>> icArr = DBUtil.getResult(
				DBUtil.getRs(searchIC), 8);
		if(mcArr.size() > 0){
			for(int i=0;i<mcArr.size();i++){
				String flowId = mcArr.get(i).get(0);
				String userId = mcArr.get(i).get(1);
				String userName = mcArr.get(i).get(2);
				int tempType = Integer.valueOf(mcArr.get(i).get(3));
				String type = "";
				switch(tempType){
				case 1:
					type = "退队";
					break;
				case 2:
					type = "入队";
					break;
				case 3:
					type = "升任队长";
					break;
				case 4:
					type = "卸任队长";
					break;		
				}
				String time = mcArr.get(i).get(4);
				memberChanges.add(new MemberChange(flowId,userId,userName,type,time));
			}
		}
		
		if(lcArr.size() > 0){
			for(int i=0;i<lcArr.size();i++){
				String flowId = lcArr.get(i).get(0);
				String shelfId = lcArr.get(i).get(1);
				String shelfName = lcArr.get(i).get(2);
				int tempType = Integer.valueOf(lcArr.get(i).get(3));
				String type = "";
				switch(tempType){
				case 0:
					type = "添加";
					break;
				case 1:
					type = "删除";
					break;
				}
				String time = DBUtil.formatDate(lcArr.get(i).get(4));
				shelfChanges.add(new ShelfChange(flowId,shelfId,shelfName,type,time));
			}
		}
		
		if(icArr.size() > 0){
			for(int i=0;i<icArr.size();i++){
				String flowId = icArr.get(i).get(0);
				String userId = icArr.get(i).get(1);
				String userName = icArr.get(i).get(2);
				String itemId = icArr.get(i).get(3);
				String itemName = icArr.get(i).get(4);
				String itemNumber = icArr.get(i).get(5);
				int tempType = Integer.valueOf(icArr.get(i).get(6));
				String type = "";
				switch(tempType){
				case 1:
					type = "添加";
					break;
				case 2:
					type = "借出";
					break;
				case 3:
					type = "归还";
					break;
				case 4:
					type = "损坏品丢弃";
					break;		
				}
				String time = DBUtil.formatDate(icArr.get(i).get(7));
				itemChanges.add(new ItemChange(flowId,userId,userName,itemId,itemName,itemNumber,type,time));
			}		
		}
			
		if(mcArr == null || lcArr == null || icArr == null){
			success =false;
		}
		
		return success;
	}
}
