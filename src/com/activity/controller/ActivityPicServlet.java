package com.activity.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.activity.model.ActivityService;
import com.impression.model.ImpressionService;

public class ActivityPicServlet extends HttpServlet{

		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			req.setCharacterEncoding("UTF-8");
			String actNo = req.getParameter("actNo");
			ActivityService activitySvc = new ActivityService();
			
			byte[] pic = activitySvc.getOneAct(actNo).getActPic();
			
			ServletOutputStream out = res.getOutputStream();
			res.setContentLength(pic.length);
			res.setContentType("image/*");
			out.write(pic);
			out.close();
		}
}
