package object;

import java.io.Serializable;

public class ShelfNode implements SupNode,Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String pId;
	private String name;
	private String imgPath;
	private String describe;

	public ShelfNode(String id, String pId, String name, String imgPath,
			String describe) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
		this.imgPath = imgPath;
		this.describe = describe;
	}

	public ShelfNode(String id, String pId, String name) {
		super();
		this.id = id;
		this.pId = pId;
		this.name = name;
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
		return pId;
	}

	public String getImgPath() {
		return imgPath;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	@Override
	public boolean isLeaf() {
		return false;
	}

}
