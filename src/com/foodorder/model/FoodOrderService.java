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
	
	public FoodOrderVO updateOrderStatus(String orderStatus, String orderno) {
		FoodOrderVO foodOrderVO = new FoodOrderVO();

		foodOrderVO.setOrderStatus(orderStatus);
		foodOrderVO.setOrderno(orderno);
		dao.update_OrderStatus(foodOrderVO);

		return foodOrderVO;
	}
	
	public FoodOrderVO findByOrderno(String orderno) {
		return dao.findBy_Orderno(orderno);
	}
	
	public List<FoodOrderVO> findBy_MemId(String memId) {
		return dao.findBy_MemId(memId);
	}
	
	public List<FoodOrderVO> findBy_Email(String email) {
		return dao.findBy_Email(email);
	}
	
	public List<FoodOrderVO> findBy_Memno(String memno) {
		return dao.findBy_Memno(memno);
	}
	
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
		return dao.getOrderDetailsByFoodOrder(orderno);
	}
	
	public List<FoodOrderVO> getAll(){
		return dao.getAll();
	}
}
