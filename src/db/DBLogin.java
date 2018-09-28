package db;

import java.util.ArrayList;


import object.User;

public class DBLogin {
	// 用户信息所需方法

	// 调用DBUtil方法的对象
	public DBUtil DBUtil = null;

	public DBLogin() {
		DBUtil = new DBUtil();
	}
	
	//记录队长信息变动
	private void recordLeaderChange(String oldLeaderId,String newLeaderId){
		String old_no = DBUtil.getTime(); 
	    String old_date = DBUtil.getDate();
	    String oldLeaderValue = "'"+old_no+"','"+oldLeaderId+"','4','"+old_date+"'"; 
	    String old_sql = "insert into MC(mc_no,tm_sno,mc_type,mc_date) values("+oldLeaderValue+");";
	    DBUtil.executeSQL(old_sql);   
	    
	    String new_no = DBUtil.getTime();
	    String new_date = DBUtil.getDate();
	    String newLeaderValue = "'"+new_no+"','"+newLeaderId+"','3','"+new_date+"'"; 
	    String new_sql = "insert into MC(mc_no,tm_sno,mc_type,mc_date) values("+newLeaderValue+");";
	    DBUtil.executeSQL(new_sql);
	}
	

	/*
	 * 检索用户id和密码是否正确，验证通过创建用户对象
	 */
	public User getUser(String id, String password) {
		User user = null;
		String sql = "select tm_sno,tm_pwd,tm_name,tm_phone,tm_status from TM where tm_sno = '"
				+ id + "' and out_date ='9999-01-01';";

		ArrayList<ArrayList<String>> arr = DBUtil.getResult(DBUtil.getRs(sql),
				5);

		if (arr != null && arr.size() > 0) {
			for (int i = 0; i < arr.size(); i++) {
				String pwdInDB = arr.get(i).get(1);
				if (pwdInDB.equals(password)) {
					String u_name = arr.get(i).get(2);
					String u_phone = arr.get(i).get(3);
					String leader = arr.get(i).get(4);
					boolean is_leader = false;
					if (leader.equals("1") || leader.equals("2")) {
						is_leader = true;
						// System.out.println("队长好!");
					}
					user = new User(id, u_name, u_phone, is_leader);
				}
			}
		}
		return user;
	}

	/*
	 * 刷新用户信息
	 */
	public User getUser(String id) {
		User user = null;
		String sql = "select tm_sno,tm_name,tm_phone,tm_status from TM where tm_sno = '"
				+ id + "';";

		ArrayList<ArrayList<String>> arr = DBUtil.getResult(DBUtil.getRs(sql),
				4);

		if (arr != null && arr.size() > 0) {
			for (int i = 0; i < arr.size(); i++) {
				String u_name = arr.get(i).get(1);
				String u_phone = arr.get(i).get(2);
				String leader = arr.get(i).get(3);
				boolean is_leader = false;
				if (leader.equals("1") || leader.equals("2")) {
					is_leader = true;
				}
				user = new User(id, u_name, u_phone, is_leader);
			}
		}
		return user;
	}
	

	/*
	 * 修改密码，成功返回true,失败返回false
	 */
	public boolean setPassword(String id, String oldPwd, String newPwd) {
		boolean success = false;
		String sql = "select tm_sno,tm_pwd from TM where tm_sno = '" + id
				+ "';";
		ArrayList<ArrayList<String>> arr = DBUtil.getResult(DBUtil.getRs(sql),
				2);
		if (arr.size() > 0) {
			if (arr.get(0).get(1).equals(oldPwd)) {// 密码正确才能修改
				String update_sql = "update TM set tm_pwd = '" + newPwd
						+ "' where tm_sno = '" + id + "';";
				if (DBUtil.executeSQL(update_sql) == 1) {
					success = true;
				}
			}
		}
		return success;
	}

	/*
	 * 重置密码，恢复为默认的111111
	 */
	public boolean resetPassword(String id) {
		boolean success = false;
		String sql = "update TM set tm_pwd = '111111' where tm_sno = '" + id
				+ "';";
		if (DBUtil.executeSQL(sql) == 1) {
			success = true;
		}
		return success;
	}

	/*
	 * 修改姓名和电话，成功返回true，失败返回false
	 */
	public boolean setNameAndPhone(String id, String newName, String newPhone) {
		boolean success = false;
		int nameCheck = 1;// 名字更新成功与否的检查
		int phoneCheck = 1;// 电话更新成功与否的检查

		if (newName != null || newPhone != null) {
			if (newName != null) {
				String update_sql1 = "update TM set tm_name = '" + newName
						+ "' where tm_sno = '" + id + "';";
				nameCheck = DBUtil.executeSQL(update_sql1);
			}

			if (newPhone != null) {
				String update_sql2 = "update TM set tm_phone = '" + newPhone
						+ "' where tm_sno = '" + id + "';";
				phoneCheck = DBUtil.executeSQL(update_sql2);
			}
		}

		else {
			nameCheck = phoneCheck = 0;
		}

		if (nameCheck == 1 && phoneCheck == 1) {
			success = true;
		}

		return success;
	}

	/*
	 * 修改姓名
	 */
	public boolean setName(String id, String newName) {
		boolean success = false;
		if (newName != null) {
			String update_sql1 = "update TM set tm_name = '" + newName
					+ "' where tm_sno = '" + id + "';";
			if (DBUtil.executeSQL(update_sql1) == 1) {
				success = true;
			}
		}
		return success;
	}

	/*
	 * 修改电话
	 */
	public boolean setPhone(String id, String newPhone) {
		boolean success = false;
		if (newPhone != null) {
			String update_sql1 = "update TM set tm_phone = '" + newPhone
					+ "' where tm_sno = '" + id + "';";
			if (DBUtil.executeSQL(update_sql1) == 1) {
				success = true;
			}
		}
		return success;
	}

	/*
	 * 移交队长
	 */
	public int changeLeader(String oldLeaderId,String oldLeaderPassword, String newLeaderId) {
		int result;
		int oldLeaderChange = 0;
		int newLeaderChange = 1;
		String check_sql = "select tm_sno,tm_pwd from TM where tm_status ='1' and tm_sno = '"+oldLeaderId+"';";
		ArrayList<ArrayList<String>> tempArr = DBUtil.getResult(DBUtil.getRs(check_sql), 2);
		if(tempArr == null || tempArr.size() == 0){
			result = -2;
		}
		else{
			if(!tempArr.get(0).get(1).equals(oldLeaderPassword)){
				result =-1;
			}
			else{
				String old_sql = "update TM set tm_status = '0' where tm_sno = '"
						+ oldLeaderId + "';";
				String new_sql = "update TM set tm_status = '1' where tm_sno = '"
						+ newLeaderId + "';";
				oldLeaderChange = DBUtil.executeSQL(old_sql);
				newLeaderChange = DBUtil.executeSQL(new_sql);
				if (oldLeaderChange == 1 && newLeaderChange == 1) {
					recordLeaderChange(oldLeaderId,newLeaderId);
					result = 0;
				} 
				else {
					result = -2;
					if (oldLeaderChange == 0) {
						String reOld = "update TM set tm_status = '0' where tm_sno = '"
								+ oldLeaderId + "';";
						DBUtil.executeSQL(reOld);
					}
					if (newLeaderChange == 0) {
						String reOld = "update TM set tm_status = '1' where tm_sno = '"
								+ newLeaderId + "';";
						DBUtil.executeSQL(reOld);
					}
				}
			}		
		}	
		return result;
	}


}
