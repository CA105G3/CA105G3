package com.menu.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.menu.model.MenuService;

public class MenuImgServlet  extends HttpServlet{
private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String menuNo = req.getParameter("menuNo");
		MenuService menuSvc = new MenuService();
		byte[] pic = menuSvc.getOneMenu(menuNo).getMenuPic();
		
		ServletOutputStream out = res.getOutputStream();
		res.setContentLength(pic.length);
		res.setContentType("image/*");
		out.write(pic);
		out.close();
	}
}
