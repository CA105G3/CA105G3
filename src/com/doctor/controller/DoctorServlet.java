package com.doctor.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.doctor.model.DoctorService;
import com.doctor.model.DoctorVO;
@WebServlet("/doctor.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class DoctorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");// 需要嗎?
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		System.out.println(action);
		if ("getOne_For_Display".equals(action)) { // 來自selectDoctor.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("drno");
				if (str == null || str.trim().length() == 0) { // 問一下老師
					errorMsgs.add("請輸入醫生編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/selectDoctor_page.jsp");
					failureView.forward(req, res);
					return; // forward之後不是不會執行嗎?
				}
				String regex = "[D]\\d{4}";
				if (!str.matches(regex)) {
					errorMsgs.add("醫生編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/selectDoctor_page.jsp");
					failureView.forward(req, res);
					return;
				}
				/*************************** 2.開始查詢資料 *****************************************/
				DoctorService ds = new DoctorService();
				DoctorVO dvo = ds.getOneDoctor(str);
				if(dvo == null) {
					errorMsgs.add("查無資料");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/selectDoctor_page.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("dvo", dvo);		
				String url = "/front-end/doctor/listOneDoctor.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); //ex?
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/selectDoctor_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
//			req.setAttribute("errorMsgs", errorMsgs);
//			try {
				/***************************1.接收請求參數****************************************/
				String drno = req.getParameter("drno");
				/***************************2.開始查詢資料****************************************/
				DoctorService ds = new DoctorService();
				DoctorVO dvo = ds.getOneDoctor(drno);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("dvo", dvo);
				String url = "/front-end/doctor/update_doctor_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
//			}catch(Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage()); 
//				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/update_doctor_input.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		if("delete".equals(action)) {  
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
			/***************************1.接收請求參數***************************************/
			String drno = req.getParameter("drno");
			
			/***************************2.開始刪除資料***************************************/
			DoctorService ds = new DoctorService();
			ds.deleteDoctor(drno);
			
			/***************************3.刪除完成,準備轉交(Send the Success view)***********/
			String url = "/front-end/doctor/listAllDoctor.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/listAllDoctor.jsp");
				failureView.forward(req, res);
			}		
		}
		
		if("update".equals(action)) {  //來自update_doctor_input.jsp的請求
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String drno = req.getParameter("drno");
				String memno = req.getParameter("memno");
				
				String resume = req.getParameter("resume");
				if(resume == null || resume.trim().length() == 0) {
					errorMsgs.put("resume","履歷： 請勿空白");
				}
				
				String isonline =  req.getParameter("isonline");
				if(isonline == null || isonline.trim().length() == 0) {
					errorMsgs.put("isonline","上線狀態： 請勿空白");
				}
				
				String status = req.getParameter("status");
				if(status == null || status.trim().length() == 0) {
					errorMsgs.put("status","看診權限： 請勿空白");
				}
				
				String major = req.getParameter("major");
				if(major == null || major.trim().length() == 0) {
					errorMsgs.put("major","科別： 請勿空白");
				}
				
				Integer fee = null;
				
				try {
					fee = new Integer(req.getParameter("fee"));
				}catch(NumberFormatException e) {
					fee = 1;
					errorMsgs.put("fee","診療費用請填數字。");
				}
				
				if(fee <= 0) {
					errorMsgs.put("fee","診療費用請填正整數。");
				}
				
				
				byte[] photo = null;
				
				Part part = req.getPart("drPic");
				if(part.getSubmittedFileName().equals(null)||part.getSubmittedFileName().trim().length()==0) {
					System.out.println("沒選照片");
					DoctorService ds = new DoctorService();
					photo = ds.getOneDoctor(drno).getPhoto();
				}else if(part.getContentType().substring(0,5).equals("image")){
					System.out.println("有選檔案");
					System.out.println(part.getSubmittedFileName());
					System.out.println(part.getContentType().substring(0,5));
					InputStream in = part.getInputStream();
					photo = new byte[in.available()];
					in.read(photo);
					in.close();
				}else {
					errorMsgs.put("photo", "請選擇圖檔");
				}
				
				
//				Collection<Part> parts = req.getParts();
//				byte[] photo = null;
//				try {
//					for(Part part : req.getParts()) {
//						System.out.println(part);
//						if(part.getSubmittedFileName().equals(null)||part.getSubmittedFileName().trim().length()==0) {
//							errorMsgs.add("請上傳照片");
//						}
//						InputStream in = part.getInputStream();
//						photo = new byte[in.available()];
//						in.read(photo);
//						in.close();
//					}
//				}catch(Exception e) {
//					errorMsgs.add("請選擇照片");
//				}
				
				
				DoctorVO dvo = new DoctorVO();
				dvo.setDrno(drno);
				dvo.setMemno(memno);
				dvo.setResume(resume);
				dvo.setIsonline(isonline);
				dvo.setStatus(status);
				dvo.setMajor(major);
				dvo.setFee(fee);
				dvo.setPhoto(photo); 	
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("dvo", dvo);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/update_doctor_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料*****************************************/
				DoctorService ds = new DoctorService();
//				StringBuffer sb = new StringBuffer(resume);
//				resume = sb.insert(0, "<pre>").append("</pre>").toString();
				dvo = ds.updateDoctor(drno, memno, resume, isonline, status, major, fee, photo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("dvo", dvo);  
				String url = "/front-end/doctor/update_doctor_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			}
			catch(Exception e){
				errorMsgs.put("exception","修改資料失敗" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/update_doctor_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("insert".equals(action)) {
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

				String memno = req.getParameter("memno");
				System.out.println(memno);
//				String regex = "[M]\\d{4}";
				
//				if(memno == null || memno.trim().length() == 0) {
//					errorMsgs.add("會員編號： 請勿空白");
//				}else if (!memno.matches(regex)) {
//					errorMsgs.add("會員編號格式不正確");
//				}
				
				String resume = req.getParameter("resume");
				System.out.println(resume);
				if(resume == null || resume.trim().length() == 0) {
					errorMsgs.put("resume","經歷： 請勿空白");
				}
				
				String isonline =  req.getParameter("isonline");
				System.out.println(isonline);
//				if(isonline == null || isonline.trim().length() == 0) {
//					errorMsgs.add("上線狀態： 請勿空白");
//				}
				
				String status = req.getParameter("status");
				System.out.println(status);
//				if(status == null || status.trim().length() == 0) {
//					errorMsgs.add("看診權限： 請勿空白");
//				}
				
				String major = req.getParameter("major");
				System.out.println(major);
//				if(major == null || major.trim().length() == 0) {
//					errorMsgs.add("科別： 請勿空白");
//				}
				
				Integer fee = null;
				
				try {
					fee = new Integer(req.getParameter("fee"));
				}catch(NumberFormatException e) {
					fee = 1;
					errorMsgs.put("fee","診療費用請填數字。");
				}
				
				if(fee <= 0) {
					errorMsgs.put("fee","診療費用請填正整數。");
				}
				System.out.println("hello");
				Part part = req.getPart("drPic");
				byte[] photo = null;
				if(part.getSubmittedFileName().equals(null)||part.getSubmittedFileName().trim().length()==0) {
					errorMsgs.put("photo","請上傳照片");
				}else{
					InputStream in = part.getInputStream();
					photo = new byte[in.available()];
					in.read(photo);
					in.close();	
					req.setAttribute("photo", photo);
				}
							
				
				DoctorVO dvo = new DoctorVO();
				dvo.setMemno(memno);
				dvo.setResume(resume);
				dvo.setIsonline(isonline);
				dvo.setStatus(status);
				dvo.setMajor(major);
				dvo.setFee(fee);
				dvo.setPhoto(photo);  			
				
				if(!errorMsgs.isEmpty()) {
					req.setAttribute("dvo", dvo);
					System.out.println("test");
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/doctor/addDoctor.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				DoctorService ds = new DoctorService();
//				StringBuffer sb = new StringBuffer(resume);
//				resume = sb.insert(0, "<pre>").append("</pre>").toString();
				ds.addDoctor(memno, resume, isonline, status, major, fee, photo);  
				dvo = ds.getDrno(memno);
				String drno = dvo.getDrno();
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
//				String url = "/front-end/doctor/listAllDoctor.jsp";
				String url ="/front-end/doctor/admin/pages/dr_admin.jsp";
//				String url = "/front-end/license/drAddlic.jsp";
				HttpSession session = req.getSession();
				session.setAttribute("drno", drno);
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
//			}catch (Exception e) {
//				errorMsgs.put("insert","新增資料失敗" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/doctor/addDoctor.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		if("getDrs_By_Major".equals(action)) {
			String major = req.getParameter("major");
			DoctorService ds = new DoctorService();
			List<DoctorVO> list = ds.getByMajor(major);
			req.setAttribute("major", major);
			req.setAttribute("list", list);
			RequestDispatcher successView = req.getRequestDispatcher("/front-end/doctor/getDrs_By_Major.jsp");	
			successView.forward(req, res);
		}
		
		if("enter_dr_admin".equals(action)) {			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			try {
				String memno = req.getParameter("memno");
				DoctorService ds = new DoctorService();
				DoctorVO dvo = ds.getDrno(memno);
				if(dvo == null) {
//					requestURL = req.getServletPath();
//					System.out.println(requestURL);
					RequestDispatcher addDoctorView = req.getRequestDispatcher("/front-end/doctor/addDoctor.jsp");
					addDoctorView.forward(req, res);
					return;
				}
				String drno = dvo.getDrno();
//				req.setAttribute("drno", drno);
				
				String url ="/front-end/doctor/admin/pages/dr_admin.jsp";
				HttpSession session = req.getSession();
				session.setAttribute("drno", drno);
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.put("error","此頁面為醫療人員專屬" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				return;
			}
		}
	}
}
