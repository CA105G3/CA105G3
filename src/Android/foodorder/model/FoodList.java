package Android.foodorder.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Iterator;
import java.util.List;

public class FoodList implements Serializable,Comparable<FoodList>{

	private static final long serialVersionUID = 1L;
	private String orderno; 
	private String memno;
	private String deliverAddr;
	private String chefno;
	private String orderStatus;
	private Date ordTime;
	private int orderlistNumber; //共有幾筆訂單明細
	private int orderlistOngoing;	//還有幾筆在進行
	private String orderOngoingOrNot; //此訂單是否還在進行中
	private List<DetailInfo> list;
	
	public FoodList() {
		super();
	}
	public FoodList(FoodOrderVO foodorderVO,List<DetailInfo> list) {
		this.orderno = foodorderVO.getOrderno();
		this.memno = foodorderVO.getMemno();
		this.deliverAddr = foodorderVO.getDeliverAddr();
		this.chefno = foodorderVO.getChefno();
		this.orderStatus = foodorderVO.getOrderStatus();
		this.ordTime = foodorderVO.getOrdTime();
		this.list = list;
		this.orderlistNumber = list.size();
		
		
		Iterator<DetailInfo> it = list.iterator();
		while(it.hasNext()) {
			
			DetailInfo detailInfo = it.next();
			long currentTime = System.currentTimeMillis();
			long menuTIme = detailInfo.getMenuDate().getTime();
			
			//"早": 8:00   "中" : 12:00  "晚" : 18:00
			String timeslot = detailInfo.getMenutimeslot();
			String odStatus = detailInfo.getOdStatus();
			
			
			if(!"取消".equals(odStatus))	{	
				if("早".equals(timeslot)) {
					menuTIme+=8*60*60*1000;
					if(currentTime<menuTIme) {
						this.orderlistOngoing++;
					}
				}else if("午".equals(timeslot)) {
					menuTIme+=12*60*60*1000;
					if(currentTime<menuTIme) {
						this.orderlistOngoing++;
					}
				}else {
					menuTIme+=18*60*60*1000;
					if(currentTime<menuTIme) {
						this.orderlistOngoing++;
					}
				}
			}
		}
		if(orderlistOngoing>0) {
			orderOngoingOrNot="進行中";
		}else {
			orderOngoingOrNot="已結束";
		}
		
		
	}
	
	
	


	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getMemno() {
		return memno;
	}
	public void setMemno(String memno) {
		this.memno = memno;
	}
	public String getDeliverAddr() {
		return deliverAddr;
	}
	public void setDeliverAddr(String deliverAddr) {
		this.deliverAddr = deliverAddr;
	}
	public String getChefno() {
		return chefno;
	}
	public void setChefno(String chefno) {
		this.chefno = chefno;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Date getOrdTime() {
		return ordTime;
	}
	public void setOrdTime(Date ordTime) {
		this.ordTime = ordTime;
	}
	public int getOrderlistNumber() {
		return orderlistNumber;
	}
	public void setOrderlistNumber(int orderlistNumber) {
		this.orderlistNumber = orderlistNumber;
	}

	public int getOrderlistOngoing() {
		return orderlistOngoing;
	}
	public void setOrderlistOngoing(int orderlistOngoing) {
		this.orderlistOngoing = orderlistOngoing;
	}
	public List<DetailInfo> getList() {
		return list;
	}
	public void setList(List<DetailInfo> list) {
		this.list = list;
	}
	
	
	public String getOrderOngoingOrNot() {
		return orderOngoingOrNot;
	}
	public void setOrderOngoingOrNot(String orderOngoingOrNot) {
		this.orderOngoingOrNot = orderOngoingOrNot;
	}
	@Override
	public int compareTo(FoodList other) {
			
		String orderno2 = other.getOrderno();
		String[] tokens2= orderno2.split("-");
		long od2 = Long.parseLong(tokens2[0]+tokens2[1]);
		if("已結束".equals(other.getOrderOngoingOrNot())){
			od2+=100000;
		}
		
		String orderno1 = this.getOrderno();
		String[] tokens1 = orderno1.split("-");
        long od1 = Long.parseLong(tokens1[0]+tokens1[1]);
        if("已結束".equals(this.getOrderOngoingOrNot())){
        	od1+=100000;
		}
        int i = (int)(od2-od1);

			
		return i;
	}

	
}
