package com.medicalorder.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.print.attribute.standard.RequestingUserName;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.medicalorder.model.MedicalOrderDAO;
import com.medicalorder.model.MedicalOrderService;
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
		
//		String str2 = req.getParameter("moStatus");
//		System.out.println("str2 : "+str2);
		

		if("insert".equals(action)) {
			
			List<String> errMsgs = new LinkedList<String>();
			req.setAttribute("errMsgs", errMsgs);
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				//會員編號
				String memNo = req.getParameter("memNo");
				String memNoReq = "^[(M)(0-9)] {5}$";
				if(memNo == null || memNo.trim().length()==0) {
					errMsgs.add("會員編號請勿空白");
				}
//				else if(!memNo.trim().matches(memNoReq)) {
//					errMsgs.add("會員編號請輸入大寫M開頭再加4個數字");
//				}
				//醫療人員編號
				String drNo = req.getParameter("drNo");
				String drNoReq = "^[(D)(0-9)] {5}$";			
				if(memNo == null || memNo.trim().length()==0) {
					errMsgs.add("醫療人員編號請勿空白");
				}
//				else if(!memNo.trim().matches(memNoReq)) {
//					errMsgs.add("醫療人員編號請輸入大寫D開頭再加4個數字");
//				}
				//診療狀態
				String moStatus = req.getParameter("moStatus");
				
				//診療費用
				Integer moCost = null;
				try {
					moCost = new Integer(req.getParameter("moCost").trim());
				} catch (NumberFormatException e) {
					moCost = 0;
					errMsgs.add("診療費用請填數字");
				}
				
				//約診時間
				java.sql.Date moTime = null;
				try {
					moTime = java.sql.Date.valueOf(req.getParameter("moTime").trim());
				} catch (Exception e) {
					moTime = new java.sql.Date(System.currentTimeMillis());
					errMsgs.add("請輸入約診日期");
				}
				
				//病況說明
				String moIntro = req.getParameter("moIntro").trim();
				if(moIntro == null || moIntro.trim().length() ==0) {
					errMsgs.add("病況說明請勿空白");
				}
				
				//問診影音紀錄
//				Part moVideo = req.getPart("moVideo");
//				if(moVideo.getSubmittedFileName().equals(null)||moVideo.getSubmittedFileName().trim().length()==0)
//					errMsgs.add("請上傳PPT");
//				InputStream fileContent = moVideo.getInputStream();
//				byte[] moVideoUp=readFully(fileContent);
				
				//問診文字紀錄
				String moText = req.getParameter("moText").trim();
				if(moText == null || moText.trim().length() ==0) {
					errMsgs.add("問診文字紀錄請勿空白");
				}
				
				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMemNo(memNo);
				medicalOrderVO.setDrNo(drNo);
				medicalOrderVO.setMoStatus(moStatus);
				medicalOrderVO.setMoCost(moCost);
				medicalOrderVO.setMoTime(moTime);
				medicalOrderVO.setMoVideo(null);
				medicalOrderVO.setMoIntro(moIntro);
				medicalOrderVO.setMoText(moText);
				
				if(!errMsgs.isEmpty()) {
					req.setAttribute("medicalOrderVO", medicalOrderVO);
					RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/addMedicalOrder.jsp");
					failureData.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				MedicalOrderService MedicalOrderSvc = new MedicalOrderService();
				medicalOrderVO = MedicalOrderSvc.addMedicalOrder(memNo, drNo, moStatus,
						 moCost, moTime, moIntro, null, moText);		
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				
				String url = "/front-end/medicalOrder/listAllMedicalOrder.jsp";
				RequestDispatcher successData = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successData.forward(req, res);
			/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errMsgs.add(e.getMessage());
				RequestDispatcher failureData = req.getRequestDispatcher("/front-end/medicalOrder/addMedicalOrder.jsp");
				failureData.forward(req, res);
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
