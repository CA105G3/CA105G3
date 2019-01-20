package Android.menu.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;


import Android.menu.model.MenuAllInfo;
import Android.menu.model.MenuDAO_interface;
import Android.menu.model.MenuDAO;
import Android.menu.model.MenuListDAO_interface;
import Android.menu.model.MenuListDAO;
import Android.menu.model.MenuListVO;
import Android.menu.model.MenuVO;
import Android.utilities.ImageUtil;

public class AndroidMenuServlet extends HttpServlet {
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
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		String action = null;
		try {
			action = jsonObject.get("action").getAsString();
		}catch(NullPointerException npe) {
			System.out.println("Startup Tomcat or No action catch");
		}
		//-----------------------------------------------------------------------
		
		
		
		
		//------------------------------------------------------------------------
		MenuDAO_interface menuDAO = new MenuDAO();
		MenuListDAO_interface menuListDAO = new MenuListDAO();

		//使用自訂類別FoodList(FoodOrderVO,List<OrderListVO>)，將Order所需要的資料List<FoodList>送上Android
		if("allMenuInfo".equals(action)) {
			String chefNo = jsonObject.get("chefNo").getAsString();
			List<MenuVO> list = menuDAO.findByChefNo(chefNo);
			Iterator<MenuVO> it = list.iterator();
			
			List<MenuAllInfo> menuAllInfoList = new ArrayList<>();
			
			while(it.hasNext()) {
				MenuVO menuVO = it.next();
				String menuNo = menuVO.getMenuNo();
				System.out.println("menuNo"+menuNo);
				List<MenuListVO> mlist  = menuListDAO.getAllByMenuNo(menuNo);
				System.out.println("mlis:"+mlist.size());
				
				MenuAllInfo menuAllInfo = new MenuAllInfo(menuVO,mlist);
				menuAllInfoList.add(menuAllInfo);
			}
			String jsonlist = gson.toJson(menuAllInfoList);
			writeText(res,jsonlist);
		}
		
		
		
		
		
		
		else if ("getImage".equals(action)) {
			OutputStream os = res.getOutputStream();
			String isbn = jsonObject.get("isbn").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			byte[] image = menuDAO.getImage(isbn);
			if (image != null) {
				// 縮圖 in server side
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(image.length);
			}
			os.write(image);
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
