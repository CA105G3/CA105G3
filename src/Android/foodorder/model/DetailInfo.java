package Android.foodorder.model;

import java.io.Serializable;
import java.sql.Date;



public class DetailInfo implements Serializable,Comparable<DetailInfo>{

	private static final long serialVersionUID = 1L;
	
	private String odno;		//Orderlist編號
	private Integer amount;   //menulist裡單筆訂單明細的數量
	private  Integer unitPrice;	//menulist裡餐點單價
	private   String odStatus;
	private  Date menuDate;
    private   String menutimeslot;
    private   String menuno;
    private   String maincourse;	//menu裡的主餐名稱
    private   String chefno;
    private   String chefAddr;
    private   String chefRep;
    private   Integer chefphone;
    private  String chefDescript;
    
    
	
	
	public String getOdno() {
		return odno;
	}




	public void setOdno(String odno) {
		this.odno = odno;
	}




	public Integer getAmount() {
		return amount;
	}




	public void setAmount(Integer amount) {
		this.amount = amount;
	}




	public Integer getUnitPrice() {
		return unitPrice;
	}




	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}




	public String getOdStatus() {
		return odStatus;
	}




	public void setOdStatus(String odStatus) {
		this.odStatus = odStatus;
	}




	public Date getMenuDate() {
		return menuDate;
	}




	public void setMenuDate(Date menuDate) {
		this.menuDate = menuDate;
	}




	public String getMenutimeslot() {
		return menutimeslot;
	}




	public void setMenutimeslot(String menutimeslot) {
		this.menutimeslot = menutimeslot;
	}




	public String getMenuno() {
		return menuno;
	}




	public void setMenuno(String menuno) {
		this.menuno = menuno;
	}




	public String getMaincourse() {
		return maincourse;
	}




	public void setMaincourse(String maincourse) {
		this.maincourse = maincourse;
	}




	public String getChefno() {
		return chefno;
	}




	public void setChefno(String chefno) {
		this.chefno = chefno;
	}




	public String getChefAddr() {
		return chefAddr;
	}




	public void setChefAddr(String chefAddr) {
		this.chefAddr = chefAddr;
	}




	public String getChefRep() {
		return chefRep;
	}




	public void setChefRep(String chefRep) {
		this.chefRep = chefRep;
	}




	public Integer getChefphone() {
		return chefphone;
	}




	public void setChefphone(Integer chefphone) {
		this.chefphone = chefphone;
	}




	public String getChefDescript() {
		return chefDescript;
	}




	public void setChefDescript(String chefDescript) {
		this.chefDescript = chefDescript;
	}





	@Override
	public int compareTo(DetailInfo detailInfo) {
		
		String odno2 = detailInfo.getOdno();
		String[] tokens2= odno2.split("-");
		int od2 = Integer.parseInt(tokens2[0]+tokens2[1]);
		
		String odno1 = this.getOdno();
		String[] tokens1 = odno1.split("-");
		int od1 = Integer.parseInt(tokens1[0]+tokens1[1]);
		
		return od1 - od2;	
	}
}
