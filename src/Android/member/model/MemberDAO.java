package Android.member.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class MemberDAO implements MemberDAO_interface{
private static DataSource ds = null;
	
	static {
		Context ctx;
		try {
			ctx = new InitialContext();
			ds=(DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	
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
	private static final String CHECK_ID_EXIST = "SELECT memId FROM MEMBER WHERE memId = ?";
	private static final String FIND_BY_ID_PASWD = "SELECT * FROM MEMBER WHERE memId = ? AND pwd = ?";
	private static final String FIND_BY_ID = "SELECT * FROM Member WHERE memId = ?";
	@Override
	public boolean insert(MemberVO memberVO) {
		boolean isInsert = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con=ds.getConnection();
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
			int count = pstmt.executeUpdate();
			isInsert = count > 0 ? true : false;
			
		} catch(SQLException se) {
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
			return isInsert;
	}

	@Override
	public boolean update(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean isUpdated;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,memberVO.getMemId());
			pstmt.setString(2,memberVO.getMemNo());
		
			
			pstmt.executeUpdate();
			int count = pstmt.executeUpdate();
			isUpdated = count > 0 ? true : false;
			
		} catch(SQLException se) {
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
			return isUpdated;
	}

	@Override
	public boolean delete(String memno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean isDeleted;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,memno);
		
			
			pstmt.executeUpdate();
			int count = pstmt.executeUpdate();
			isDeleted = count > 0 ? true : false;
			
		} catch(SQLException se) {
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
		return isDeleted;
	}

	@Override
	public MemberVO findByPrimaryKey(String memno) {
		
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
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
			
		} catch(SQLException se) {
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
	public MemberVO findById(String memId) {
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con=ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_ID);
			pstmt.setString(1, memId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
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
			con=ds.getConnection();
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
			
		} catch(SQLException se) {
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
	
	
	@Override
	public boolean isMember(String memId, String pwd) {
		Connection conn = null;
		PreparedStatement ps = null;
		boolean isMember = false;
		try {
			conn=ds.getConnection();
			ps = conn.prepareStatement(FIND_BY_ID_PASWD);
			ps.setString(1, memId);
			ps.setString(2, pwd);
			ResultSet rs = ps.executeQuery();
			isMember = rs.next();
			return isMember;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return isMember;
	}

	@Override
	public boolean isUserIdExist(String memId) {
		Connection conn = null;
		PreparedStatement ps = null;
		boolean isUserIdExist = false;
		try {
			conn=ds.getConnection();
			ps = conn.prepareStatement(CHECK_ID_EXIST);
			ps.setString(1, memId);
			ResultSet rs = ps.executeQuery();
			isUserIdExist = rs.next();
			return isUserIdExist;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) {
					ps.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return isUserIdExist;
	}

	
	public static void main(String[] args){
		MemberJDBCDAO dao = new MemberJDBCDAO();
		
		//�憓�
//		MemberVO memberVO1 = new MemberVO();
//		memberVO1.setAddr("嚙踝蕭嚙踝蕭嚙踝蕭");
//		memberVO1.setAllergy("嚙踝蕭嚙踝蕭A嚙盤嚙踝蕭");
//		Date date = Date.valueOf("1999-06-04");
//		memberVO1.setBirth(date);
//		memberVO1.setBloodType("AB");
//		memberVO1.setEmail("33455678@hello.com");
//		memberVO1.setFamHistory("嚙諉過嚙磐嚙篆嚙緞");
//		memberVO1.setGender("嚙糊");
//		memberVO1.setIdent("嚙瑾嚙踝蕭|嚙踝蕭");
//		memberVO1.setLocNo(33406);
//		memberVO1.setMedHistory("嚙誹是嚙箠嚙踝蕭嚙踝蕭嚙踝蕭嚙踝蕭");
//		memberVO1.setMemId("handsome");
//		memberVO1.setMemName("hanry Handsome");
//		memberVO1.setMemStatus("嚙踝蕭嚙窯");
//		memberVO1.setPhone("123456789");
//		memberVO1.setPwd("qqqw11");
//		Date date2 = Date.valueOf("2018-11-14");
//		memberVO1.setRegDate(date2);
//		memberVO1.setSmoking("嚙磅嚙踝蕭");
//		Timestamp timestamp = Timestamp.valueOf("2018-12-11 19:18:22");
//		memberVO1.setStaytTime(timestamp);
//		
//		dao.insert(memberVO1);
//		
//		System.out.println("OK");
		
		//靽格
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setMemNo("M0021");
//		memberVO2.setMemId("super handsome");
//		dao.update(memberVO2);
//		System.out.println("OKOK");
		
		//��
//		dao.delete("M0021");
//		System.out.println("no problem");
		
		//�閰Ｖ���
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
		
		//�閰Ｗ�
		List<MemberVO> list = dao.getAll();
		for(MemberVO amem:list) {
			
			System.out.print(amem.getMemNo()+",");
			System.out.print(amem.getMemId()+",");
			System.out.print(amem.getPwd()+",");
			System.out.print(amem.getMemName()+",");
			System.out.print(amem.getPhone()+",");
			System.out.print(amem.getBirth()+",");
			System.out.print(amem.getRegDate()+",");
			System.out.print(amem.getStayTime()+",");
			System.out.print(amem.getMemStatus()+",");
			System.out.print(amem.getIdent()+",");
			System.out.print(amem.getGender()+",");
			System.out.print(amem.getEmail()+",");
			System.out.print(amem.getLocNo()+",");
			System.out.print(amem.getAddr()+",");
			System.out.print(amem.getBloodType()+",");
			System.out.print(amem.getSmoking()+",");
			System.out.print(amem.getAllergy()+",");
			System.out.print(amem.getBloodType()+",");
			System.out.print(amem.getFamHistory()+",");
			System.out.println();	
		}	
		
	}


}
