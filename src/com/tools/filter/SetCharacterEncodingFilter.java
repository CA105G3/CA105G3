package com.tools.filter;

import java.io.IOException;
import javax.servlet.*;


public class SetCharacterEncodingFilter implements Filter {
	protected String encoding=null;
	protected FilterConfig config=null;
	@Override
	public void init(FilterConfig config)throws ServletException{
		this.config=config;
		this.encoding=config.getInitParameter("encoding");
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		req.setCharacterEncoding(encoding);
		chain.doFilter(req, res);
		
	}
	@Override
	public void destroy() {
		this.encoding=null;
		this.config=null;
	}
}
