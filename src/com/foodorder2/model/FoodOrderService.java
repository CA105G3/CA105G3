package com.foodorder2.model;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.foodorder2.model.FoodOrderDAO_Interface;


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
	
	public boolean insertNewOrder(FoodOrderVO foodOrderVO, List<OrderDetailVO> list) {
		
		FoodOrderDAO foodOrderDAO = new FoodOrderDAO();
		boolean check = foodOrderDAO.insertWithOrderDetail(foodOrderVO, list);
		
		return check;
	}
	
	
public boolean insertNewMutiOrder(Map<String,Object[]> map) {			//Object[0]:FoodOrderVO， Object[1]:List<OrderDetailVO>
		
		FoodOrderDAO foodOrderDAO = new FoodOrderDAO();
		boolean check = foodOrderDAO.multiinsertWithOrderDetail(map);
		
		return check;
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
	
	public List<FoodOrderVO> findByChefNo(String chefNo) {
		return dao.findByChefNo(chefNo);
	}
	
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
		return dao.getOrderDetailsByFoodOrder(orderno);
	}
	
	public List<FoodOrderVO> getAll(){
		return dao.getAll();
	}
}
