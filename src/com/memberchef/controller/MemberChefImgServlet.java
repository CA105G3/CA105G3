package com.memberchef.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.memberchef.model.MemberChefService;

public class MemberChefImgServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String chefNo = req.getParameter("chefNo");
		MemberChefService chefSvc = new MemberChefService();
		byte[] pic = chefSvc.getOneChef(chefNo).getChefPic();
		
		ServletOutputStream out = res.getOutputStream();
		res.setContentLength(pic.length);
		res.setContentType("image/*");
		out.write(pic);
		out.close();
	}
}
