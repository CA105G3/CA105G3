package com.administrator.model;

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

public class AdministratorDAO implements Administrator_interface {
	private static DataSource ds = null;
	
	//宣告連線池
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
			"INSERT INTO administrator(adminno,adminid,adminpsw,priority,status,reg) VALUES('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),?,?,?,?,?)";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM administrator ORDER BY adminno";
	private static final String GET_ONE_STMT = 
			"SELECT * from administrator WHERE adminno=?";
	private static final String DELETE = 
			"DELETE FROM administrator WHERE adminno = ?";
	private static final String UPDATE = 
			"UPDATE administrator SET adminid=?,adminpsw=?,priority=?,status=? WHERE adminno=?";
	@Override
	public void insert(AdministratorVO administratorVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1,administratorVO.getAdminId());
			pstmt.setString(2,administratorVO.getAdminPsw());
			pstmt.setString(3,administratorVO.getPriority());
			pstmt.setString(4,administratorVO.getStatus());
			pstmt.setDate(5,administratorVO.getReg());
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
	public void update(AdministratorVO administratorVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1,administratorVO.getAdminId());
			pstmt.setString(2,administratorVO.getAdminPsw());
			pstmt.setString(3,administratorVO.getPriority());
			pstmt.setString(4,administratorVO.getStatus());
			pstmt.setString(5,administratorVO.getAdminNo());
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
	public void delete(String adminno) {
		// TODO Auto-generated method stub
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, adminno);
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
	public AdministratorVO findByPrimaryKey(String adminNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		AdministratorVO adminVO =null;
		ResultSet rs=null;
		
		try {
			con=ds.getConnection();
			pstmt=con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1,adminNo);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				adminVO=new AdministratorVO();
				adminVO.setAdminNo(rs.getString("adminno"));
				adminVO.setAdminId(rs.getString("adminid"));
				adminVO.setAdminPsw(rs.getString("adminpsw"));
				adminVO.setPriority(rs.getString("priority"));
				adminVO.setStatus(rs.getString("status"));
				adminVO.setReg(rs.getDate("reg"));
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
		return adminVO;
	}

	@Override
	public List<AdministratorVO> getAll() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		AdministratorVO adminVO=null;
		List<AdministratorVO> list =new ArrayList<AdministratorVO>();;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				adminVO=new AdministratorVO();
				adminVO.setAdminNo(rs.getString("adminno"));
				adminVO.setAdminId(rs.getString("adminid"));
				adminVO.setAdminPsw(rs.getString("adminpsw"));
				adminVO.setPriority(rs.getString("priority"));
				adminVO.setStatus(rs.getString("status"));
				adminVO.setReg(rs.getDate("reg"));
				list.add(adminVO);
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
