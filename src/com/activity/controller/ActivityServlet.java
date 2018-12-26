package com.activity.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;
import com.impression.model.ImpressionVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ActivityServlet extends HttpServlet{
	
	public void doget(HttpServletRequest req, HttpServletResponse res) 
		throws ServletException ,IOException{
			doPost(req,res);
		}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) 
		throws ServletException ,IOException{
			
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 ****************************************/
				String actNo = new String(req.getParameter("actNo"));
				System.out.println(actNo);

				/*************************** 2.開始查詢資料****************************************/
				ActivityService activitySvc = new ActivityService();
				Set<ImpressionVO> set = activitySvc.getmembyactno(actNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("act_imp", set);    // 資料庫取出的impressionVO物件,存入req

				String url = null;
				if ("getOne_For_Display".equals(action))
					url = "/activity/act_imp.jsp";        // 成功轉交 act_imp.jsp
				
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 ***********************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}

		
		
		
		
}	
}
