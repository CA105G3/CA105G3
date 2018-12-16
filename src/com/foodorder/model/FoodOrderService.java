package com.foodorder.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.foodorder.model.FoodOrderDAO_Interface;
import com.orderdetail.model.OrderDetailVO;


public class FoodOrderService {
	private FoodOrderDAO_Interface dao;
	
	public FoodOrderService() {
		dao = new FoodOrderDAO();
	}
	
	public FoodOrderVO addOrder(String memno, String deliverAddr, 
			String chefno, String orderStatus, Timestamp ordTime) {
		
		FoodOrderVO foodOrderVO = new FoodOrderVO();
		
		foodOrderVO.setMemno(memno);
		foodOrderVO.setDeliverAddr(deliverAddr);
		foodOrderVO.setChefno(chefno);
		foodOrderVO.setOrderStatus(orderStatus);
		foodOrderVO.setOrdTime(ordTime);
		dao.insert(foodOrderVO);
		
		return foodOrderVO;
	}
	
	public void addOrder(FoodOrderVO foodOrderVO) {
		dao.insert(foodOrderVO);
	}
	
	public void deleteOrder(String orderno) {
		dao.delete(orderno);
		
	}
	
	public FoodOrderVO getOneOrder(String orderno) {
		return dao.findByPrimaryKey(orderno);
	}
	
	public List<FoodOrderVO> getAll(){
		return dao.getAll();
	}
	
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
		return dao.getOrderDetailsByFoodOrder(orderno);
	}
	
}
