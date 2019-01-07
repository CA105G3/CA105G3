package com.tools.filter;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberVO;


@WebFilter("/MemberExist")
public class MemberExist implements Filter {

    private FilterConfig config;

	public void init(FilterConfig config) throws ServletException {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		String memno = (String)session.getAttribute("memno");
		System.out.println(memno);
		if(memno==null) {
			List<String> errorMsgs = new LinkedList<String>();
			errorMsgs.add("請先登入會員");
			session.setAttribute("accessfail", errorMsgs);
//			request.setAttribute("loginerrorMsgs", errorMsgs);
			response.sendRedirect(request.getContextPath()+"/front-end/member/index.jsp");
//			RequestDispatcher failacess =request.getRequestDispatcher("/front-end/member/index.jsp");
//			RequestDispatcher failacess = request.getServletContext().getRequestDispatcher("/front-end/member/index.jsp"); 
//			RequestDispatcher failacess =request.getRequestDispatcher("/front-end/member/index.jsp");
//			failacess.forward(request, response);
			
			return;
		}
		chain.doFilter(request, response);
	}

}
