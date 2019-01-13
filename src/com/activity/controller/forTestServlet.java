package com.activity.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.activity.model.ActivityDAO;
import com.activity.model.ActivityVO;

public class forTestServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String action = req.getParameter("action");
	
		if ("getOne_From06".equals(action)) {

			try {
				// Retrieve form parameters.
				String actNo = new String(req.getParameter("actNo"));

				ActivityDAO dao = new ActivityDAO();
				ActivityVO actVO = dao.findByPrimaryKey(actNo);

				req.setAttribute("actVO", actVO); // 資料庫取出的empVO物件,存入req
				
				//Bootstrap_modal
				boolean openModal=true;
				req.setAttribute("openModal",openModal );
				
				// 取出的empVO送給listOneEmp.jsp
				RequestDispatcher successView = req
						.getRequestDispatcher("/front-end/activity/actall.jsp");
				successView.forward(req, res);
				return;

				// Handle any unusual exceptions
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
		
	}
}
