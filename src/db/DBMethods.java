package db;

import java.util.ArrayList;

import object.ItemChange;
import object.LeafNode;
import object.Member;
import object.MemberChange;
import object.PersonObject;
import object.ShelfChange;
import object.SupNode;
import object.User;

public class DBMethods implements DB{
	//各页面所需数据库方法的集合
	
	
	//用于执行数据库方法的对象
	public DBMethods(){
		
	}
	
	//Login--------------------------------------------------------------------------------------
	 /*
     * 检索用户id和密码是否正确，验证通过创建用户对象
     */
	public User getUser(String id,String password)
    {
    	User user = null;
    	DBLogin login = new DBLogin();
    	user = login.getUser(id, password);
    	login.DBUtil.closeConnection();
    	return user;
    }
	
	/*
	 * 刷新用户信息
	 */
	public User getUser(String id){
		User user = null;
    	DBLogin login = new DBLogin();
    	user = login.getUser(id);
    	login.DBUtil.closeConnection();
    	return user;
	}
	
	/*
	 * 添加用户
	 */
	public boolean addMember(String id,String name,String phone){
		DBTeam leader = new DBTeam();
		boolean success = leader.addMember(id, name, phone);
		leader.DBUtil.closeConnection();
		return success;
	}
	
	/*
	 * 删除用户
	 */
	public boolean deleteMember(String id,String outReason){
		DBTeam leader = new DBTeam();
		boolean success = leader.deleteMember(id, outReason);
		leader.DBUtil.closeConnection();
		return success;
	}
	
	
	
	/*
	 * 修改密码，成功返回true,失败返回false
	 */
	public boolean setPassword(String id, String oldPwd, String newPwd){
		DBLogin login = new DBLogin();
		boolean success = login.setPassword(id, oldPwd, newPwd);
		login.DBUtil.closeConnection();
		return success;
	}
	
	/*
	 * 重置密码，恢复为默认的111111
	 */
	public boolean resetPassword(String id) {
		DBLogin login = new DBLogin();
		boolean success = login.resetPassword(id);
		login.DBUtil.closeConnection();
		return success;
	}
	
	/*
	 * 修改姓名和电话，成功返回true，失败返回false
	 */
	public boolean setNameAndPhone(String id, String newName, String newPhone){
		DBLogin login = new DBLogin();
		boolean success = login.setNameAndPhone(id, newName, newPhone);
		login.DBUtil.closeConnection();
		return success;
	}
	
	
	/*
	 * 修改姓名
	 */
	public boolean setName(String id, String newName) {
		DBLogin login = new DBLogin();
		boolean success = login.setName(id, newName);
		login.DBUtil.closeConnection();
		return success;
	}

	/*
	 * 修改电话
	 */
	public boolean setPhone(String id, String newPhone) {
		DBLogin login = new DBLogin();
		boolean success = login.setPhone(id, newPhone);
		login.DBUtil.closeConnection();
		return success;
	}
	
	/*
	 * 移交队长,成功返回0，密码错误返回-1，其他错误返回-2
	 */
	public int changeLeader(String oldLeaderId, String oldLeaderPassword,String newLeaderId){
		DBLogin login = new DBLogin();
		int flag = login.changeLeader(oldLeaderId, oldLeaderPassword, newLeaderId);
		login.DBUtil.closeConnection();
		return flag;
	}

	
	//Team----------------------------------------------------------------------------------
	
	/*
	 * 获取所有货架和物品
	 */
	public ArrayList<SupNode> getNodes(){
		DBTeam leader = new DBTeam();
		ArrayList<SupNode> supArr = leader.getNodes();
		leader.DBUtil.closeConnection();
		return supArr;
	}
	
	/*
	 * 获取所有成员,不包括管理员,包括退部人员
	 */
	public ArrayList<Member> getMembers(){
		DBTeam leader = new DBTeam();
		ArrayList<Member> memberArr = leader.getMembers();
		leader.DBUtil.closeConnection();
		return memberArr;
	}
	
	/*
	 * 模糊搜索物品,匹配字符越多排位越靠前
	 */
	public ArrayList<LeafNode> getLeafNodes(String queryString){
		DBTeam leader = new DBTeam();
		ArrayList<LeafNode> LeafNode = leader.getLeafNodes(queryString);
		leader.DBUtil.closeConnection();
		return LeafNode;
	}
	
	/*
	 * 借出物品
	 */
	public boolean borrowItems(String userId, String itemId, String shelfId, String number){
		DBTeam team = new DBTeam();
		boolean success = team.borrowItems(userId, itemId, shelfId, number);
		team.DBUtil.closeConnection();
		return success;
	}
	
	/*
	 * 获取个人拥有的物品
	 */
	public ArrayList<PersonObject> getMyLeafNodes(String id){
		DBTeam team = new DBTeam();
		ArrayList<PersonObject> LeafNode = team.getMyLeafNodes(id);
		team.DBUtil.closeConnection();
		return LeafNode;
	}
	
	/*
	 * 归还物品
	 */
	public boolean returnObj(String uId,String oId,int oNum){
		DBTeam team = new DBTeam();
		boolean success = team.returnObj(uId, oId, oNum);
		team.DBUtil.closeConnection();
		return success;
	}
	
	//-----------------------------------------------------------------------------
	/*
	 * 获取三种变动表
	 */
	public boolean getChanges(ArrayList<MemberChange> memberChanges,ArrayList<ShelfChange> shelfChanges,ArrayList<ItemChange> itemChanges){
		DBChanges change = new DBChanges();
		boolean success = change.getChanges(memberChanges, shelfChanges, itemChanges);
		change.DBUtil.closeConnection();
		return success;
	}

}
