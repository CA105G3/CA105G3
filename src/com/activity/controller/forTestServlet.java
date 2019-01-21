package com.activity.controller;

import java.io.*;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.activity.model.ActivityDAO;
import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;
import com.joinact.model.ChatRoomVO;
import com.joinact.model.JoinActService;

public class forTestServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String actNo = req.getParameter("actNo");
		JoinActService joinActySvc = new JoinActService();
		
//		List<ChatRoomVO> list = joinActySvc.getchatmember(actNo)
//		for(ChatRoomVO crvo : list)
//		{		
//		crvo.getMemPic()
//		ServletOutputStream out = res.getOutputStream();
//		res.setContentLength(pic.length);
//		res.setContentType("image/*");
//		out.write(pic);
//		out.close();
//		}
	}
}
