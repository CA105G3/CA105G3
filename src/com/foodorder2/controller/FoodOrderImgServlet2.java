package com.foodorder2.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.foodorder2.model.MenuService;

public class FoodOrderImgServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String menuno = req.getParameter("menuno");
		MenuService MenuSvc = new MenuService();
		byte[] pic = MenuSvc.getOneMenu(menuno).getMenuPic();
		
		ServletOutputStream out = res.getOutputStream();
		res.setContentLength(pic.length);
		res.setContentType("image/*");
		out.write(pic); 
		out.close();
	}
}
