package com.memberchef.controller;

import java.io.IOException;
import java.io.InputStream;
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
import com.member.model.MemberVO;
import com.memberchef.model.MemberChefService;
import com.memberchef.model.MemberChefVO;

@WebServlet("/MemberChefServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemberChefServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
//		String chefNo = req.getParameter("chefNo");
//		if(chefNo != null && !chefNo.equals("")) {
//			session.setAttribute("chefNo", chefNo);
//		}
		
//		MemberVO memVO =  (MemberVO) session.getAttribute("memVO");
//		MemberChefService chefSvc = new MemberChefService();
//		String chefNo = chefSvc.getOneChefByMemNo(memVO.getMemNo()).getChefNo();

        if ("getOne_For_Display".equals(action)) { // 來自*.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				
				String chefNo = req.getParameter("chefNo");
				String chefNoReg = "^CHEF[0-9]{4}";
				if (chefNo == null || chefNo.trim().length() == 0) {
					errorMsgs.add("廚師編號: 請勿空白");
				} else if(!chefNo.trim().matches(chefNoReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("廚師編號: 只能是CHEF加上4位數字的組合");
	            }

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front\u002dend/memberchef/listAllChef.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始查詢資料***************************************/
				MemberChefService chefSvc = new MemberChefService();
				MemberChefVO chefVO = chefSvc.getOneChef(chefNo);
				
				if (chefVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front\u002dend/memberchef/listAllChef.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)***********/
				req.setAttribute("chefVO", chefVO); // 資料庫取出的chefVO物件,存入req
				String url = "/front\u002dend/memberchef/memberchef.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交memberchef.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front\u002dend/memberchef/listAllChef.jsp");
				failureView.forward(req, res);
			}
		}
        
//				=============================================================================
        
        if ("getOne_For_Update".equals(action)) { // 來自memberchef.jsp的請求

        	Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/***************************1.接收請求參數****************************************/
//				String chefNo = req.getParameter("chefNo");
				String chefNo = (String)session.getAttribute("chefNo");
				
				/***************************2.開始查詢資料****************************************/
				MemberChefService chefSvc = new MemberChefService();
				MemberChefVO chefVO = chefSvc.getOneChef(chefNo);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
//				req.setAttribute("chefVO", chefVO); // 資料庫取出的chefVO物件,存入req
				session.setAttribute("chefVO", chefVO); // 資料庫取出的chefVO物件,存入req
				String url = "/front\u002dend/memberchef/updateChef.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交updateChef.jsp
				successView.forward(req, res);	
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception", "無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front\u002dend/memberchef/memberchef.jsp");
				failureView.forward(req, res);
			}
		}
		
//		=============================================================================
        
        if ("update".equals(action)) { // 來自updateChef.jsp的請求   
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
//				String chefNo = req.getParameter("chefNo");
				String chefNo = (String)session.getAttribute("chefNo");				
				String memNo = req.getParameter("memNo");
//				String memNo = memVO.getMemNo();
				
				String chefName = req.getParameter("chefName").trim();
				if (chefName == null || chefName.trim().length() == 0) {
					errorMsgs.put("chefName","請輸入廚師姓名");
				}
				String chefStoreName = req.getParameter("chefStoreName").trim();
				if (chefStoreName == null || chefStoreName.trim().length() == 0) {
					errorMsgs.put("chefStoreName","請輸入商店名稱");
				}
				byte[] chefPic = null;
				Part part = req.getPart("chefPic");
				String filename = part.getSubmittedFileName();

				if (filename != "") {
					InputStream in = part.getInputStream();
					chefPic = new byte[in.available()];
					in.read(chefPic);
					in.close();
				} else {
					MemberChefService chefSvc = new MemberChefService();
					chefPic = chefSvc.getOneChef(chefNo).getChefPic();
				}
				
				String chefDescrip = req.getParameter("chefDescrip").trim();
				if (chefDescrip == null || chefDescrip.trim().length() == 0) {
					errorMsgs.put("chefDescrip","請輸入簡介");
				}
				
				String chefPhone = req.getParameter("chefPhone");
				String chefPhoneReg = "^[0-9]{1,10}";
				if (chefPhone == null || chefPhone.trim().length() == 0) {
					errorMsgs.put("chefPhone", "請輸入電話號碼");
				}else if(!chefPhone.trim().matches(chefPhoneReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("chefPhone", "請輸入10位數以內，且不含特殊符號之數字");
	            } 
				
				String chefAddr = req.getParameter("chefAddr").trim();
				if (chefAddr == null || chefAddr.trim().length() == 0) {
					errorMsgs.put("chefAddr","請輸入地址");
				}
				
				String chefRep = req.getParameter("chefRep").trim();
				if (chefRep == null || chefRep.trim().length() == 0) {
					errorMsgs.put("chefRep","請輸入負責人");
				}
				
				MemberChefVO chefVO = new MemberChefVO();
				chefVO.setChefNo(chefNo);
				chefVO.setMemNo(memNo);
				chefVO.setChefName(chefName);
				chefVO.setChefStoreName(chefStoreName);
				chefVO.setChefPic(chefPic);
				chefVO.setChefDescrip(chefDescrip);
				chefVO.setChefStatus("啓用");
				chefVO.setChefPhone(chefPhone);
				chefVO.setChefAddr(chefAddr);
				chefVO.setChefRep(chefRep);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front\u002dend/memberchef/updateChef.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始修改資料***************************************/
				MemberChefService chefSvc = new MemberChefService();
				chefSvc.updateMemberChef(chefNo, chefName, chefStoreName, chefPic, chefDescrip, "啓用", chefPhone, chefAddr, chefRep);
				
				/***************************3.修改完成,準備轉交(Send the Success view)***********/
				session.setAttribute("chefVO", chefVO);
				String url = "/front\u002dend/memberchef/memberchef.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後轉交memberchef.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front\u002dend/memberchef/updateChef.jsp");
				failureView.forward(req, res);
			}
        }
        
