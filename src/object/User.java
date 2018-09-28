package object;

public class User {

	private String id;
	private String name;
	private String phone;
	private boolean isLeader;
	private String outReason;

	public User() {

	}

	public User(String id) {
		super();
		this.id = id;
	}
	
	public User(String id, String name, String phone, boolean isLeader){
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.isLeader = isLeader;
		this.outReason = null;
	}

	public User(String id, String name, String phone, boolean isLeader,
			String outReason) {
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.isLeader = isLeader;
		this.outReason = outReason;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getPhone() {
		return phone;
	}

	public boolean isLeader() {
		return isLeader;
	}

	public String getOutReason() {
		return outReason;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setLeader(boolean isLeader) {
		this.isLeader = isLeader;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setOutReason(String outReason) {
		this.outReason = outReason;
	}

}
