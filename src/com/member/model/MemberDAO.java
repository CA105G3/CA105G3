package com.member.model;

import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO implements MemberDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
	@Override
	public void insert(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void update(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void delete(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public MemberVO findByPrimaryKey(String memNo) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<MemberVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
	


}
