package com.license.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.activity.model.ActivityService;
import com.impression.model.ImpressionService;
import com.impression.model.ImpressionVO;
import com.license.model.LicenseService;
import com.license.model.LicenseVO;
import com.license.model.QualifyVO;
import com.member.model.MemberService;
import com.member.model.MemberVO;
@MultipartConfig
public class LicenseServlet extends HttpServlet{

		
		public void doget(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException ,IOException{
				doPost(req,res);
			}
		
		public void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException ,IOException{
				
			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");
			
			
	
	if("Show_One".equals(action)) {
				List<String> errorMsgs = new LinkedList<String>();
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/*****************1.接受請求參數-輸入格式錯誤處理*************/
					String licNo = req.getParameter("licNo");
					if(licNo==null||(licNo.trim()).length()==0) {
						errorMsgs.add("請輸入活動編號");
					}
					
					/***************************2.開始查詢資料*****************************************/
					LicenseService licenseSvc = new LicenseService();
					LicenseVO licenseVO = licenseSvc.getOneLic(licNo);
					if (licenseVO == null) {
						errorMsgs.add("查無資料");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front-end/license/licensesearch.jsp");
						failureView.forward(req, res);
						return;//程式中斷
					}
					
					/***************************3.查詢完成,準備轉交(Send the Success view)*************/
					req.setAttribute("licenseVO", licenseVO); // 資料庫取出的impressionVO物件,存入req
					String url = "/front-end/license/licone.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneImp.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理*************************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/license/licensesearch.jsp");
					failureView.forward(req, res);
				}
			}
			
	if ("getOne_For_Update".equals(action)) { // 來自actall.jsp的請求
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
				
				try {
					/***************************1.接收請求參數****************************************/
					String licNo = req.getParameter("licNo");
					System.out.println(licNo);
					String memNo = req.getParameter("memNo");
					System.out.println(memNo);
					String licStatus = req.getParameter("licStatus");
					System.out.println(licStatus);
					String ident = req.getParameter("ident");
					System.out.println(ident);
					
					
					
					/***************************2.開始查詢資料****************************************/
					LicenseService licenseSvc = new LicenseService();
					LicenseVO licenseVO = licenseSvc.changestatus(licNo, licStatus);
					MemberService memberSvc = new MemberService();
					MemberVO memberVO = memberSvc.changeident(ident, memNo);
									
					/***************************3.查詢完成,準備轉交(Send the Success view)************/
					req.setAttribute("licenseVO", licenseVO);         // 資料庫取出的activityVO物件,存入req
					String url = "/front-end/license/update_lic.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);//  成功轉交 update_act.jsp
					successView.forward(req, res);
			
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/license/licall.jsp");
					failureView.forward(req, res);
				}
			}

	if ("update".equals(action)) { //來自update_lic_input.jsp的請
				
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
//				try {
					/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
					String licNo = req.getParameter("licNo").trim();
					System.out.println(licNo);
					String memNo = req.getParameter("memNo").trim();
					System.out.println(memNo);
					
					byte[] licData = null;
					Part part = req.getPart("licData");
					System.out.println(part);
					if(part == null || part.getSubmittedFileName().trim().length() ==0) {
						LicenseService is = new LicenseService();
						licData = is.getOneLic(licNo).getLicData();	
					}else {
						InputStream in = part.getInputStream();
						licData = toByteArray(in);
						System.out.println("321");	
					}	
					String licStatus = req.getParameter("licStatus").trim();				
						if (licStatus == null || licStatus.trim().length() == 0) {
							errorMsgs.add("活動狀態請勿空白");
						}	
						
					String licDesc = req.getParameter("licDesc").trim();				
						if (licDesc == null || licDesc.trim().length() == 0) {
							LicenseService actSvc = new LicenseService();
							licDesc = actSvc.getOneLic(licNo).getLicDesc();
							errorMsgs.add("地點請勿空白");
						}		
						
					java.sql.Date licDue = null;
						try {
							licDue = java.sql.Date.valueOf(req.getParameter("licDue").trim());
						} catch (IllegalArgumentException e) {
							LicenseService actSvc = new LicenseService();
							licDue = actSvc.getOneLic(licNo).getLicDue();
							errorMsgs.add("請輸入日期!");
						}

						LicenseVO licenseVO = new LicenseVO();
						licenseVO.setLicNo(licNo);
						licenseVO.setMemNo(memNo);
						licenseVO.setLicData(licData);
						licenseVO.setLicStatus(licStatus);
						System.out.println(licStatus);
						licenseVO.setLicDesc(licDesc);
						licenseVO.setLicDue(licDue);
						
				
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("licenseVO", licenseVO); // 資料庫取出的activityVO物件,存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front-end/license/update_lic.jsp");
						failureView.forward(req, res);
						return; //程式中斷
					}
					
