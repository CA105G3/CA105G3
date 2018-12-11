package com.member.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class MemberJDBCDAO implements MemberDAO_interface{
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO Member(memno,memid,pwd,memname,phone,birth,regdate,staytime,memstatus,ident,gender,email,locno,addr,bloodtype,smoking,allergy,medhistory,famhistory)"
		+ "VALUES('M'||lpad(to_char(MEMBER_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,TO_DATE(SYSDATE),?,?,?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT memno,memid,pwd,memname,phone,birth,regdate,staytime,memstatus,ident,gender,email,locno,addr,bloodtype,smoking,allergy,medhistory,famhistory FROM MEMBER ORDER BY memno";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from MEMBER WHERE memno=?";
	
	private static final String DELETE = 
		"DELETE FROM MEMBER WHERE MEMno = ?";
	
	private static final String UPDATE =
		"UPDATE MEMBER SET memid =? WHERE MEMno = ?";
	
	@Override
	public void insert(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,memberVO.getMemid());
			pstmt.setString(2,memberVO.getPwd());
			pstmt.setString(3,memberVO.getMemname());
			pstmt.setString(4,memberVO.getPhone());
			pstmt.setDate(5,memberVO.getBirth());
			pstmt.setDate(6,memberVO.getRegdate());
			pstmt.setString(7,memberVO.getMemstatus());
			pstmt.setString(8,memberVO.getIdent());
			pstmt.setString(9,memberVO.getGender());
			pstmt.setString(10,memberVO.getEmail());
			pstmt.setLong(11,memberVO.getLocno());
			pstmt.setString(12,memberVO.getAddr());
			pstmt.setString(13,memberVO.getBloodtype());
			pstmt.setString(14,memberVO.getSmoking());
			pstmt.setString(15,memberVO.getAllergy());
			pstmt.setString(16,memberVO.getMedhistory());
			pstmt.setString(17,memberVO.getFamhistory());
		
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
			
	}

	@Override
	public void update(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,memberVO.getMemid());
			pstmt.setString(2,memberVO.getMemno());
		
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." +se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
			
	}

	@Override
	public void delete(String memno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,memno);
		
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." +se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public MemberVO findByPrimaryKey(String memno) {
		
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO = new MemberVO();
				
				memberVO.setMemno(rs.getString("MEMNO"));
				memberVO.setMemid(rs.getString("MEMID"));
				memberVO.setMemname(rs.getString("MEMNAME"));
				memberVO.setMemstatus(rs.getString("MEMSTATUS"));
				memberVO.setAddr(rs.getString("ADDR"));
				memberVO.setAllergy(rs.getString("ALLERGY"));
				memberVO.setBirth(rs.getDate("BIRTH"));
				memberVO.setRegdate(rs.getDate("REGDATE"));
				memberVO.setBloodtype(rs.getString("BLOODTYPE"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setFamhistory(rs.getString("FAMHISTORY"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setIdent(rs.getString("IDENT"));
				memberVO.setLocno(rs.getInt("LOCNO"));
				memberVO.setMedhistory(rs.getString("MEDHISTORY"));
				memberVO.setSmoking(rs.getString("SMOKING"));
				memberVO.setStaytime(rs.getTimestamp("STAYTIME"));
				memberVO.setPhone(rs.getString("PHONE"));
				memberVO.setPwd(rs.getString("PWD"));
				
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		
		
		return memberVO;
	}

	@Override
	public List<MemberVO> getAll() {
		
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO = new MemberVO();
				
				memberVO.setMemno(rs.getString("MEMNO"));
				memberVO.setMemid(rs.getString("MEMID"));
				memberVO.setMemname(rs.getString("MEMNAME"));
				memberVO.setMemstatus(rs.getString("MEMSTATUS"));
				memberVO.setAddr(rs.getString("ADDR"));
				memberVO.setAllergy(rs.getString("ALLERGY"));
				memberVO.setBirth(rs.getDate("BIRTH"));
				memberVO.setRegdate(rs.getDate("REGDATE"));
				memberVO.setBloodtype(rs.getString("BLOODTYPE"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setFamhistory(rs.getString("FAMHISTORY"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setIdent(rs.getString("IDENT"));
				memberVO.setLocno(rs.getInt("LOCNO"));
				memberVO.setMedhistory(rs.getString("MEDHISTORY"));
				memberVO.setSmoking(rs.getString("SMOKING"));
				memberVO.setStaytime(rs.getTimestamp("STAYTIME"));
				memberVO.setPhone(rs.getString("PHONE"));
				memberVO.setPwd(rs.getString("PWD"));
				list.add(memberVO);	
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	public static void main(String[] args){
		MemberJDBCDAO dao = new MemberJDBCDAO();
		
		//新增
//		MemberVO memberVO1 = new MemberVO();
//		memberVO1.setAddr("高雄縣");
//		memberVO1.setAllergy("對海鮮過敏");
//		Date date = Date.valueOf("1999-06-04");
//		memberVO1.setBirth(date);
//		memberVO1.setBloodtype("AB");
//		memberVO1.setEmail("33455678@hello.com");
//		memberVO1.setFamhistory("帥過頭病史");
//		memberVO1.setGender("男");
//		memberVO1.setIdent("一般會員");
//		memberVO1.setLocno(33406);
//		memberVO1.setMedhistory("我是養眼的藥藥");
//		memberVO1.setMemid("handsome");
//		memberVO1.setMemname("hanry Handsome");
//		memberVO1.setMemstatus("正常");
//		memberVO1.setPhone("123456789");
//		memberVO1.setPwd("qqqw11");
//		Date date2 = Date.valueOf("2018-11-14");
//		memberVO1.setRegdate(date2);
//		memberVO1.setSmoking("沒有");
//		Timestamp timestamp = Timestamp.valueOf("2018-12-11 19:18:22");
//		memberVO1.setStaytime(timestamp);
//		
//		dao.insert(memberVO1);
//		
//		System.out.println("OK");
		
		//修改
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setMemno("M0021");
//		memberVO2.setMemid("super handsome");
//		dao.update(memberVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("M0021");
//		System.out.println("no problem");
		
		//查詢一個
//		MemberVO memberVO3 = dao.findByPrimaryKey("M0019");
//		System.out.println(memberVO3.getMemno());
//		System.out.println(memberVO3.getMemid());
//		System.out.println(memberVO3.getPwd());
//		System.out.println(memberVO3.getMemname());
//		System.out.println(memberVO3.getPhone());
//		System.out.println(memberVO3.getBirth());
//		System.out.println(memberVO3.getRegdate());
//		System.out.println(memberVO3.getStaytime());
//		System.out.println(memberVO3.getMemstatus());
//		System.out.println(memberVO3.getIdent());
//		System.out.println(memberVO3.getGender());
//		System.out.println(memberVO3.getEmail());
//		System.out.println(memberVO3.getLocno());
//		System.out.println(memberVO3.getAddr());
//		System.out.println(memberVO3.getBloodtype());
//		System.out.println(memberVO3.getSmoking());
//		System.out.println(memberVO3.getAllergy());
//		System.out.println(memberVO3.getMedhistory());
//		System.out.println(memberVO3.getFamhistory());
//		System.out.println("----------------------------------");
		
		//查詢全部
		List<MemberVO> list = dao.getAll();
		for(MemberVO amem:list) {
			
			System.out.print(amem.getMemno()+",");
			System.out.print(amem.getMemid()+",");
			System.out.print(amem.getPwd()+",");
			System.out.print(amem.getMemname()+",");
			System.out.print(amem.getPhone()+",");
			System.out.print(amem.getBirth()+",");
			System.out.print(amem.getRegdate()+",");
			System.out.print(amem.getStaytime()+",");
			System.out.print(amem.getMemstatus()+",");
			System.out.print(amem.getIdent()+",");
			System.out.print(amem.getGender()+",");
			System.out.print(amem.getEmail()+",");
			System.out.print(amem.getLocno()+",");
			System.out.print(amem.getAddr()+",");
			System.out.print(amem.getBloodtype()+",");
			System.out.print(amem.getSmoking()+",");
			System.out.print(amem.getAllergy()+",");
			System.out.print(amem.getMedhistory()+",");
			System.out.print(amem.getFamhistory()+",");
			System.out.println();	
		}	
		
	}
}
