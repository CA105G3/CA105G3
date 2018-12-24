package com.administrator.model;

import java.sql.*;
import java.util.*;

public class AdministratorJDBCDAO implements Administrator_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "CA105G3";
	String password = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO Administrator (adminNo,adminid,adminPsw,adminName,priority,status,reg) VALUES ('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?)";
	private static final String GET_ALL_STMT = 
			"SELECT adminNo,adminId,adminName,adminPsw,priority,status,reg FROM Administrator order by adminNo";
	private static final String GET_ONE_STMT = 
			"SELECT adminNo,adminId,adminName,adminPsw,priority,status,reg FROM Administrator where adminNo = ?";
	private static final String DELETE = 
			"DELETE FROM Administrator where adminNo = ? ";
	private static final String UPDATE_PRIORITY_STATUS = 
			"UPDATE Administrator set priority = ?, status = ? where adminNo = ?";
	private static final String UPDATE_PRIORITY =
			"UPDATE Administrator set priority = ? where adminNo = ?";
	private static final String UPDATE_STATUS =
			"UPDATE Administrator set status = ? where adminNo = ?";
	
	@Override
	public void insert(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, administratorVO.getAdminId());
			pstmt.setString(2, administratorVO.getAdminPsw());
			pstmt.setString(3, administratorVO.getAdminName());
			pstmt.setString(4, administratorVO.getPriority());
			pstmt.setString(5, administratorVO.getStatus());
			pstmt.setDate(6, administratorVO.getReg());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}			
			
		}
		
		

	}

	@Override
	public void update(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_PRIORITY_STATUS);
				
			pstmt.setString(1, administratorVO.getPriority());
			pstmt.setString(2, administratorVO.getStatus());
			pstmt.setString(3, administratorVO.getAdminNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}			
			
		}
		
	}
/*
	@Override
	public void update_priority(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_PRIORITY);
				
			pstmt.setString(1, administratorVO.getPriority());
			pstmt.setString(2, administratorVO.getAdminNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}						
		}		
	}

	@Override
	public void update_status(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STATUS);
				
			pstmt.setString(1, administratorVO.getStatus());
			pstmt.setString(2, administratorVO.getAdminNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		}finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}						
		}		
		
	}
	*/
	@Override
	public void delete(String adminNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
				
		try {
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, adminNo);
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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

		AdministratorVO administratorVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, adminNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				administratorVO = new AdministratorVO();
				administratorVO.setAdminId(rs.getString("adminId"));
				administratorVO.setAdminPsw(rs.getString("adminPsw"));
				administratorVO.setAdminNo(rs.getString("adminNo"));
				administratorVO.setAdminName(rs.getString("adminName"));
				administratorVO.setPriority(rs.getString("priority"));
				administratorVO.setStatus(rs.getString("status"));
				administratorVO.setReg(rs.getDate("reg"));
			}
				
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		}finally {
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
			
		return administratorVO;
	}

	@Override
	public List<AdministratorVO> getAll() {
		
		List<AdministratorVO> list = new ArrayList<AdministratorVO>();
		AdministratorVO administratorVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
						
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				administratorVO = new AdministratorVO();
				administratorVO.setAdminId(rs.getString("adminId"));
				administratorVO.setAdminPsw(rs.getString("adminPsw"));
				administratorVO.setAdminNo(rs.getString("adminNo"));
				administratorVO.setAdminName(rs.getString("adminName"));
				administratorVO.setPriority(rs.getString("priority"));
				administratorVO.setStatus(rs.getString("status"));
				administratorVO.setReg(rs.getDate("reg"));
				
				list.add(administratorVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		}finally {
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
		
	public static void main(String[] args) {
		
		AdministratorJDBCDAO dao = new AdministratorJDBCDAO();
		
		//新增
//		AdministratorVO administratorVO1 = new AdministratorVO();
//		administratorVO1.setAdminId("HOWHOW");
//		administratorVO1.setAdminPsw("123456");
//		administratorVO1.setPriority("一般管理員");
//		administratorVO1.setStatus("生效中");
//		administratorVO1.setReg(java.sql.Date.valueOf("2018-12-01"));
//		dao.insert(administratorVO1);

		
		//刪除
//		dao.delete("A0006");
		
		//修改權限與狀態
//		AdministratorVO administratorVO2 = new AdministratorVO();
//		administratorVO2.setPriority("一般管理員");
//		administratorVO2.setStatus("已失效");
//		administratorVO2.setAdminNo("A0009");		
//		dao.update_priority_status(administratorVO2);
		
		//修改權限
//		AdministratorVO administratorVO3 = new AdministratorVO();
//		administratorVO3.setPriority("一般管理員");
//		administratorVO3.setAdminNo("A0010");		
//		dao.update_priority(administratorVO3);
		
		//修改狀態
//		AdministratorVO administratorVO4 = new AdministratorVO();
//		administratorVO4.setStatus("已失效");
//		administratorVO4.setAdminNo("A0004");		
//		dao.update_status(administratorVO4);
		
		//查詢：查單一
//		AdministratorVO administratorVO5 = new AdministratorVO();
//		administratorVO5 = dao.findByPrimaryKey("A0006");
//		System.out.print(administratorVO5.getAdminId() + ",");
//		System.out.print(administratorVO5.getAdminPsw() + ",");
//		System.out.print(administratorVO5.getAdminNo() + ",");
//		System.out.print(administratorVO5.getPriority() + ",");
//		System.out.print(administratorVO5.getStatus());
		
		//查詢：查全部
//		List<AdministratorVO> list = dao.getAll();
//		for(AdministratorVO administrator : list) {
//			System.out.print(administrator.getAdminId() + ",");
//			System.out.print(administrator.getAdminPsw() + ",");
//			System.out.print(administrator.getAdminNo() + "," );
//			System.out.print(administrator.getPriority() + ",");
//			System.out.print(administrator.getStatus() + ",");
//			System.out.print(administrator.getReg());
//			System.out.println();
//		}
		
	}	

}
