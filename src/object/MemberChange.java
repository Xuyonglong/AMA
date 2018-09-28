package object;

import java.io.Serializable;

/*
 * 人员变动记录
 */
public class MemberChange implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String flowId;  //流水号
	private String userId;	//人员号
	private String userName; //人员姓名
	private String type;    //变动类型，中文
	private String time;    //变动时间
	
	public MemberChange(String flowId, String userId, String userName,
			String type, String time) {
		super();
		this.flowId = flowId;
		this.userId = userId;
		this.userName = userName;
		this.type = type;
		this.time = time;
	}

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
}
