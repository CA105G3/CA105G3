package com.ppttool.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ppttool.model.PPTToolService;

public class PPTImgServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String pptno = req.getParameter("pptno");
		PPTToolService pptSvc = new PPTToolService();
		byte[] pic = pptSvc.getOnePPT(pptno).getPpt();
		
		ServletOutputStream out = res.getOutputStream();
		res.setContentLength(pic.length);
		res.setContentType("image/*");
		out.write(pic);
		out.close();
	}
	
	
}
