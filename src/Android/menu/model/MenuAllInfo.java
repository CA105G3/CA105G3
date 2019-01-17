package Android.menu.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;


public class MenuAllInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String menuNo;
	private String chefNo;
	private Integer unitPrice;
	private String mainCourse;
	private byte[] menuPic;
	private String deliverable;
	private List<MenuListVO> list;
	private String menuIntro;
	
	
	public MenuAllInfo(MenuVO menuVO,List<MenuListVO> list) {
		
		this.menuNo = menuVO.getMenuNo();
		this.chefNo = menuVO.getChefNo();
		this.unitPrice = menuVO.getUnitPrice();
		this.mainCourse = menuVO.getMainCourse();
		this.deliverable = menuVO.getDeliverable();
		this.menuIntro = menuVO.getMenuIntro();
		
		
		
//		for(int i=0;i<list.size();i++) {
//			MenuListVO menuListVO = list.get(i);
//			Date date = menuListVO.getMenuDate();
//			java.util.Date current = new java.util.Date();
//			long currentTime = current.getTime();
//			currentTime = 86400*(currentTime/86400+1);
//			if(date.getTime()<currentTime) {
//				list.remove(i);
//				i--;
//			}
//		}
			
			
		this.list = list;
	}


	public String getMenuNo() {
		return menuNo;
	}


	public void setMenuNo(String menuNo) {
		this.menuNo = menuNo;
	}


	public String getChefNo() {
		return chefNo;
	}


	public void setChefNo(String chefNo) {
		this.chefNo = chefNo;
	}


	public Integer getUnitPrice() {
		return unitPrice;
	}


	public void setUnitPrice(Integer unitPrice) {
		this.unitPrice = unitPrice;
	}


	public String getMainCourse() {
		return mainCourse;
	}


	public void setMainCourse(String mainCourse) {
		this.mainCourse = mainCourse;
	}


	public byte[] getMenuPic() {
		return menuPic;
	}


	public void setMenuPic(byte[] menuPic) {
		this.menuPic = menuPic;
	}


	public String getDeliverable() {
		return deliverable;
	}


	public void setDeliverable(String deliverable) {
		this.deliverable = deliverable;
	}


	public List<MenuListVO> getList() {
		return list;
	}


	public void setList(List<MenuListVO> list) {
		this.list = list;
	}


	public String getMenuIntro() {
		return menuIntro;
	}


	public void setMenuIntro(String menuIntro) {
		this.menuIntro = menuIntro;
	}
	
	
	

}
