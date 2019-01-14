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
		MemberVO memVO=(MemberVO)session.getAttribute("memVO");
		String memno = (String)session.getAttribute("memno");
		System.out.println(memno);
		List<String> errorMsgs = new LinkedList<String>();
		if(memVO==null) {
			
			errorMsgs.add("請先登入會員");
			session.setAttribute("accessfail", errorMsgs);
//			request.setAttribute("loginerrorMsgs", errorMsgs);
			
			response.sendRedirect(request.getContextPath()+"/front-end/index.jsp");
//			RequestDispatcher failacess =request.getRequestDispatcher(request.getServletPath());
//			RequestDispatcher failacess = request.getServletContext().getRequestDispatcher("/front-end/member/index.jsp"); 
//			RequestDispatcher failacess =request.getRequestDispatcher("/front-end/member/index.jsp");
//			failacess.forward(request, response);
//			failacess.forward(request, response);
			return;
		}else if(memVO.getMemStatus().equals("停用")) {
			errorMsgs.add("請先到您的E-mail做驗證");
			session.setAttribute("accessfail", errorMsgs);
			session.removeAttribute("memVO");
			response.sendRedirect(request.getContextPath()+"/front-end/member/index.jsp");
		}
		chain.doFilter(request, response);
	}

}
