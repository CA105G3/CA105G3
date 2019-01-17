package com.foodorder2.model;

import java.util.List;
import java.util.Map;
import java.util.Set;



public interface FoodOrderDAO_Interface {
	public void insert(FoodOrderVO foodOrderVO);
	//變更訂單狀態 
	public void update_OrderStatus(FoodOrderVO foodOrderVO);
	
	//以訂單編號、會員編號、會員ID或EMAIL查詢訂單
	//(若以orderno查詢一次只會有一筆，若用memno, memid, email查詢則一次可能會有多筆，因此下面用list把查詢結果裝起來)
	public FoodOrderVO findBy_Orderno(String orderno);
	public List<FoodOrderVO> findBy_Memno(String memno);
	public List<FoodOrderVO> findBy_MemId(String memId);
	public List<FoodOrderVO> findBy_Email(String email);
	public List<FoodOrderVO> findByChefNo(String chefNo);
	//查詢訂單中的某一筆訂單明細(一對多)(回傳 Set)
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno);
	//查詢所有會員的所有訂單
	public List<FoodOrderVO> getAll();
	public Boolean insertWithOrderDetail(FoodOrderVO foodOrderVO,List<OrderDetailVO> list);
	public Boolean multiinsertWithOrderDetail(Map<String,Object[]> map);			//Object[0]:FoodOrderVO， Object[1]:List<OrderDetailVO>
	public Boolean insertWithOrderDetail2(FoodOrderVO foodOrderVO,List<OrderDetailVO> list,java.sql.Connection con);
}
