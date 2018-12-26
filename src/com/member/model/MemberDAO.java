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
	
	private static final String INSERT_STMT = 
		"INSERT INTO emp2 (memid,memname,memno,addr,allergy,birth,bloodtype,email,famhistory,gender,ident,locno,medhistory,memstatus,phone,pwd,regdate,smoking,staytme) "
		+ "VALUES (emp2_seq.NEXTVAL, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT empno,ename,job,to_char(hiredate,'yyyy-mm-dd') hiredate,sal,comm,deptno FROM emp2 order by empno";
	private static final String GET_ONE_STMT = 
		"SELECT empno,ename,job,to_char(hiredate,'yyyy-mm-dd') hiredate,sal,comm,deptno FROM emp2 where empno = ?";
	private static final String DELETE = 
		"DELETE FROM emp2 where empno = ?";
	private static final String UPDATE = 
		"UPDATE emp2 set ename=?, job=?, hiredate=?, sal=?, comm=?, deptno=? where empno = ?";

	@Override
	public void insert(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(MemberVO memberVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String memberno) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberVO findByPrimaryKey(String memberno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemberVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

}
