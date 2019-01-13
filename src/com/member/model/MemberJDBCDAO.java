package com.member.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import com.license.model.LicenseVO;

public class MemberJDBCDAO implements MemberDAO_interface{
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	@Override
	public void UpdateVerify(String memno) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void UpdateLogin(String memno, Timestamp lastlogin) {
		// TODO Auto-generated method stub
		
	}


	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO Member(memno,MemId,pwd,memname,phone,birth,regdate,staytime,memstatus,ident,gender,email,locno,addr,bloodtype,smoking,allergy,medhistory,famhistory)"
		+ "VALUES('M'||lpad(to_char(MEMBER_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,TO_DATE(SYSDATE),?,?,?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT memno,MemId,pwd,memname,phone,birth,regdate,staytime,memstatus,ident,gender,email,locno,addr,bloodtype,smoking,allergy,medhistory,famhistory FROM MEMBER ORDER BY memno";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from MEMBER WHERE memno=?";
	
	private static final String DELETE = 
		"DELETE FROM MEMBER WHERE MEMno = ?";
	
	private static final String UPDATE =
		"UPDATE MEMBER SET MemId =? WHERE MEMno = ?";
	
	private static final String UPDATE_FOR_BASIC_RECORD = 
		"UPDATE MEMBER SET bloodType=?, smoking=?, allergy=?, medHistory=?, famHistory=? where memId = ?";
	//license更改會員ident狀態
	private static final String CHANGE_IDNET =
			"UPDATE member set ident=? where memno=?";
	//license取得會員資料
	private static final String GET_MEM_BY_LIC=
			"SELECT licNo,memNo,licData,licStatus,licDesc,licDue FROM License WHERE memNO = ? ORDER BY LicNO";
	@Override
	public void insert(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,memberVO.getMemId());
			pstmt.setString(2,memberVO.getPwd());
			pstmt.setString(3,memberVO.getMemName());
			pstmt.setString(4,memberVO.getPhone());
			pstmt.setDate(5,memberVO.getBirth());
			pstmt.setDate(6,memberVO.getRegDate());
			pstmt.setString(7,memberVO.getMemStatus());
			pstmt.setString(8,memberVO.getIdent());
			pstmt.setString(9,memberVO.getGender());
			pstmt.setString(10,memberVO.getEmail());
			pstmt.setLong(11,memberVO.getLocNo());
			pstmt.setString(12,memberVO.getAddr());
			pstmt.setString(13,memberVO.getBloodType());
			pstmt.setString(14,memberVO.getSmoking());
			pstmt.setString(15,memberVO.getAllergy());
			pstmt.setString(16,memberVO.getBloodType());
			pstmt.setString(17,memberVO.getFamHistory());
		
			
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
			
			pstmt.setString(1,memberVO.getMemId());
			pstmt.setString(2,memberVO.getMemNo());
		
			
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
				
