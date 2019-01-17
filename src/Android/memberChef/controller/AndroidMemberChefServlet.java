package Android.memberChef.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import Android.memberChef.modle.MemberChefDAO_interface;
import Android.memberChef.modle.MemberChefJDBCDAO;
import Android.memberChef.modle.MemberChefVO;
import Android.utilities.ImageUtil;

public class AndroidMemberChefServlet  extends HttpServlet {
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
		MemberChefDAO_interface memberChefDAO = new MemberChefJDBCDAO();
		
		if("allChefInfo".equals(action)) {
			List<MemberChefVO> memberChefVOs = memberChefDAO.getAll();
			Iterator<MemberChefVO> it = memberChefVOs.iterator();
	        MemberChefVO memberChefVO;
	        
	        while(it.hasNext()){
	            memberChefVO = it.next();
	            if("停用".equals(memberChefVO.getChefStatus())||"審核中".equals(memberChefVO.getChefStatus())){
	                it.remove();
	            }
	        }
	        
			String jsonOut = gson.toJson(memberChefVOs);
			writeText(res,jsonOut);
		}
		
		
		else if ("getImage".equals(action)) {
			OutputStream os = res.getOutputStream();
			String isbn = jsonObject.get("isbn").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			byte[] image = memberChefDAO.getImage(isbn);
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
