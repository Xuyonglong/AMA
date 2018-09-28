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

public interface DB {
	
	/*
	 * 用户登录，用户不存在或者密码错误时返回null，成功登录返回用户对象
	 */
	public User getUser(String id, String password);
	
	/*
	 * 刷新用户信息
	 */
	public User getUser(String id);
	
	/*
	 * 添加用户
	 */
	public boolean addMember(String id,String name,String phone);
	
	/*
	 * 删除用户
	 */
	public boolean deleteMember(String id,String outReason);
	
	/*
	 * 修改密码，成功返回true,失败返回false
	 */
	public boolean setPassword(String id, String oldPwd, String newPwd);
	
	/*
	 * 重置密码，恢复为默认的111111
	 */
	public boolean resetPassword(String id);
	
	/*
	 * 修改姓名
	 */
	public boolean setName(String id, String newName);
	
	/*
	 * 修改电话
	 */
	public boolean setPhone(String id, String newPhone);
	
	/*
	 * 移交队长,成功返回0，密码错误返回-1，其他错误返回-2
	 */
	public int changeLeader(String oldLeaderId, String oldLeaderPassword,String newLeaderId);

	
	
	
	//---------------------------------------------------------------------------------------
	/*
	 * 获取所有货架和物品
	 */
	public ArrayList<SupNode> getNodes();
	
	/*
	 * 模糊搜索物品,匹配字符越多排位越靠前
	 */
	public ArrayList<LeafNode> getLeafNodes(String queryString);
	
	/*
	 * 借出物品
	 */
	public boolean borrowItems(String userId, String itemId, String shelfId, String number);

	
	//---------------------------------------------------------------------------------------
	/*
	 * 获取个人拥有的物品
	 */
	public ArrayList<PersonObject> getMyLeafNodes(String id);
	
	/*
	 * 归还物品
	 */
	public boolean returnObj(String uId,String oId,int oNum);
	
	//----------------------------------------------------------------------------------------
	/*
	 * 获取三种变动表
	 */
	public boolean getChanges(ArrayList<MemberChange> memberChanges,ArrayList<ShelfChange> shelfChanges,ArrayList<ItemChange> itemChanges);

	/*
	 * 获取所有成员,不包括管理员,包括退部人员
	 */
	public ArrayList<Member> getMembers();

	

}
