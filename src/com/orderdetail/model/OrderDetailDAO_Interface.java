package com.orderdetail.model;

import java.sql.Connection;
import java.util.List;

import com.orderdetail.model.OrderDetailVO;

public interface OrderDetailDAO_Interface {
	public void insert(OrderDetailVO orderDetailVO);
	public void insert2 (OrderDetailVO orderDetailVO , Connection con);
	public void delete(String odno);
	public OrderDetailVO findByPrimaryKey(String odno);
	public List<OrderDetailVO> getAll();

}
