package com.medicalorder.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.medicalorder.model.MedicalOrderService;

//只是一支從資料庫取出圖片的Servlet
public class MedicalOrderImgServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("video/*");
		ServletOutputStream out = res.getOutputStream();
		
		String moNo = req.getParameter("moNo");
		MedicalOrderService medicalOrderSvc = new MedicalOrderService();
		byte[] pic = medicalOrderSvc.getOneMedicalOrder(moNo).getMoVideo();
									//藉由getOneMedicalOrder()傳入請求參數，再從VO去getMoVideo()取得MoVideo物件
		res.setContentLength(pic.length);
		out.write(pic);
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
}
