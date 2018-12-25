package com.doctor.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.doctor.model.DoctorService;
import com.doctor.model.DoctorVO;
@WebServlet("/doctor.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class DoctorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public void deGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");// 需要嗎?
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");

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
					RequestDispatcher failureView = req.getRequestDispatcher("/doctor/selectDoctor_page.jsp");
					failureView.forward(req, res);
					return; // forward之後不是不會執行嗎?
				}
				String regex = "[D]\\d{4}";
				if (!str.matches(regex)) {
					errorMsgs.add("醫生編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/doctor/selectDoctor_page.jsp");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/doctor/selectDoctor_page.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("dvo", dvo);		
				String url = "/doctor/listOneDoctor.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage()); //ex?
				RequestDispatcher failureView = req.getRequestDispatcher("/doctor/selectDoctor_page.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************1.接收請求參數****************************************/
				String drno = req.getParameter("drno");
				/***************************2.開始查詢資料****************************************/
				DoctorService ds = new DoctorService();
				DoctorVO dvo = ds.getOneDoctor(drno);
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("dvo", dvo);
				String url = "/doctor/update_doctor_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage()); 
				RequestDispatcher failureView = req.getRequestDispatcher("/doctor/update_doctor_input.jsp");
				failureView.forward(req, res);
			}
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
			String url = "/doctor/listAllDoctor.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/doctor/listAllDoctor.jsp");
				failureView.forward(req, res);
			}		
		}
		
		if("update".equals(action)) {  //來自update_doctor_input.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String drno = req.getParameter("drno");
				String memno = req.getParameter("memno");
				
				String resume = req.getParameter("resume");
				if(resume == null || resume.trim().length() == 0) {
					errorMsgs.add("履歷： 請勿空白");
				}
				
				String isonline =  req.getParameter("isonline");
				if(isonline == null || isonline.trim().length() == 0) {
					errorMsgs.add("上線狀態： 請勿空白");
				}
				
				String status = req.getParameter("status");
				if(status == null || status.trim().length() == 0) {
					errorMsgs.add("看診權限： 請勿空白");
				}
				
				String major = req.getParameter("major");
				if(major == null || major.trim().length() == 0) {
					errorMsgs.add("科別： 請勿空白");
				}
				
				Integer fee = null;
				
				try {
					fee = new Integer(req.getParameter("fee"));
				}catch(NumberFormatException e) {
					fee = 0;
					errorMsgs.add("診療費用請填數字。");
				}
				
				
				byte[] photo = null;
				
				Part part = req.getPart("drPic");
				if(part.getSubmittedFileName().equals(null)||part.getSubmittedFileName().trim().length()==0) {
					DoctorService ds = new DoctorService();
					photo = ds.getOneDoctor(drno).getPhoto();
				}else {
					InputStream in = part.getInputStream();
					photo = new byte[in.available()];
					in.read(photo);
					in.close();
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
					RequestDispatcher failureView = req.getRequestDispatcher("/doctor/update_doctor_input.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料*****************************************/
				DoctorService ds = new DoctorService();
				dvo = ds.updateDoctor(drno, memno, resume, isonline, status, major, fee, photo);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("dvo", dvo);  
				String url = "/doctor/listOneDoctor.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/***************************其他可能的錯誤處理*************************************/
			}
			catch(Exception e){
				errorMsgs.add("修改資料失敗" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/doctor/update_doctor_input.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("insert".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/

				String memno = req.getParameter("memno");
				String regex = "[M]\\d{4}";
				
				if(memno == null || memno.trim().length() == 0) {
					errorMsgs.add("會員編號： 請勿空白");
				}else if (!memno.matches(regex)) {
					errorMsgs.add("會員編號格式不正確");
				}
				
				String resume = req.getParameter("resume");
				if(resume == null || resume.trim().length() == 0) {
					errorMsgs.add("履歷： 請勿空白");
				}
				
				String isonline =  req.getParameter("isonline");
				if(isonline == null || isonline.trim().length() == 0) {
					errorMsgs.add("上線狀態： 請勿空白");
				}
				
				String status = req.getParameter("status");
				if(status == null || status.trim().length() == 0) {
					errorMsgs.add("看診權限： 請勿空白");
				}
				
				String major = req.getParameter("major");
				if(major == null || major.trim().length() == 0) {
					errorMsgs.add("科別： 請勿空白");
				}
				
				Integer fee = null;
				
				try {
					fee = new Integer(req.getParameter("fee"));
				}catch(NumberFormatException e) {
					fee = 0;
					errorMsgs.add("診療費用請填數字。");
				}
				
				Part part = req.getPart("drPic");
				byte[] photo = null;
				if(part.getSubmittedFileName().equals(null)||part.getSubmittedFileName().trim().length()==0) {
					errorMsgs.add("請上傳照片");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/doctor/addDoctor.jsp");
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				DoctorService ds = new DoctorService();
				dvo = ds.addDoctor(memno, resume, isonline, status, major, fee, photo);  //為什麼要寫dvo=
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/doctor/listAllDoctor.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/***************************其他可能的錯誤處理**********************************/
			}catch (Exception e) {
				errorMsgs.add("新增資料失敗" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/doctor/addDoctor.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("getDrs_By_Major".equals(action)) {
			String major = req.getParameter("major");
			DoctorService ds = new DoctorService();
			List<DoctorVO> list = ds.getByMajor(major);
			req.setAttribute("major", major);
			req.setAttribute("list", list);
			RequestDispatcher successView = req.getRequestDispatcher("/doctor/getDrs_By_Major.jsp");	
			successView.forward(req, res);
		}
		
		if("uploadDrPhoto".equals(action)) {
			
		}
	}
}
