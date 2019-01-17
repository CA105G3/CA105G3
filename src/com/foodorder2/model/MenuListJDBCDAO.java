package com.foodorder2.model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class MenuListJDBCDAO implements MenuListDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	 
	private static final String INSERT_STMT = 
		"INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT menulistno,menuno,menudate,menutimeslot from menulist order by menulistno";
	private static final String GET_ONE_STMT = 
		"SELECT menulistno,menuno,menudate,menutimeslot from menulist where menulistno=?";
	private static final String GET_ONEMENU_STMT = 
		"SELECT menulistno,menuno,menudate,menutimeslot from menulist where menuno=?";
	private static final String DELETE = 
		"DELETE FROM menulist where menulistno = ?";
	private static final String UPDATE = 
		"UPDATE menulist set menuno=?, menudate=?, menutimeslot=? where menulistno=?";
	
	@Override
	public void insert(MenuListVO menuListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, menuListVO.getMenuNo());
			pstmt.setDate(2, menuListVO.getMenuDate());
			pstmt.setString(3, menuListVO.getMenuTimeSlot());
			
			pstmt.executeUpdate();
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public void update(MenuListVO menuListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, menuListVO.getMenuNo());
			pstmt.setDate(2, menuListVO.getMenuDate());
			pstmt.setString(3, menuListVO.getMenuTimeSlot());
			pstmt.setString(4, menuListVO.getMenuListNo());
			
			pstmt.executeUpdate();
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public void delete(String menuListNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, menuListNo);
			
			pstmt.executeUpdate();
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public MenuListVO findByPrimaryKey(String menuListNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuListVO menulistVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, menuListNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();
				menulistVO.setMenuListNo(rs.getString(1));
				menulistVO.setMenuNo(rs.getString(2));
				menulistVO.setMenuDate(rs.getDate(3));
				menulistVO.setMenuTimeSlot(rs.getString(4));
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
		return menulistVO;
	}

	@Override
	public List<MenuListVO> findByMenuNo(String MenuNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuListVO> list = new ArrayList<MenuListVO>();
		MenuListVO menulistVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONEMENU_STMT);
			pstmt.setString(1, MenuNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();
				menulistVO.setMenuListNo(rs.getString(1));
				menulistVO.setMenuNo(rs.getString(2));
				menulistVO.setMenuDate(rs.getDate(3));
				menulistVO.setMenuTimeSlot(rs.getString(4));
				list.add(menulistVO);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
		return list;
	}
	
	@Override
	public List<MenuListVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuListVO> list = new ArrayList<MenuListVO>();
		MenuListVO menulistVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();
				menulistVO.setMenuListNo(rs.getString(1));
				menulistVO.setMenuNo(rs.getString(2));
				menulistVO.setMenuDate(rs.getDate(3));
				menulistVO.setMenuTimeSlot(rs.getString(4));
				list.add(menulistVO);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
		return list;
	}

	public static void main(String[] args) {
		MenuListJDBCDAO dao = new MenuListJDBCDAO();
		
//		// 新增
//		MenuListVO menulistVO1 = new MenuListVO();
//		menulistVO1.setMenuNo("20181213-0001");
//		menulistVO1.setMenuDate(java.sql.Date.valueOf("2018-12-25"));
//		menulistVO1.setMenuTimeSlot("早");
//		dao.insert(menulistVO1);
//		
//		// 修改
//		MenuListVO menulistVO2 = new MenuListVO();
//		menulistVO2.setMenuListNo("20181213-0003");;
//		menulistVO2.setMenuNo("20181213-0001");
//		menulistVO2.setMenuDate(java.sql.Date.valueOf("2018-12-24"));
//		menulistVO2.setMenuTimeSlot("晚");
//		dao.update(menulistVO2);
//		
//		// 刪除
//		dao.delete("20181213-0003");
//		
		// 查詢一筆
		MenuListVO menulistVO3 = dao.findByPrimaryKey("20190105-0012");
		System.out.print(menulistVO3.getMenuListNo() + " , ");
		System.out.print(menulistVO3.getMenuNo() + " , ");
		System.out.print(menulistVO3.getMenuDate() + " , ");
		System.out.println(menulistVO3.getMenuTimeSlot() + " , ");
		System.out.println("================================");
		
		java.util.Date ud = new java.util.Date(menulistVO3.getMenuDate().getTime());
		System.out.println(menulistVO3.getMenuDate().getDate());
		System.out.println(menulistVO3.getMenuDate().getMonth()+1);
		System.out.println(menulistVO3.getMenuDate().getYear()+1900);
		System.out.println(menulistVO3.getMenuDate().toString());
		
		int year = 2019;
		int month = 1;
		int day = 5;
		if(menulistVO3.getMenuDate().toString().equals(new StringBuilder().append(year).append("-").append(month).append("-").append(day).toString())) {
			System.out.println("true");
		} else {
			System.out.println("false");
		}
		
//		
//		// 查詢一項MENUNO
//		List<MenuListVO> list1 = dao.findByMenuNo("20181230-0010");
//		for(MenuListVO amenulistVO : list1) {
//			System.out.print(amenulistVO.getMenuListNo() + " , ");
//			System.out.print(amenulistVO.getMenuNo() + " , ");
//			System.out.print(amenulistVO.getMenuDate() + " , ");
//			System.out.println(amenulistVO.getMenuTimeSlot() + " , ");
//			System.out.println("--------------------------------");
//		}
//		
//		// 查詢全部
//		List<MenuListVO> list = dao.getAll();
//		for(MenuListVO bmenulistVO : list) {
//			System.out.print(bmenulistVO.getMenuListNo() + " , ");
//			System.out.print(bmenulistVO.getMenuNo() + " , ");
//			System.out.print(bmenulistVO.getMenuDate() + " , ");
//			System.out.println(bmenulistVO.getMenuTimeSlot() + " , ");
//			System.out.println("--------------------------------");
//		}
	}

}
