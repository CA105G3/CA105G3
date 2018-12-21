package com.foodorder.model;

import java.util.List;
import java.util.Set;

import com.orderdetail.model.OrderDetailVO;


public interface FoodOrderDAO_Interface {
	public void insert(FoodOrderVO foodOrderVO);
	public FoodOrderVO findByPrimaryKey(String orderno);
	public List<FoodOrderVO> getAll();
	//把所有下過訂單的memno存放到這個list裡
	public List<String> getAllOrderMemno();
	
	//從所選擇的memno裡去查詢其訂單
	public List<FoodOrderVO> findByMemno(String memno);
	
	//查詢訂單中的某一筆訂單明細(一對多)(回傳 Set)
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno);

}
