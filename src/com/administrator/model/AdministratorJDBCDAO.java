package com.administrator.model;

import java.sql.*;
import java.util.*;

public class AdministratorJDBCDAO implements Administrator_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "ca105g3";
	String password = "ca105g3";

	private static final String INSERT_STMT = 
			"INSERT INTO Administrator (adminno,priority,status,reg) VALUES ('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT adminno,priority,status,reg FROM Administrator order by adminno";
	private static final String GET_ONE_STMT = 
			"SELECT adminno,priority,status,reg FROM Administrator where adminno = ?";
	private static final String DELETE = 
			"DELETE FROM Administrator where adminno = ? ";
	private static final String UPDATE_PRIORITY_STATUS = 
			"UPDATE Administrator set priority = ?, status = ? where adminno = ?";
	private static final String UPDATE_PRIORITY =
			"UPDATE Administrator set priority = ? where adminno = ?";
	private static final String UPDATE_STATUS =
			"UPDATE Administrator set status = ? where adminno = ?";
	
	@Override
	public void insert(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, administratorVO.getPriority());
			pstmt.setString(2, administratorVO.getStatus());
			pstmt.setDate(3, administratorVO.getReg());
			
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
	public void update_priority_status(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_PRIORITY_STATUS);
				
			pstmt.setString(1, administratorVO.getPriority());
			pstmt.setString(2, administratorVO.getStatus());
			pstmt.setString(3, administratorVO.getAdminno());
			
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
	public void update_priority(AdministratorVO administratorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_PRIORITY);
				
			pstmt.setString(1, administratorVO.getPriority());
			pstmt.setString(2, administratorVO.getAdminno());
			
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
			pstmt.setString(2, administratorVO.getAdminno());
			
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
	public void delete(String adminno) {
		
		try {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, adminno);
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

	}

	@Override
	public AdministratorVO findByPrimaryKey(String adminno) {

		AdministratorVO administratorVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, adminno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				administratorVO = new AdministratorVO();
				administratorVO.setAdminno(rs.getString("adminno"));
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
			
		return null;
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
				administratorVO.setAdminno(rs.getString("adminno"));
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
		
		//�s�W
//		AdministratorVO administratorVO1 = new AdministratorVO();
//		administratorVO1.setPriority("�@��޲z��");
//		administratorVO1.setStatus("�ͮĤ�");
//		administratorVO1.setReg(java.sql.Date.valueOf("2018-12-01"));
//		dao.insert(administratorVO1);

		
		//�R��
//		dao.delete("A0006");
		
		//�ק��v��&���A
//		AdministratorVO administratorVO2 = new AdministratorVO();
//		administratorVO2.setPriority("�@��޲z��");
//		administratorVO2.setStatus("�w����");
//		administratorVO2.setAdminno("A0009");		
//		dao.update_priority_status(administratorVO2);
		
		//�ק��v��
//		AdministratorVO administratorVO3 = new AdministratorVO();
//		administratorVO3.setPriority("�@��޲z��");
//		administratorVO3.setAdminno("A0010");		
//		dao.update_priority(administratorVO3);
		
		//�ק窱�A
		AdministratorVO administratorVO4 = new AdministratorVO();
		administratorVO4.setPriority("�@��޲z��");
		administratorVO4.setAdminno("A0010");		
		dao.update_status(administratorVO4);
		
		//�d�ߡG�d����
//		List<AdministratorVO> list = dao.getAll();
//		for(AdministratorVO administrator : list) {
//			System.out.print(administrator.getAdminno() + "," );
//			System.out.print(administrator.getPriority() + ",");
//			System.out.print(administrator.getStatus() + ",");
//			System.out.print(administrator.getReg());
//			System.out.println();
//		}
		
		
		
		
	}


	
	

}