//		=============================================================================
        
        if ("insert".equals(action)) { // 來自addChef.jsp的請求   
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String chefName = req.getParameter("chefName").trim();
				if (chefName == null || chefName.trim().length() == 0) {
					errorMsgs.put("chefName","請輸入廚師姓名");
				}

				String chefStoreName = req.getParameter("chefStoreName").trim();
				if (chefStoreName == null || chefStoreName.trim().length() == 0) {
					errorMsgs.put("chefStoreName","請輸入商店名稱");
				}
				
				byte[] chefPic = null;
				Part part = req.getPart("chefPic");
				String filename = part.getSubmittedFileName();

				if (filename != "") {
					InputStream in = part.getInputStream();
					chefPic = new byte[in.available()];
					in.read(chefPic);
					in.close();
				} else {
					InputStream inDefault = getServletContext().getResourceAsStream("/Imgs/Memberchef/noPhotoAvailable.jpg");
					chefPic = new byte[inDefault.available()];
					inDefault.read(chefPic);
					inDefault.close();
				}
				
				String chefDescrip = req.getParameter("chefDescrip").trim();
				if (chefDescrip == null || chefDescrip.trim().length() == 0) {
					errorMsgs.put("chefDescrip","請輸入簡介");
				}
				
				String chefPhone = req.getParameter("chefPhone");
				String chefPhoneReg = "^[0-9]{1,10}";
				if (chefPhone == null || chefPhone.trim().length() == 0) {
					errorMsgs.put("chefPhone", "請輸入電話號碼");
				}else if(!chefPhone.trim().matches(chefPhoneReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.put("chefPhone", "請輸入10位數以內，且不含特殊符號之數字");
	            } 
				
				String chefAddr = req.getParameter("chefAddr").trim();
				if (chefAddr == null || chefAddr.trim().length() == 0) {
					errorMsgs.put("chefAddr","請輸入地址");
				}
				
				String chefRep = req.getParameter("chefRep").trim();
				if (chefRep == null || chefRep.trim().length() == 0) {
					errorMsgs.put("chefRep","請輸入負責人");
				}

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front\u002dend/memberchef/addChef.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				MemberChefService chefSvc = new MemberChefService();
				MemberChefVO chefVO = chefSvc.addMemberChef(chefName, chefStoreName, chefPic, chefDescrip, "啓用", chefPhone, chefAddr, chefRep);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("chefVO", chefVO); // 資料庫取出的chefVO物件,存入req
				String url = "/front\u002dend/memberchef/memberchef.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.put("Exception",e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front\u002dend/memberchef/addChef.jsp");
				failureView.forward(req, res);
			}
		}
        
//		=============================================================================
        
        if("enter_chef".equals(action)) {			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			try {
				String memNo = req.getParameter("memno");
				MemberChefService chefSvc = new MemberChefService();
				MemberChefVO chefVO = chefSvc.getOneChefByMemNo(memNo);
				if(chefVO == null) {
					RequestDispatcher addChefView = req.getRequestDispatcher("/front\u002dend/memberchef/addChef.jsp");
					addChefView.forward(req, res);
					return;
				}
				String chefNo = chefVO.getChefNo();
				
				String url ="/front\u002dend/memberchef/memberchef.jsp";
				session.setAttribute("chefNo", chefNo);
				session.setAttribute("chefVO", chefVO);
				req.setAttribute("chefVO", chefVO);
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
			}catch(Exception e) {
				errorMsgs.put("error", e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
				return;
			}
		}
	}
}
