package com.favdr.model;

import java.sql.*;
import java.util.*;

import com.administrator.model.AdministratorVO;

public class FavDrJDBCDAO implements FavDr_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "ca105g3";
	String password = "ca105g3";

	private static final String INSERT_STMT = "INSERT INTO favdr (memNo,drNo) VALUES (?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM FAVDR";
	private static final String GET_ONE_STMT = "SELECT MemNo, DrNo FROM FAVDR WHERE MemNo = ?";
	private static final String DELETE = "DELETE FROM favdr where memNo = ? and drNo = ?";

	@Override
	public void insert(FavDrVO favDrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, favDrVO.getMemNo());
			pstmt.setString(2, favDrVO.getDrNo());

			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
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
	public void update(FavDrVO favDrVO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(FavDrVO favDrVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, favDrVO.memNo);
			pstmt.setString(2, favDrVO.drNo);
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			if (con != null) {
				try {
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	//追蹤功能是要讓一個會員抓到他所有追蹤的醫生，所以要用List來裝不同列的物件	 
	public List<FavDrVO> findByPrimaryKey(String memNo) {//List只能裝favDrVO泛型物件

		List<FavDrVO> list = null; //先宣告一個list
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			list = new ArrayList();	//這個List是ArrayList類別
			
			pstmt.setString(1, memNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				FavDrVO favDrVO = new FavDrVO();
				favDrVO.setMemNo(rs.getString("memNo"));
				favDrVO.setDrNo(rs.getString("drNo"));
				
				list.add(favDrVO);
			}

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
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

	@Override
	public List<FavDrVO> getAll() {
		
		List<FavDrVO> list = new ArrayList<FavDrVO>();
		FavDrVO favDrVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
						
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				favDrVO = new FavDrVO();
				favDrVO.setMemNo(rs.getString("memNo"));
				favDrVO.setDrNo(rs.getString("drNo"));
				list.add(favDrVO);
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

		FavDrJDBCDAO dao = new FavDrJDBCDAO();

		// 新增
//		FavDrVO favDrVO1 = new FavDrVO();
//		favDrVO1.setMemNo("M0001");
//		favDrVO1.setDrNo("D0004");
//		dao.insert(favDrVO1);
//		System.out.println(favDrVO1.getDrNo());

		// 刪除
//		FavDrVO favDrVO2 = new FavDrVO();
//		favDrVO2.setMemNo("M0003");
//		favDrVO2.setDrNo("D0004");
//		dao.delete(favDrVO2);
		
//		查單一會員追蹤
//		List<FavDrVO> list1 = dao.findByPrimaryKey("M0007");
//		
//		for(FavDrVO favdr1 :list1) {
//			System.out.print(favdr1.getMemNo() + ",");
//			System.out.print(favdr1.getDrNo() + "," );
//			System.out.println();		
//		}
		
		//查全表
		List<FavDrVO> list2 = dao.getAll();
		for(FavDrVO favDrVO : list2) {
			System.out.print(favDrVO.getMemNo() + "," );
			System.out.print(favDrVO.getDrNo() + ",");
			System.out.println();
		}
		
	}

}
