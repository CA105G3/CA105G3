package com.foodorder.model;

import java.util.List;
import java.util.Set;

import com.orderdetail.model.OrderDetailVO;


public interface FoodOrderDAO_Interface {
	public void insert(FoodOrderVO foodOrderVO);
	public void delete(String orderno);
	public FoodOrderVO findByPrimaryKey(String orderno);
	public List<FoodOrderVO> getAll();
	//查詢訂單中的某一筆訂單明細(一對多)(回傳 Set)
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno);

}
