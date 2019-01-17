package Android.foodorder.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.lang.reflect.Type;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import Android.foodorder.model.DetailInfo;
import Android.foodorder.model.FoodList;
import Android.foodorder.model.FoodOrderDAO_Interface;
import Android.foodorder.model.FoodOrderJDBCDAO;
import Android.foodorder.model.FoodOrderVO;
import Android.foodorder.model.OrderDetailDAO_Interface;
import Android.foodorder.model.OrderDetailJDBCDAO;
import Android.foodorder.model.OrderDetailVO;
import Android.foodorder.model.TransferOrderVO;
import Android.utilities.ImageUtil;

public class AndroidFoodOrderServlet extends HttpServlet {

	private final static String CONTENT_TYPE = "text/html;charset=UTF-8";
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		
		//---------------------------------------------
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		System.out.println("input: "+ jsonIn);
		//----------------------------------------------
		
		
		
		
		//-----------------------------------------------------------------------
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
			String action = null;
			TransferOrderVO transferOrderVO = null;
			JsonObject jsonObject = null;
			
			//---------------------------------------------------------------------------
			try {
				jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
				action = jsonObject.get("action").getAsString();
			}catch(NullPointerException npe) {
				System.out.println("Startup Tomcat or No action catch");
			}
			//-------------------------------------------------------------------------------
			
			
			
			//---------------------------------------------------------------------------------------
			try {
				transferOrderVO = gson.fromJson(jsonIn.toString(), TransferOrderVO.class);
				action = transferOrderVO.getAction();
			}catch(Exception e) {
				System.out.println("Exception occur in AndroidFoodOrderServlet");
			}
		
		
		
		
		
		
		
		
		
		
		
		
		
		//------------------------------------------------------------------------
		FoodOrderDAO_Interface foodOrderDAO = new FoodOrderJDBCDAO();
		OrderDetailDAO_Interface orderDetailDAO = new OrderDetailJDBCDAO();

		//使用自訂類別FoodList(FoodOrderVO,List<OrderListVO>)，將Order所需要的資料List<FoodList>送上Android
		if("allOrderInfo".equals(action)) {
			String memno = jsonObject.get("memNo").getAsString();
			List<FoodOrderVO> list = foodOrderDAO.findByMemno(memno);
			Iterator<FoodOrderVO> it = list.iterator();
			
			List<FoodList> allOrderInfo = new ArrayList<>();
			
			while(it.hasNext()) {
				FoodOrderVO foodOrderVO = it.next();
				String orderno = foodOrderVO.getOrderno();
				List<DetailInfo> dlist  = orderDetailDAO.getAllDetailByOrderno(orderno);
				FoodList foodList = new FoodList(foodOrderVO,dlist);
				allOrderInfo.add(foodList);
			}
			Collections.sort(allOrderInfo);
			String jsonlist = gson.toJson(allOrderInfo);
			writeText(res,jsonlist);
		}
		
		
		
		
		
		
		
		else if("foodOrderTransaction".equals(action)) {
			transferOrderVO.getAction();
			FoodOrderVO foodOrderVO = transferOrderVO.getFooOrderVO();
			List<OrderDetailVO> orderDetailVOList = transferOrderVO.getOrderDetailVOlist();
			boolean check = foodOrderDAO.insertWithOrderDetail(foodOrderVO, orderDetailVOList);
			String jsonCheck = gson.toJson(String.valueOf(check));
			writeText(res,jsonCheck);
		}
		
		
		
		
		
		else if ("getImage".equals(action)) {
			OutputStream os = res.getOutputStream();
			String isbn = jsonObject.get("isbn").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			byte[] image = orderDetailDAO.getImage(isbn);
			if (image != null) {
				// 縮圖 in server side
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(image.length);
			}
			os.write(image);
		}
		
		
		
		else if("cancelFoodOrderDetail".equals(action)) {
			String odno = jsonObject.get("odno").getAsString();
			OrderDetailVO odfix = orderDetailDAO.findByPrimaryKey(odno);
			odfix.setOdStatus("取消");
			Boolean result = orderDetailDAO.update(odfix);
			String jsonlist = gson.toJson(String.valueOf(result));
			writeText(res,jsonlist);
		} 
		
		
		
		
		
		else {
			writeText(res, "");
		}
		//------------------------------------------------------------------------
	}
	
	
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
		
	}

	
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);

	}


}
