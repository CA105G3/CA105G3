package Android.foodorder.model;


import java.io.Serializable;

public class OrderDetailVO implements Serializable,Comparable<OrderDetailVO>{
	private static final long serialVersionUID = 1L;
	
	private String odno, orderno, menuListno,odStatus;
	private int amount, unitPrice;
	
	

	public String getOdno() {
		return odno;
	}



	public void setOdno(String odno) {
		this.odno = odno;
	}



	public String getOrderno() {
		return orderno;
	}



	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}



	public String getMenuListno() {
		return menuListno;
	}



	public void setMenuListno(String menuListno) {
		this.menuListno = menuListno;
	}



	public String getOdStatus() {
		return odStatus;
	}



	public void setOdStatus(String odStatus) {
		this.odStatus = odStatus;
	}



	public int getAmount() {
		return amount;
	}



	public void setAmount(int amount) {
		this.amount = amount;
	}



	public int getUnitPrice() {
		return unitPrice;
	}



	public void setUnitPrice(int unitPrice) {
		this.unitPrice = unitPrice;
	}






	@Override
	public int compareTo(OrderDetailVO orderDetailVO2) {
		String odno1 = this.getOdno();
		String[] tokens1= odno1.split("-");
		int od1 = Integer.parseInt(tokens1[0]+tokens1[1]);
		
		String odno2 = orderDetailVO2.getOdno();
		String[] tokens2= odno2.split("-");
		int od2 = Integer.parseInt(tokens2[0]+tokens2[1]);
		
		return od1 - od2;
	}

	
}
