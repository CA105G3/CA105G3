package com.administrator.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.administrator.model.*;
import com.ppttool.model.PPTToolService;
import com.ppttool.model.PPTToolVO;

/**
 * Servlet implementation class AdminServlet
 */

public class AdminServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected boolean allowUser(String adminId, String adminPsw) {
		
		AdministratorService adminSvc = new AdministratorService();
		AdministratorVO adminVO = adminSvc.findByIdPsw(adminId);
		
		if(adminVO == null) {
			return false;
		} else if(adminId.equals(adminVO.getAdminId())&&adminPsw.equals(adminVO.getAdminPsw())) {
			return true;
		} else {
			return false;
		}
		
//		int i=0;		//Jim的版本
//		List<AdministratorVO> list =adminSvc.getAll();
//		for(AdministratorVO adminVO : list) {
//			if(adminId.equals(adminVO.getAdminId())&&adminPsw.equals(adminVO.getAdminPsw())) {
//				i=i+1;
//			}
//		}
//		if(i!=0) {
//			return true;
//		}else {
//			return false;
//		}
		
	}	
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if("adminLogout".equals(action)) {
			//移除session的物件
			HttpSession session = req.getSession();
			session.removeAttribute("adminVO");
			//轉回登入頁面
			String url = "/back-end/admin/adminLogin.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
			successView.forward(req, res);	
		}
		
		
		if("adminLogin".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String adminId = req.getParameter("adminId").trim();
				if (adminId == null || (adminId.trim()).length() == 0) {
					errorMsgs.add("請輸入帳號");
				}
				String adminPsw = req.getParameter("adminPsw").trim();
				if (adminPsw == null || (adminPsw.trim()).length() == 0) {
					errorMsgs.add("請輸入密碼");
				}
			
				AdministratorVO adminVO = new AdministratorVO();
				adminVO.setAdminId(adminId);
				adminVO.setAdminPsw(adminPsw);
				
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/admin/adminLogin.jsp");					
					failureView.forward(req, res);					
					return;//程式中斷
				}
				
				/***************************2.檢查帳號密碼是否有效**********************/
				
				if(!allowUser(adminId, adminPsw)) {
					errorMsgs.add("密碼錯誤");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back-end/admin/adminLogin.jsp");					
					failureView.forward(req, res);					
					return;//程式中斷
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				}else {
					AdministratorService adminSvc = new AdministratorService();
					AdministratorVO adminVO1 = adminSvc.findByIdPsw(adminId);
					HttpSession session = req.getSession();					
					session.setAttribute("adminVO", adminVO1);

					String url = "/back-end/admin/adminLoginMain.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); //成功後轉交給"/back-end/admin/adminLoginSuccess.jsp"
					successView.forward(req, res);				
				}
			
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back-end/admin/adminLoginSuccess.jsp");
				failureView.forward(req, res);
			}
			
		}
		
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("adminno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入Admin編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/admin/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String adminno = null;
				try {
					adminno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("Admin編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/admin/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				AdministratorService adminSvc = new AdministratorService();
				AdministratorVO adminVO  = adminSvc.getOneAdmin(adminno);
				if (adminVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/ppt/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adminVO",adminVO); // 資料庫取出的empVO物件,存入req
				String url = "/admin/listOneAdmin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/ppt/select_page.jsp");
				failureView.forward(req, res);
			}
		}//End-point getOne_For_Display
		
		if ("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String adminId=req.getParameter("adminId");
				String adminidReg = "^[(a-zA-Z0-9)]{1,10}$";
				if (adminId == null || adminId.trim().length() == 0) {
					errorMsgs.add("管理員名稱: 請勿空白");
				} else if(!adminId.trim().matches(adminidReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員名稱: 只能是英文字母、數字 , 且長度必需為10");
	            }
				
				String adminPsw=req.getParameter("adminPsw");
				String adminpswReg = "^[(a-zA-Z0-9)]{1,10}$";
				if (adminPsw == null || adminPsw.trim().length() == 0) {
					errorMsgs.add("管理員密碼: 請勿空白");
				} else if(!adminPsw.trim().matches(adminpswReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員密碼:只能是英文字母、數字 , 且長度必需為10");
	            }
				String adminName = req.getParameter("adminName");
				String priority=req.getParameter("priority").trim();
				
				String status=req.getParameter("status").trim();
				
				
				java.sql.Date reg = null;
				try {
					reg = java.sql.Date.valueOf(req.getParameter("reg").trim());
				} catch (IllegalArgumentException e) {
					reg=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				AdministratorVO adminVO = new AdministratorVO();
				adminVO.setAdminId(adminId);
				adminVO.setAdminPsw(adminPsw);
				adminVO.setPriority(priority);
				adminVO.setStatus(status);
				adminVO.setReg(reg);
				
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("adminVO", adminVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/admin/addAdmin.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				AdministratorService adminSvc = new AdministratorService();
				adminVO = adminSvc.addAdmin(adminId, adminId, adminName, priority, status, reg);

				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/admin/ListAllAdmin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
				
			}catch(Exception e) {
				errorMsgs.add("新增資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/admin/addAdmin.jsp");
				failureView.forward(req, res);
			}
		}//End-point insert
		
		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String adminno = new String(req.getParameter("adminno"));
				
				AdministratorService adminSvc = new AdministratorService();
				adminSvc.deleteAdmin(adminno);
				
				String url="/admin/ListAllAdmin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/admin/ListAllAdmin.jsp");
				failureView.forward(req, res);
			}
		}//End-point delete
		
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String adminno = new String(req.getParameter("admino"));
				
				String adminid=req.getParameter("adminid");
				String adminidReg = "^[(a-zA-Z0-9)]{1,10}$";
				if (adminid == null || adminid.trim().length() == 0) {
					errorMsgs.add("管理員名稱: 請勿空白");
				} else if(!adminid.trim().matches(adminidReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員名稱: 只能是英文字母、數字 , 且長度必需為10以內");
	            }
				
				String adminpsw=req.getParameter("adminpsw");
				String adminpswReg = "^[(a-zA-Z0-9)]{1,10}$";
				if (adminpsw == null || adminpsw.trim().length() == 0) {
					errorMsgs.add("管理員密碼: 請勿空白");
				} else if(!adminpsw.trim().matches(adminpswReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員密碼:只能是英文字母、數字 , 且長度必需為10以內");
	            }
				
				String priority=req.getParameter("priority").trim();
				
				String status=req.getParameter("status").trim();
				
				java.sql.Date reg = null;
				try {
					reg = java.sql.Date.valueOf(req.getParameter("reg").trim());
				} catch (IllegalArgumentException e) {
					reg=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
				
				String adminName = req.getParameter("adminName");
				
				System.out.println(adminno);
				System.out.println(adminid);
				System.out.println(adminpsw);
				System.out.println(priority);
				System.out.println(status);
				System.out.println(reg);
				
				
				AdministratorVO adminVO = new AdministratorVO();
				adminVO.setAdminNo(adminno);
				adminVO.setAdminId(adminid);
				adminVO.setAdminName(adminName);
				adminVO.setAdminPsw(adminpsw);
				adminVO.setPriority(priority);
				adminVO.setStatus(status);
				adminVO.setReg(reg);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("adminVO", adminVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/admin/update_admin_input.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始修改資料*****************************************/
				AdministratorService adminSvc = new AdministratorService();
				adminVO = adminSvc.updateAdmin(adminno,adminid,adminpsw,adminName,priority,status,reg);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("adminVO", adminVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/admin/listOneAdmin.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			}catch(Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/admin/update_admin_input.jsp");
				failureView.forward(req, res);
			}
		}//End-point update
		
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String adminno = new String(req.getParameter("adminno"));
				
				/***************************2.開始查詢資料****************************************/
				AdministratorService adminSvc = new AdministratorService();
				AdministratorVO adminVO  = adminSvc.getOneAdmin(adminno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("adminVO", adminVO);         // 資料庫取出的empVO物件,存入req
				String url = "/admin/update_admin_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/ppt/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
