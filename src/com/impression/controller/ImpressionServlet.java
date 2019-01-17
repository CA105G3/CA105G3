package com.impression.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.impression.model.ImpressionService;
import com.impression.model.ImpressionVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ImpressionServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}


	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
	
		if ("getOne_For_Display".equals(action)) { //來自impsearch.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String impNo = req.getParameter("impNo");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入心得編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/impression/impsearch.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
//				
//				String impNo = null;
//				try {
//					impNo = new String(str);
//				} catch (Exception e) {
//					errorMsgs.add("心得編號格式不正確");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/front-end/impression/impsearch.jsp");
//					failureView.forward(req, res);
//					return;//程式中斷
//				}
				
				/***************************2.開始查詢資料*****************************************/
				ImpressionService impressionSvc = new ImpressionService();
				ImpressionVO impressionVO = impressionSvc.getOneImp(impNo);
				if (impressionVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/impression/impsearch.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("impressionVO", impressionVO); // 資料庫取出的impressionVO物件,存入req
				String url = "/front-end/impression/listOneImp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneImp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/impression/impsearch.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		
		if ("getOne_For_Update".equals(action)) { // �來自listAllImp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String impno = req.getParameter("impNo");
				
				/***************************2.開始查詢資料****************************************/
				ImpressionService impressionSvc = new ImpressionService();
				ImpressionVO impressionVO = impressionSvc.getOneImp(impno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("impressionVO", impressionVO);         // 資料庫取出的impressionVO物件,存入req
				String url = "/front-end/impression/update_imp_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//  成功轉交 update_imp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/impression/listAllImp.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("update".equals(action)) { //來自update_imp_input.jsp的請
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
//			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String impno = req.getParameter("impNo").trim();
				System.out.println(impno);
				System.out.println(req.getParameter("impTime"));
				Date imptime = Date.valueOf(req.getParameter("impTime"));
				
				String impname = req.getParameter("impName").trim();
				String actno = new String(req.getParameter("actNo").trim());
				String memno = new String(req.getParameter("memNo").trim());
				String impcon = req.getParameter("impCon").trim();
					if (impcon == null || impcon.trim().length() == 0) {
						errorMsgs.add("心得請勿空白");
					}
				
				
				byte[] recvideo =null;	
				Part part = req.getPart("recVideo");
				if(part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().length() ==0) {
					ImpressionService is = new ImpressionService();
					recvideo = is.getOneImp(impno).getRecVideo();
					
				}else {
					InputStream in = part.getInputStream();
					recvideo = toByteArray(in);
				}
				
				
				byte[] recpic = null;
				Part part2 = req.getPart("recPic");
				if(part2.getSubmittedFileName() == (null)|| part2.getSubmittedFileName().trim().length() == 0) {
					ImpressionService is2 = new ImpressionService();
					recpic = is2.getOneImp(impno).getRecPic();
					System.out.println("123");
				}else {
					InputStream in2 = part2.getInputStream();
					recpic = toByteArray(in2);
					System.out.println("321");
				}
				
					
				String impfield = req.getParameter("impField").trim();

				ImpressionVO impressionVO = new ImpressionVO();
				impressionVO.setImpNo(impno);
				impressionVO.setImpTime(imptime);
				System.out.println(imptime);
				impressionVO.setImpName(impname);
				impressionVO.setActNo(actno);
				impressionVO.setMemNo(memno);
				impressionVO.setImpCon(impcon);
				impressionVO.setRecVideo(recvideo);
				impressionVO.setRecPic(recpic);
				impressionVO.setImpField(impfield);
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("impressionVO", impressionVO); // 資料庫取出的impressionVO物件,存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/impression/update_imp_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料�*****************************************/
				ImpressionService impressionSvc = new ImpressionService();
				impressionVO = impressionSvc.updateImp(impno,imptime,impname, actno, memno, impcon, recvideo,recpic, impfield);
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("impressionVO", impressionVO); // 資料庫update成功後,正確的的impressionVO物件,存入req
				String url = "/front-end/impression/listOneImp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneImp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/impression/update_imp_input.jsp");
//				failureView.forward(req, res);
//			}
		}

        if ("insert".equals(action)) { // 來自addImp.jsp的請求   
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				String actno = new String(req.getParameter("actNo").trim());
				String impname = req.getParameter("impName").trim();
				String memno = new String(req.getParameter("memNo").trim());
				String impcon = req.getParameter("impCon").trim();
					if (impcon == null || impcon.trim().length() == 0) {
						errorMsgs.add("心得請勿空白");
					}
					byte[] recvideo = null;
					Part part = req.getPart("recVideo");
//					if(part.getSubmittedFileName() == (null)|| part.getSubmittedFileName().trim().length() == 0) {
//						
//						File file = new File(getServletContext().getRealPath("impression/img/nopic.jpg"));
//						System.out.println(file);
//						FileInputStream fs = new FileInputStream(file);
//						recvideo = new byte[fs.available()];
//						System.out.println("123");
//					}else {
						InputStream in2 = part.getInputStream();
						recvideo = toByteArray(in2);
						System.out.println("321");
//					}

				byte[] recpic = null;
				Part part2 = req.getPart("recPic");
//				if(part2.getSubmittedFileName() == (null)|| part2.getSubmittedFileName().trim().length() == 0) {
//					
//					InputStream fs = getServletContext().getResourceAsStream("/impression/img/nopic.jpg");
//					recpic = new byte[fs.available()];
//					fs.read(recpic);
//					System.out.println("123");
//				}else {
					InputStream in = part2.getInputStream();
					recpic = toByteArray(in);
					System.out.println("321");
//				}
				
					
				String impfield = req.getParameter("impField");
				

				ImpressionVO impressionVO = new ImpressionVO();
				impressionVO.setActNo(actno);
				impressionVO.setImpName(impname);
				impressionVO.setMemNo(memno);
				impressionVO.setImpCon(impcon);
				impressionVO.setRecVideo(recvideo);
				impressionVO.setRecPic(recpic);
				impressionVO.setImpField(impfield);				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("impressionVO", impressionVO); // 資料庫取出的impressionVO物件,存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front-end/impression/addImp.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				ImpressionService impressionSvc = new ImpressionService();
				impressionVO = impressionSvc.addImp(actno,impname, memno, impcon, recvideo,recpic, impfield);
				
				/***************************3..新增完成,準備轉交(Send the Success view)***********/
				String url = "/front-end/impression/listAllImp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add(e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/impression/addImp.jsp");
//				failureView.forward(req, res);
//			}
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String impNo = new String(req.getParameter("impNo"));
				
				/***************************2.開始刪除資料***************************************/
				ImpressionService impressionSvc = new ImpressionService();
				impressionSvc.deleteImp(impNo);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/front-end/impression/listAllImp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/impression/listAllImp.jsp");
				failureView.forward(req, res);
			}
		}
	
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
