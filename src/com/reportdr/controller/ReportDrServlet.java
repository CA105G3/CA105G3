package com.reportdr.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medicalorder.model.MedicalOrderService;
import com.medicalorder.model.MedicalOrderVO;
import com.reportdr.model.ReportDrService;
import com.reportdr.model.ReportDrVO;

/**
 * Servlet implementation class ReportDrServlet
 */

public class ReportDrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
			
		//新增一筆資料
		if ("insert".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				// 會員編號
				String memNo = req.getParameter("memNo");
				String memNoReq = "^[(M)(0-9)] {5}$";
				if (memNo == null || memNo.trim().length() == 0) {
					errorMsgs.add("會員編號請勿空白");
				}
//				else if(!memNo.trim().matches(memNoReq)) {
//					errorMsgs.add("會員編號請輸入大寫M開頭再加4個數字");
//				}
				// 醫療人員編號
				String drNo = req.getParameter("drNo");

				// 檢舉理由
				String rdrReason = req.getParameter("rdrReason").trim();
				if (rdrReason == null || rdrReason.trim().length() == 0) {
					errorMsgs.add("檢舉理由請勿空白");
				}

				String rdrState = "未處理";

				ReportDrVO reportDrVO = new ReportDrVO();
				reportDrVO.setMemNo(memNo);
				reportDrVO.setDrNo(drNo);
				reportDrVO.setRdrReason(rdrReason);
				reportDrVO.setRdrState(rdrState);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportDrVO", reportDrVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/reportDr/addReportDr.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始新增資料 ***************************************/
				ReportDrService rdSvc = new ReportDrService();
				reportDrVO = rdSvc.addReportDr(memNo, drNo, rdrReason, rdrState);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("reportDrVO", reportDrVO);
				String url = "/front-end/reportDr/listAllReportDr.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/reportDr/addReportDr.jsp");
				failureData.forward(req, res);
			}
		}
		
		//查詢單筆檢舉資料
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("rdrNo");
				
				/*************************** 2.開始查詢資料 *****************************************/
				ReportDrService rdSvc = new ReportDrService();
				ReportDrVO reportDrVO = rdSvc.getOneReportDr(str);

				if (reportDrVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("front-end/medicalOrder/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("reportDrVO", reportDrVO); // 資料庫取出的empVO物件,存入req

				String url = "/front-end/reportDr/listOneReportDr.jsp";

				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("front-end/reportDr/select_page.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				String rdrNo = req.getParameter("rdrNo");
				
				/*************************** 2.開始查詢資料 ****************************************/
				ReportDrService rdSvc = new ReportDrService();
				ReportDrVO reportDrVO = rdSvc.getOneReportDr(rdrNo);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("reportDrVO", reportDrVO); // 資料庫取出的empVO物件,存入req
				String url = "/front-end/reportDr/update_ReportDr_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reportDr/listAllReportDr.jsp");
				failureView.forward(req, res);
			}
		}
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				
				//檢舉編號
				String rdrNo = req.getParameter("rdrNo");

				//處理狀態
				String rdrState = req.getParameter("rdrState");
				if ("未處理".equals(rdrState) ) {
					errorMsgs.add("請處理檢舉");
				}
				
				//測試用
				String memNo = req.getParameter("memNo");
				String drNo = req.getParameter("drNo");
System.out.println(drNo);
				String rdrReason = req.getParameter("rdrReason");
				java.sql.Date rdrTime = null;
				try {
					rdrTime = java.sql.Date.valueOf(req.getParameter("rdrTime").trim());
				} catch (IllegalArgumentException e) {
					rdrTime=new java.sql.Date(System.currentTimeMillis());
				}	
				ReportDrVO reportDrVO = new ReportDrVO();
				reportDrVO.setRdrNo(rdrNo);
				reportDrVO.setRdrState(rdrState);
				reportDrVO.setMemNo(memNo);
				reportDrVO.setDrNo(drNo);
				reportDrVO.setRdrTime(rdrTime);
				reportDrVO.setRdrState(rdrState);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("reportDrVO", reportDrVO);
					RequestDispatcher failureData = req
							.getRequestDispatcher("/front-end/reportDr/update_ReportDrVO_input.jsp");
					failureData.forward(req, res);
					return;
				}
				/*************************** 2.開始修改資料 ***************************************/
				ReportDrService rdSvc = new ReportDrService();
				reportDrVO = rdSvc.update_rdrStateReportDr(rdrState, rdrNo);

				/*************************** 3.修改完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("reportDrVO", reportDrVO);
				String url = "/front-end/reportDr/listAllReportDr.jsp";
				RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successData.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/reportDr/update_ReportDr_input.jsp");
//				failureData.forward(req, res);
//			}

		}
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String rdrNo = req.getParameter("rdrNo");
			
				/***************************2.開始刪除資料***************************************/
				ReportDrService rdSvc = new ReportDrService();
				rdSvc.deleteReportDr(rdrNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/reportDr/listAllReportDr.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/reportDr/listAllReportDr.jsp");
				failureView.forward(req, res);
			}
		}

	}
	
}
