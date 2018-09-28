package object;

import java.io.Serializable;

/*
 * 物品变动记录表
 */
public class ItemChange implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String flowId; // 流水号
	private String userId; // 人员号
	private String userName; // 人员姓名
	private String itemId; // 物品号
	private String itemName; // 物品名
	private String itemNumber; // 物品数量
	private String type; // 变动类型，中文
	private String time; // 变动时间

	public ItemChange(String flowId, String userId, String userName,
			String itemId, String itemName, String itemNumber, String type,
			String time) {
		super();
		this.flowId = flowId;
		this.userId = userId;
		this.userName = userName;
		this.itemId = itemId;
		this.itemName = itemName;
		this.itemNumber = itemNumber;
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

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemNumber() {
		return itemNumber;
	}

	public void setItemNumber(String itemNumber) {
		this.itemNumber = itemNumber;
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