					/***************************2.開始修改資料�*****************************************/
					LicenseService licenseSvc = new LicenseService();
					licenseVO = licenseSvc.updateLic(licNo, memNo, licData, licStatus, licDesc, licDue);
					
					/***************************3.修改完成,準備轉交(Send the Success view)*************/
					req.setAttribute("licenseVO", licenseVO); // 資料庫update成功後,正確的的impressionVO物件,存入req
					String url = "/front-end/license/licone.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneImp.jsp
					successView.forward(req, res);

					/***************************其他可能的錯誤處理*************************************/
//				} catch (Exception e) {
//					errorMsgs.add("修改資料失敗:"+e.getMessage());
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/license/update_lic.jsp");
//					failureView.forward(req, res);
				}
			
			
			
	if ("insert".equals(action)) { // 來自addact.jsp的請求   
		
				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
					
					String memNo = req.getParameter("memNo").trim();
					System.out.println(memNo);
					if (memNo == null || memNo.trim().length() == 0) {
						errorMsgs.add("會員編號請勿空白");
					}
					
					byte[] licData = null;
					Part part = req.getPart("licData");
					InputStream in = part.getInputStream();
					licData = toByteArray(in);
					System.out.println("321");
					
					String licStatus = req.getParameter("licStatus").trim();
						if (licStatus == null || licStatus.trim().length() == 0) {
							errorMsgs.add("活動名稱請勿空白");
						}
					String licDesc = req.getParameter("licDesc").trim();				
						if (licDesc == null || licDesc.trim().length() == 0) {
							errorMsgs.add("地點請勿空白");
						}
						
					java.sql.Date licDue = null;
						try {
							licDue = java.sql.Date.valueOf(req.getParameter("licDue").trim());
						} catch (IllegalArgumentException e) {
							licDue = new java.sql.Date(System.currentTimeMillis());
							errorMsgs.add("請輸入日期!");
						}
					
					
					

					LicenseVO licenseVO = new LicenseVO();
					licenseVO.setMemNo(memNo);
					licenseVO.setLicData(licData);
					licenseVO.setLicStatus(licStatus);
					licenseVO.setLicDesc(licDesc);
					licenseVO.setLicDue(licDue);
			
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("licenseVO", licenseVO); // 資料庫取出的activityVO物件,存入req
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front-end/license/addlic.jsp");
						failureView.forward(req, res);
						return;
					}
					
					/***************************2.開始新增資料***************************************/
					LicenseService licenseSvc = new LicenseService();
					licenseVO = licenseSvc.addLic(memNo, licData, licStatus, licDesc, licDue);				
					/***************************3..新增完成,準備轉交(Send the Success view)***********/
					String url = "/front-end/license/licall.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 
					successView.forward(req, res);				
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add(e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/license/addlic.jsp");
					failureView.forward(req, res);
				}
			}

	if ("delete".equals(action)) { // 來自listAllEmp.jsp

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);
			
				try {
					/***************************1.接收請求參數***************************************/
					String licNo = new String(req.getParameter("licNo"));
					
					/***************************2.開始刪除資料***************************************/
					LicenseService licenseSvc = new LicenseService();
					licenseSvc.delete(licNo);
					
					/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
					String url = "/front-end/license/licall.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
					successView.forward(req, res);
					
					/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
					errorMsgs.add("刪除資料失敗:"+e.getMessage());
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/license/licall.jsp");
					failureView.forward(req, res);
				}
	}
	if ("check_qualify".equals(action)) {

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);

		try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 ****************************************/
			String licStatus = new String(req.getParameter("licStatus"));
			System.out.println(licStatus);

			/*************************** 2.開始查詢資料****************************************/
			LicenseService licenseSvc = new LicenseService();
			Set<QualifyVO> set = licenseSvc.getChange(licStatus);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("qual_by_lic", set);    // 資料庫取出的impressionVO物件,存入req
			System.out.println(set);
			String url = "/back-end/qualify/qual_by_lic.jsp";        // 成功轉交 act_imp.jsp
			
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 ***********************************/
		} catch (Exception e) {
			throw new ServletException(e);
		}
	}
	
