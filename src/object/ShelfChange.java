package object;

import java.io.Serializable;

public class ShelfChange implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String flowId;  //流水号
	private String shelfId;	//货架号
	private String shelfName; //货架名
	private String type;    //变动类型，中文
	private String time;    //变动时间
	
	public ShelfChange(String flowId, String shelfId, String shelfName,
			String type, String time) {
		super();
		this.flowId = flowId;
		this.shelfId = shelfId;
		this.shelfName = shelfName;
		this.type = type;
		this.time = time;
	}

	public String getFlowId() {
		return flowId;
	}

	public void setFlowId(String flowId) {
		this.flowId = flowId;
	}

	public String getShelfId() {
		return shelfId;
	}

	public void setShelfId(String shelfId) {
		this.shelfId = shelfId;
	}

	public String getShelfName() {
		return shelfName;
	}

	public void setShelfName(String shelfName) {
		this.shelfName = shelfName;
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
