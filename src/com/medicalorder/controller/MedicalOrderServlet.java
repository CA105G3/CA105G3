package com.medicalorder.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.medicalorder.model.MedicalOrderDAO;
import com.medicalorder.model.MedicalOrderVO;

public class MedicalOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			
			List<String> errMsgs = new LinkedList<String>();
			req.setAttribute("errMsgs", errMsgs);
			
			String memNo = req.getParameter("memNo");
			String memNoReq = "^[(A)(0-9)] {5}$";
			if(memNo == null || memNo.trim().length()==0) {
				errMsgs.add("會員編號請勿空白");
			}else if(!memNo.trim().matches(memNoReq)) {
				errMsgs.add("會員編號請輸入大寫A開頭再加4個數字");
			}
			
			
			
		}
		
		
	}

}
