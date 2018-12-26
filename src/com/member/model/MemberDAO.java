package com.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.administrator.model.AdministratorVO;

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
		"INSERT INTO  member(memno,memname,memid,addr,"
		+ "allergy,birth,bloodtype,email,"
		+ "famhistory,gender,ident,locno,"
		+ "medhistory,memstatus,phone,pwd,"
		+ "regdate,smoking,staytime) "
		+ "VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'), ?, ?, ?,"
		+ "?,?,?,?,"
		+ "?,?,?,?,"
		+ "?,?,?,?,"
		+ "?,?,?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM member order by memno";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM member where memno = ?";
	private static final String DELETE = 
		"DELETE FROM member where memno = ?";
	private static final String UPDATE = 
		"UPDATE member set memname=?,memid=?,addr=?,allergy=?,"
		+ "birth=?,bloodtype=?,email=?,famhistory=?,"
		+ "gender=?,ident=?,locno=?,medhistory=?,"
		+ "memstatus=?,phone=?,pwd=?,regdate=?,"
		+ "smoking=?,staytime=?  where memno = ?";

	
	@Override
	public void insert(MemberVO memberVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			System.out.println("get data:"+memberVO.getMemName());
			pstmt.setString(1,memberVO.getMemName());
			pstmt.setString(2,memberVO.getMemId());
			pstmt.setString(3,memberVO.getAddr());
			pstmt.setString(4,memberVO.getAllergy());
			pstmt.setDate(5,memberVO.getBirth());
			pstmt.setString(6,memberVO.getBloodType());
			pstmt.setString(7,memberVO.getEmail());
			pstmt.setString(8,memberVO.getFamHistory());
			pstmt.setString(9,memberVO.getGender());
			pstmt.setString(10,memberVO.getIdent());
			pstmt.setInt(11,memberVO.getLocNo());
			pstmt.setString(12,memberVO.getMedHistory());
			pstmt.setString(13,memberVO.getMemStatus());
			pstmt.setString(14,memberVO.getPhone());
			pstmt.setString(15,memberVO.getPwd());
			pstmt.setDate(16,memberVO.getRegDate());
			pstmt.setString(17,memberVO.getSmoking());
			pstmt.setTimestamp(18,memberVO.getStayTime());
			pstmt.executeUpdate();
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
	}

	@Override
	public void update(MemberVO memberVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,memberVO.getMemName());
			pstmt.setString(2,memberVO.getMemId());
			pstmt.setString(3,memberVO.getAddr());
			pstmt.setString(4,memberVO.getAllergy());
			pstmt.setDate(5,memberVO.getBirth());
			pstmt.setString(6,memberVO.getBloodType());
			pstmt.setString(7,memberVO.getEmail());
			pstmt.setString(8,memberVO.getFamHistory());
			pstmt.setString(9,memberVO.getGender());
			pstmt.setString(10,memberVO.getIdent());
			pstmt.setInt(11,memberVO.getLocNo());
			pstmt.setString(12,memberVO.getMedHistory());
			pstmt.setString(13,memberVO.getMemStatus());
			pstmt.setString(14,memberVO.getPhone());
			pstmt.setString(15,memberVO.getPwd());
			pstmt.setDate(16,memberVO.getRegDate());
			pstmt.setString(17,memberVO.getSmoking());
			pstmt.setTimestamp(18,memberVO.getStayTime());
			pstmt.setString(19, memberVO.getMemNo());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
	}

	@Override
	public void delete(String memberno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, memberno);
			pstmt.executeUpdate();
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
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
	}

	@Override
	public MemberVO findByPrimaryKey(String memberno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberVO memberVO =null;
		
		try {
			con=ds.getConnection();
			pstmt=con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1,memberno);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				memberVO=new MemberVO();
				memberVO.setMemNo(rs.getString("memno"));
				memberVO.setMemId(rs.getString("memid"));
				memberVO.setPwd(rs.getString("pwd"));
				memberVO.setMemName(rs.getString("memname"));
				memberVO.setAddr(rs.getString("addr"));
				memberVO.setAllergy(rs.getString("allergy"));
				memberVO.setBirth(rs.getDate("birth"));
				memberVO.setBloodType(rs.getString("bloodtype"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setFamHistory(rs.getString("famhistory"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setIdent(rs.getString("ident"));
				memberVO.setLocNo(rs.getInt("locno"));
				memberVO.setMedHistory(rs.getString("medhistory"));
				memberVO.setMemStatus(rs.getString("memstatus"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setRegDate(rs.getDate("regdate"));
				memberVO.setSmoking(rs.getString("smoking"));
				memberVO.setStayTime(rs.getTimestamp("staytime"));
			}
			// Handle any driver errors
		}catch (SQLException se) {
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
		Connection con=null;
		PreparedStatement pstmt=null;
		List<MemberVO> list = new ArrayList<MemberVO>();
		ResultSet rs = null;
		MemberVO memberVO=null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO=new MemberVO();
				memberVO.setMemNo(rs.getString("memno"));
				memberVO.setMemId(rs.getString("memid"));
				memberVO.setPwd(rs.getString("pwd"));
				memberVO.setMemName(rs.getString("memname"));
				memberVO.setAddr(rs.getString("addr"));
				memberVO.setAllergy(rs.getString("allergy"));
				memberVO.setBirth(rs.getDate("birth"));
				memberVO.setBloodType(rs.getString("bloodtype"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setFamHistory(rs.getString("famhistory"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setIdent(rs.getString("ident"));
				memberVO.setLocNo(rs.getInt("locno"));
				memberVO.setMedHistory(rs.getString("medhistory"));
				memberVO.setMemStatus(rs.getString("memstatus"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setRegDate(rs.getDate("regdate"));
				memberVO.setSmoking(rs.getString("smoking"));
				memberVO.setStayTime(rs.getTimestamp("staytime"));
				list.add(memberVO);
			}
		}catch (SQLException se) {
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
		
		
		return list;
	}

}
