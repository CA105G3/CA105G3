package com.joinact.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;
import com.joinact.model.JoinActService;
import com.joinact.model.JoinActVO;
import com.joinact.model.PersonActVO;

public class JoinActServlet extends HttpServlet{
	
	public void doget(HttpServletRequest req, HttpServletResponse res) 
		throws ServletException ,IOException{
			doPost(req,res);
		}
		
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException ,IOException{		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
			
		if ("delete".equals(action)) { // 來自personact.jsp
	
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數***************************************/
				String actNo = new String(req.getParameter("actNo"));
				System.out.println(actNo);
				String memNo = new String(req.getParameter("memNo"));
				System.out.println(memNo);
				
				
				/***************************2.開始刪除資料***************************************/
				JoinActService joinActSvc = new JoinActService();
				joinActSvc.delete(actNo,memNo);
				Set<PersonActVO> personactVO = joinActSvc.getAll(memNo);
				if (personactVO == null) {
					errorMsgs.add("查無資料");
				}
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/		
				req.setAttribute("personactVO", personactVO);
				String url = "/front-end/activity/personact.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/personact.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("personfile".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數***************************************/
				String memNo = req.getParameter("memNo");
				System.out.println(memNo);
				/***************************2.開始查詢資料*****************************************/
				JoinActService joinActSvc = new JoinActService();
				Set<PersonActVO> personActVO = joinActSvc.getAll(memNo);
				if (personActVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("personActVO", personActVO); // 資料庫取出的impressionVO物件,存入req
				String url = "/front-end/activity/personact.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneImp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/activity/joinactivity.jsp");
				failureView.forward(req, res);
			}
		}
	}		
}
