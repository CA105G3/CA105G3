package Android.foodorder.model;

import java.util.List;
import java.util.Set;

//import com.orderdetail.model.OrderDetailVO;


public interface FoodOrderDAO_Interface {
	public void insert(FoodOrderVO foodOrderVO);
	public FoodOrderVO findByPrimaryKey(String orderno);
	public List<FoodOrderVO> getAll();
	public List<String> getAllOrderMemno();
	public List<FoodOrderVO> findByMemno(String memno);
	public Boolean insertWithOrderDetail(FoodOrderVO foodOrderVO,List<OrderDetailVO> list);

}
