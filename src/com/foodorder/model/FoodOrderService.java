package com.foodorder.model;

import java.sql.Date;
import java.util.List;
import java.util.Set;

import com.foodorder.model.FoodOrderDAO_Interface;
import com.orderdetail.model.OrderDetailVO;


public class FoodOrderService {
	private FoodOrderDAO_Interface dao;
	
	public FoodOrderService() {
		dao = new FoodOrderJDBCDAO();
	}
	
	public FoodOrderVO addFoodOrder(String memno, String deliverAddr, 
			String chefno, String orderStatus, Date ordTime) {
		
		FoodOrderVO foodOrderVO = new FoodOrderVO();
		
		foodOrderVO.setMemno(memno);
		foodOrderVO.setDeliverAddr(deliverAddr);
		foodOrderVO.setChefno(chefno);
		foodOrderVO.setOrderStatus(orderStatus);
		foodOrderVO.setOrdTime(ordTime);
		dao.insert(foodOrderVO);
		
		return foodOrderVO;
	}
	
	
	public FoodOrderVO getOneFoodOrder(String orderno) {
		return dao.findByPrimaryKey(orderno);
	}
	
	public List<FoodOrderVO> getAll(){
		return dao.getAll();
	}
	
	public List<String> getAllOrderMemno(){
		return dao.getAllOrderMemno();
	}
	
	public List<FoodOrderVO> findByMemno(String memno){
		return dao.findByMemno(memno);
	}
	
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
		return dao.getOrderDetailsByFoodOrder(orderno);
	}
	
}
