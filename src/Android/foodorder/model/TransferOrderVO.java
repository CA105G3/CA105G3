package Android.foodorder.model;

import java.io.Serializable;
import java.util.List;

public class TransferOrderVO  implements Serializable{

    private static final long serialVersionUID = 1L;
    private FoodOrderVO foodOrderVO;
    private List<OrderDetailVO> orderDetailVOlist;
    private String action;

    public TransferOrderVO(FoodOrderVO foodOrderVO,List<OrderDetailVO> orderDetailVOlist){
        this.foodOrderVO = foodOrderVO;
        this.orderDetailVOlist = orderDetailVOlist;
    }

	public FoodOrderVO getFooOrderVO() {
		return foodOrderVO;
	}

	public void setFoodOrderVO(FoodOrderVO foodOrderVO) {
		this.foodOrderVO = foodOrderVO;
	}

	public List<OrderDetailVO> getOrderDetailVOlist() {
		return orderDetailVOlist;
	}

	public void setOrderDetailVOlist(List<OrderDetailVO> orderDetailVOlist) {
		this.orderDetailVOlist = orderDetailVOlist;
	}
	
    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
}