//	==================addBy彥廷===============================================
	if ("insertByDr".equals(action)) {    
		
		List<String> errorMsgs = new LinkedList<String>();
		// Store this set in the request scope, in case we need to
		// send the ErrorPage view.
		req.setAttribute("errorMsgs", errorMsgs);
	
		try {
			/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
			
			String memNo = req.getParameter("memNo").trim();
			System.out.println(memNo);
			if (memNo == null || memNo.trim().length() == 0) {
				errorMsgs.add("會員編號請勿空白");
			}
			
			byte[] licData = null;
			Part part = req.getPart("licData");
			InputStream in = part.getInputStream();
			licData = toByteArray(in);
			System.out.println("321");
			
			String licStatus = req.getParameter("licStatus").trim();
				if (licStatus == null || licStatus.trim().length() == 0) {
					errorMsgs.add("證照狀態請勿空白");
				}
			String licDesc = req.getParameter("licDesc").trim();				
				if (licDesc == null || licDesc.trim().length() == 0) {
					errorMsgs.add("證照描述請勿空白");
				}
				
			java.sql.Date licDue = null;
				try {
					licDue = java.sql.Date.valueOf(req.getParameter("licDue").trim());
				} catch (IllegalArgumentException e) {
					licDue = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}
			
			
			

			LicenseVO licenseVO = new LicenseVO();
			licenseVO.setMemNo(memNo);
			licenseVO.setLicData(licData);
			licenseVO.setLicStatus(licStatus);
			licenseVO.setLicDesc(licDesc);
			licenseVO.setLicDue(licDue);
	
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("licenseVO", licenseVO); // 資料庫取出的activityVO物件,存入req
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/license/addlic.jsp");
				failureView.forward(req, res);
				return;
			}
			
			/***************************2.開始新增資料***************************************/
			LicenseService licenseSvc = new LicenseService();
			licenseVO = licenseSvc.addLic(memNo, licData, licStatus, licDesc, licDue);				
			/***************************3..新增完成,準備轉交(Send the Success view)***********/
			String url = "/front-end/doctor/admin/pages/dr_admin.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 
			successView.forward(req, res);				
			
			/***************************其他可能的錯誤處理**********************************/
		} catch (Exception e) {
			errorMsgs.add(e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher("/front-end/license/addlic.jsp");
			failureView.forward(req, res);
		}
	}
	
	
	
	if ("drCheck_qualify".equals(action)) {

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);

//		try {
			/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 ****************************************/
			String licStatus = new String(req.getParameter("licStatus"));
			System.out.println(licStatus);

			/*************************** 2.開始查詢資料****************************************/
			LicenseService licenseSvc = new LicenseService();
			Set<QualifyVO> set = licenseSvc.getChange(licStatus);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("qual_by_lic", set);    // 資料庫取出的impressionVO物件,存入req
			System.out.println(set);
			String url = "/back-end/qualify/drQual.jsp";        // 成功轉交 act_imp.jsp
			
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

			/*************************** 其他可能的錯誤處理 ***********************************/
//		} catch (Exception e) {
//			throw new ServletException(e);
//		}
	}
	
	if ("update".equals(action)) {
		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		
		try {
			/***************************1.接收請求參數****************************************/
			String licNo = req.getParameter("licNo");
			System.out.println(licNo);
			String memNo = req.getParameter("memNo");
			System.out.println(memNo);
			String licStatus = req.getParameter("licStatus");
			System.out.println(licStatus);
			String ident = req.getParameter("ident");
			System.out.println(ident);
		
		}catch(Exception e) {
		}
	}
//	==================addBy彥廷===============================================
	}	
		public static byte[] toByteArray(InputStream input) throws IOException {
		    ByteArrayOutputStream output = new ByteArrayOutputStream();
		    byte[] buffer = new byte[4096];
		    int n = 0;
		    while (-1 != (n = input.read(buffer))) {
		        output.write(buffer, 0, n);
		    }
		    return output.toByteArray();
		}
	}


