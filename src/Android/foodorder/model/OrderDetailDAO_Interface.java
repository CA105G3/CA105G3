package Android.foodorder.model;

import java.util.List;

import Android.foodorder.model.OrderDetailVO;

public interface OrderDetailDAO_Interface {
	public void insert(OrderDetailVO orderDetailVO);
	public void delete(String odno);
	public boolean update(OrderDetailVO orderDetailVO);
	public OrderDetailVO findByPrimaryKey(String odno);
	public List<OrderDetailVO> getAllByOrderno(String orderno);
	public List<OrderDetailVO> getAll();
	public List<DetailInfo> getAllDetailByOrderno(String orderno);
	public void insert2(OrderDetailVO orderDetailVO,java.sql.Connection con);
	byte[] getImage(String isbn);
}