				memberVO.setMemNo(rs.getString("MEMNO"));
				memberVO.setMemId(rs.getString("MemId"));
				memberVO.setMemName(rs.getString("MEMNAME"));
				memberVO.setMemStatus(rs.getString("MEMSTATUS"));
				memberVO.setAddr(rs.getString("ADDR"));
				memberVO.setAllergy(rs.getString("ALLERGY"));
				memberVO.setBirth(rs.getDate("BIRTH"));
				memberVO.setRegDate(rs.getDate("REGDATE"));
				memberVO.setBloodType(rs.getString("BLOODTYPE"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setFamHistory(rs.getString("FAMHISTORY"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setIdent(rs.getString("IDENT"));
				memberVO.setLocNo(rs.getInt("LOCNO"));
				memberVO.setMedHistory(rs.getString("MEDHISTORY"));
				memberVO.setSmoking(rs.getString("SMOKING"));
				memberVO.setStayTime(rs.getTimestamp("STAYTIME"));
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
	public MemberVO UpdateForBasicRecord(MemberVO memberVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			
			pstmt = con.prepareStatement(UPDATE_FOR_BASIC_RECORD);
			
			pstmt.setString(1, memberVO.getBloodType());
			pstmt.setString(2, memberVO.getSmoking());
			pstmt.setString(3, memberVO.getMedHistory());
			pstmt.setString(4, memberVO.getFamHistory());
			pstmt.setString(5, memberVO.getAllergy());
			pstmt.setString(6, memberVO.getMemId());
				
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
				
				memberVO.setMemNo(rs.getString("MEMNO"));
				memberVO.setMemId(rs.getString("MemId"));
				memberVO.setMemName(rs.getString("MEMNAME"));
				memberVO.setMemStatus(rs.getString("MEMSTATUS"));
				memberVO.setAddr(rs.getString("ADDR"));
				memberVO.setAllergy(rs.getString("ALLERGY"));
				memberVO.setBirth(rs.getDate("BIRTH"));
				memberVO.setRegDate(rs.getDate("REGDATE"));
				memberVO.setBloodType(rs.getString("BLOODTYPE"));
				memberVO.setEmail(rs.getString("EMAIL"));
				memberVO.setFamHistory(rs.getString("FAMHISTORY"));
				memberVO.setGender(rs.getString("GENDER"));
				memberVO.setIdent(rs.getString("IDENT"));
				memberVO.setLocNo(rs.getInt("LOCNO"));
				memberVO.setMedHistory(rs.getString("MEDHISTORY"));
				memberVO.setSmoking(rs.getString("SMOKING"));
				memberVO.setStayTime(rs.getTimestamp("STAYTIME"));
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
//		memberVO1.setAddr("������");
//		memberVO1.setAllergy("����A�L��");
//		Date date = Date.valueOf("1999-06-04");
//		memberVO1.setBirth(date);
//		memberVO1.setBloodType("AB");
//		memberVO1.setEmail("33455678@hello.com");
//		memberVO1.setFamHistory("�ӹL�Y�f�v");
//		memberVO1.setGender("�k");
//		memberVO1.setIdent("�@��|��");
//		memberVO1.setLocNo(33406);
//		memberVO1.setMedHistory("�ڬO�i��������");
//		memberVO1.setMemId("handsome");
//		memberVO1.setMemName("hanry Handsome");
//		memberVO1.setMemStatus("���`");
//		memberVO1.setPhone("123456789");
//		memberVO1.setPwd("qqqw11");
//		Date date2 = Date.valueOf("2018-11-14");
//		memberVO1.setRegDate(date2);
//		memberVO1.setSmoking("�S��");
//		Timestamp timestamp = Timestamp.valueOf("2018-12-11 19:18:22");
//		memberVO1.setStaytTime(timestamp);
//		
//		dao.insert(memberVO1);
//		
//		System.out.println("OK");
		
		//修改
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setMemNo("M0021");
//		memberVO2.setMemId("super handsome");
//		dao.update(memberVO2);
//		System.out.println("OKOK");

		//UpdateForBasicRecord
//		MemberVO memberVO3 = new MemberVO();
//		memberVO3.setMemId("David");
//		memberVO3.setBloodType("AB");
//		memberVO3.setSmoking("有");
//		memberVO3.setMedHistory("膝蓋退化");
//		memberVO3.setAllergy(null);
//		memberVO3.setFamHistory(null);
//		dao.UpdateForBasicRecord(memberVO3);
//		System.out.println("OKOK");
	
		
		//刪除
//		dao.delete("M0021");
//		System.out.println("no problem");
		
		//查詢一個
//		MemberVO memberVO3 = dao.findByPrimaryKey("M0019");
//		System.out.println(memberVO3.getMemNo());
//		System.out.println(memberVO3.getMemId());
//		System.out.println(memberVO3.getPwd());
//		System.out.println(memberVO3.getMemName());
//		System.out.println(memberVO3.getPhone());
//		System.out.println(memberVO3.getBirth());
//		System.out.println(memberVO3.getRegDate());
//		System.out.println(memberVO3.getStayTime());
//		System.out.println(memberVO3.getMemStatus());
//		System.out.println(memberVO3.getIdent());
//		System.out.println(memberVO3.getGender());
//		System.out.println(memberVO3.getEmail());
//		System.out.println(memberVO3.getLocNo());
//		System.out.println(memberVO3.getAddr());
//		System.out.println(memberVO3.getBloodType());
//		System.out.println(memberVO3.getSmoking());
//		System.out.println(memberVO3.getAllergy());
//		System.out.println(memberVO3.getBloodType());
//		System.out.println(memberVO3.getFamHistory());
//		System.out.println("----------------------------------");
		
		//查詢全部
//		List<MemberVO> list = dao.getAll();
//		for(MemberVO amem:list) {
//			
//			System.out.print(amem.getMemNo()+",");
//			System.out.print(amem.getMemId()+",");
//			System.out.print(amem.getPwd()+",");
//			System.out.print(amem.getMemName()+",");
//			System.out.print(amem.getPhone()+",");
//			System.out.print(amem.getBirth()+",");
//			System.out.print(amem.getRegDate()+",");
//			System.out.print(amem.getStayTime()+",");
//			System.out.print(amem.getMemStatus()+",");
//			System.out.print(amem.getIdent()+",");
//			System.out.print(amem.getGender()+",");
//			System.out.print(amem.getEmail()+",");
//			System.out.print(amem.getLocNo()+",");
//			System.out.print(amem.getAddr()+",");
//			System.out.print(amem.getBloodType()+",");
//			System.out.print(amem.getSmoking()+",");
//			System.out.print(amem.getAllergy()+",");
//			System.out.print(amem.getBloodType()+",");
//			System.out.print(amem.getFamHistory()+",");
//			System.out.println();	
//		}	
//		
	}


	@Override
	public MemberVO findByID(String memid) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Set<LicenseVO> findByMemNo(String memNo) {
		Set<LicenseVO> set = new LinkedHashSet<LicenseVO>();
		LicenseVO licenseVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_MEM_BY_LIC);
			//SELECT licNo,memNo,licData,licStatus,licDesc,licDue FROM License WHERE memNO = ? ORDER BY LicNO
			pstmt.setString(1, memNo);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				licenseVO = new LicenseVO();
				licenseVO.setLicNo(rs.getString("licNo"));
				licenseVO.setMemNo(rs.getString("memNo"));
				licenseVO.setLicData(rs.getBytes("licData"));
				licenseVO.setLicStatus(rs.getString("licStatus"));
				licenseVO.setLicDesc(rs.getString("licDesc"));
				licenseVO.setLicDue(rs.getDate("licDue"));
				set.add(licenseVO); // Store the row in the vector
			}
	
			// Handle any SQL errors
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage()); 
		}catch (SQLException se) {
			throw new RuntimeException("Couldn't load database driver."+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}


	@Override
	public void changeident(String memNo, String ident) {
		// TODO Auto-generated method stub
		
	}
}
