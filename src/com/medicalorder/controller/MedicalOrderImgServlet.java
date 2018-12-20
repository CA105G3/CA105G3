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
		String moVideo = req.getParameter("moVideo");
		MedicalOrderService medicalOrderSvc = new MedicalOrderService();
		byte[] pic = medicalOrderSvc.getOneMedicalOrder(moVideo).getMoVideo();
									//藉由getOneMedicalOrder()傳入請求參數，再從VO去getMoVideo()取得MoVideo物件
		ServletOutputStream out = res.getOutputStream();
		res.setContentLength(pic.length);
		res.setContentType("image/*");
		out.write(pic);
		out.close();
	}
}
