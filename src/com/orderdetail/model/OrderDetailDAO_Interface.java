package com.orderdetail.model;

import java.util.List;

public interface OrderDetailDAO_Interface {
	public void insert(OrderDetailVO orderDetailVO);
	public void delete(String odno);
	public OrderDetailVO findByPrimaryKey(String odno);
	public List<OrderDetailVO> getAll();

}
