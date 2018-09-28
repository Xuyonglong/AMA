package object;

import java.io.Serializable;

/*
 * 物品类
 * 同一id不同位置的物品属于不同对象
 */

public class LeafNode implements SupNode, Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String location;
	private String name;
	private String nickName;
	private int totalNumber;
	private int restNumber;
	private String useHelp;
	private String usePurpose;
	private String tip;
	
	public LeafNode(String id, String location, String name) {
		super();
		this.id = id;
		this.location = location;
		this.name = name;
	}

	public LeafNode(String id, String location, String name, String nickName,
			int totalNumber, int restNumber, String useHelp,
			String usePurpose, String tip) {
		super();
		this.id = id;
		this.location = location;
		this.name = name;
		this.nickName = nickName;
		this.totalNumber = totalNumber;
		this.restNumber = restNumber;
		this.useHelp = useHelp;
		this.usePurpose = usePurpose;
		this.tip = tip;
	}



	@Override
	public String getId() {
		return id;
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public String getPId() {
		return location;
	}

	public String getLocation() {
		return location;
	}
	
	public String getNickName() {
		return nickName;
	}
	
	public int getTotalNumber() {
		return totalNumber;
	}
	
	public int getRestNumber() {
		return restNumber;
	}
	
	public String getUseHelp() {
		return useHelp;
	}

	public String getUsePurpose() {
		return usePurpose;
	}
	
	public String getTip() {
		return tip;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public void setTotalNumber(int totalNumber) {
		this.totalNumber = totalNumber;
	}

	public void setRestNumeber(int restNumber) {
		this.restNumber = restNumber;
	}

	public void setUseHelp(String useHelp) {
		this.useHelp = useHelp;
	}

	public void setUsePurpose(String usePurpose) {
		this.usePurpose = usePurpose;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	@Override
	public boolean isLeaf() {
		return true;
	}

}
