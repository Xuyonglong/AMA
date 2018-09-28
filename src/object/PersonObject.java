package object;

import java.io.Serializable;
/*
 * 个人物品类
 * 同一物品不同人持有属于不同对象
 */

public class PersonObject implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String pId;
	private String oId;
	private String oName;
	private String shelfId;
	private String shelfName;
	private int num;
	private String imgPath;
	
	public PersonObject(String pId,String oId,String oName,String shelfId,String shelfName,int num,String imgPath){
		this.pId = pId;
		this.oId = oId;
		this.oName = oName;
		this.shelfId = shelfId;
		this.shelfName = shelfName;
		this.num = num;
		this.imgPath = imgPath;		
	}
	
	public String getPId(){
		return pId;
	}
	
	public String getOId(){
		return oId;
	}
	
	public String getOName(){
		return oName;
	}
	
	public String getShelfId(){
		return shelfId;
	}
	
	public String getShelfName(){
		return shelfName;
	}
	
	public int getNum(){
		return num;
	}
	
	public String getImgPath(){
		return imgPath;
	}
	
	public void setPId(String pId){
		this.pId = pId;	
	}
	
	public void setOId(String oId){
		this.oId = oId;	
	}
	
	public void setOName(String oName){
		this.oName = oName;	
	}
	
	public void setShelfId(String shelfId){
		this.shelfId = shelfId;
	}
	
	public void setShelfName(String shelfName){
		this.shelfName = shelfName;
	}
	
	public void setNum(int num){
		this.num = num;	
	}
	
	public void setImgPath(String imgPath){
		this.imgPath = imgPath;	
	}


}
