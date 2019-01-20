package Android.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import Android.member.model.*;

public class AndroidMemberServlet extends HttpServlet {
	
	
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		
		//------------------------------------------------
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		System.out.println("input: " + jsonIn);
		//-------------------------------------------------
		
		
		
		
		//--------------------------------------------------------------------------
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		String action = null;
		try {
			action = jsonObject.get("action").getAsString();
		}catch(NullPointerException npe) {
			System.out.println("Startup Tomcat or No action catch");
		}
		//--------------------------------------------------------------------------
		
		
		
		//--------------------------------------------------------------------------
		MemberDAO_interface memberDao = new MemberDAO();
		if ("isMember".equals(action)) {
			
			String userId = jsonObject.get("userId").getAsString();
			String password = jsonObject.get("password").getAsString();
			writeText(res,	String.valueOf(memberDao.isMember(userId, password)));
			
		} 
		else if ("isUserIdExist".equals(action)) {
			
			String userId = jsonObject.get("userId").getAsString();
			writeText(res, String.valueOf(memberDao.isUserIdExist(userId)));
			
		} else if ("add".equals(action)) {
			
			MemberVO member = gson.fromJson(jsonObject.get("member").getAsString(), MemberVO.class);
			writeText(res, String.valueOf(memberDao.insert(member)));
			
		} else if ("findById".equals(action)) {
			
			String userId = jsonObject.get("userId").getAsString();
			MemberVO member = memberDao.findById(userId);
			writeText(res, member == null ? "" : gson.toJson(member));
			
		} else if ("update".equals(action)) {
			
			MemberVO member = gson.fromJson(jsonObject.get("member").getAsString(), MemberVO.class);
			writeText(res, String.valueOf(memberDao.update(member)));
			
		}
		//------------------------------------------------------------------------------------------------
	}

	
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	
	
	//-----------------------------------------------------------------------------------------------------
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);

	}
	//------------------------------------------------------------------------------------------------------
}
