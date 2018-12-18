package com.ppttool.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
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

import com.ppttool.model.PPTToolService;
import com.ppttool.model.PPTToolVO;

/**
 * Servlet implementation class PPTServlet
 */
@WebServlet("/PPTServlet")
@MultipartConfig
public class PPTServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("pptno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入PPT編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/ppt/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				String pptno = null;
				try {
					pptno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("PPT編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/ppt/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				PPTToolService pptSvc = new PPTToolService();
				PPTToolVO pptVO = pptSvc.getOnePPT(pptno);
				if (pptVO == null) {
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
				req.setAttribute("empVO", pptVO); // 資料庫取出的empVO物件,存入req
				String url = "/ppt/listOneEmp.jsp";
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
		
		
		
		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String pptno = new String(req.getParameter("pptno"));
				
				PPTToolService pptSvc = new PPTToolService();
				pptSvc.deletePPT(pptno);
				
				String url="/ppt/ListAllPPT.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
			}catch(Exception e) {
				errorMsgs.add("刪除資料失敗"+e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/ListAllPPT.jsp");
				failureView.forward(req, res);
			}
		}//End-point delete	
		
		if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String drno=req.getParameter("drno");
				String enameReg = "^[(a-zA-Z0-9)]{5}$";
				if (drno == null || drno.trim().length() == 0) {
					errorMsgs.add("醫師編號: 請勿空白");
				} else if(!drno.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("醫師編號: 只能是英文字母、數字 , 且長度必需為5");
	            }
				
				Part filePart = req.getPart("ppt");
				InputStream fileContent = filePart.getInputStream();
				byte[] data=readFully(fileContent);
				
				PPTToolVO pptVO = new PPTToolVO();
				pptVO.setDrno(drno);
				pptVO.setPpt(data);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("pptVO", pptVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/emp/addPPT.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				PPTToolService pptSvc = new PPTToolService();
				pptVO = pptSvc.addPPT(drno,data);

				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/ppt/ListAllPPT.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
				
				
			}catch(Exception e) {
				errorMsgs.add("新增資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/ppt/addPTT.jsp");
				failureView.forward(req, res);
			}
		}
	}
	
	public static byte[] readFully(InputStream input) throws IOException
	{
	    byte[] buffer = new byte[8192];
	    int bytesRead;
	    ByteArrayOutputStream output = new ByteArrayOutputStream();
	    while ((bytesRead = input.read(buffer)) != -1)
	    {
	        output.write(buffer, 0, bytesRead);
	    }
	    return output.toByteArray();
	}
}
