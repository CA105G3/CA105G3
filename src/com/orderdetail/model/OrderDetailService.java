package com.orderdetail.model;

import java.util.List;

public class OrderDetailService {
	
	private OrderDetailDAO_Interface dao;
	
	public OrderDetailService() {
		dao = new OrderDetailDAO();
	}
	
	public OrderDetailVO addOrderDetail(String odno, String orderno, String menuListno, int amount, int unitPrice) {
		OrderDetailVO orderDetailVO = new OrderDetailVO();
		
		orderDetailVO.setOrderno(orderno);
		orderDetailVO.setMenuListno(menuListno);
		orderDetailVO.setAmount(amount);
		orderDetailVO.setUnitPrice(unitPrice);
		dao.insert(orderDetailVO);
		
		return orderDetailVO;
	}

	public void deleteOrderDetail(String odno) {
		dao.delete(odno);
	}
	
	public OrderDetailVO getOneOrderDetail(String odno) {
		return dao.findByPrimaryKey(odno);
	}
	
	public List<OrderDetailVO> getAll(){
		return dao.getAll();
	}
}
