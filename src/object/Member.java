package object;

import java.io.Serializable;


/*
 * 人员管理时的对象类
 */

public class Member implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String name;
	private String phone;
	private boolean isLeader;
	private String inTime;
	private String outTime;
	private String outReason;

	public Member(String id, String name, String phone, boolean isLeader,
			String inTime, String outTime, String outReason) {
		super();
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.isLeader = isLeader;
		this.inTime = inTime;
		this.outTime = outTime;
		this.outReason = outReason;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public boolean isLeader() {
		return isLeader;
	}

	public void setLeader(boolean isLeader) {
		this.isLeader = isLeader;
	}

	public String getInTime() {
		return inTime;
	}

	public void setInTime(String inTime) {
		this.inTime = inTime;
	}

	public String getOutTime() {
		return outTime;
	}

	public void setOutTime(String outTime) {
		this.outTime = outTime;
	}

	public String getOutReason() {
		return outReason;
	}

	public void setOutReason(String outReason) {
		this.outReason = outReason;
	}

}
