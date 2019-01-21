package com.menulist.model2;

import java.sql.*;
import java.util.*;

import com.foodorder.model.FoodOrderVO;

public class MenuListJDBCDAO implements MenuListDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT DISTINCT FOODORDER.ORDERNO, MEMBERCHEF.CHEFREP, MEMBERCHEF.CHEFNAME, MENU.MAINCOURSE, MENULIST.MENUTIMESLOT, ORDERDETAIL.AMOUNT, ORDERDETAIL.UNITPRICE FROM FOODORDER" + 
					"LEFT JOIN ORDERDETAIL ON FOODORDER.ORDERNO=ORDERDETAIL.ORDERNO LEFT JOIN MENULIST ON ORDERDETAIL.MENULISTNO=MENULIST.MENULISTNO" + 
					"LEFT JOIN MENU ON MENULIST.MENUNO=MENU.MENUNO LEFT JOIN MEMBERCHEF ON MENU.CHEFNO=MEMBERCHEF.CHEFNO";
	private static final String GET_BY_MEMNO_STMT = 
			"SELECT DISTINCT FOODORDER.ORDERNO, FOODORDER.DELIVERADDR, ORDERDETAIL.ODNO, MEMBERCHEF.CHEFNAME, MEMBERCHEF.CHEFREP, MENU.MAINCOURSE, MENULIST.MENUTIMESLOT, ORDERDETAIL.AMOUNT, ORDERDETAIL.UNITPRICE FROM FOODORDER" + 
			" LEFT JOIN ORDERDETAIL ON FOODORDER.ORDERNO=ORDERDETAIL.ORDERNO LEFT JOIN MENULIST ON ORDERDETAIL.MENULISTNO=MENULIST.MENULISTNO" + 
			" LEFT JOIN MENU ON MENULIST.MENUNO=MENU.MENUNO LEFT JOIN MEMBERCHEF ON MENU.CHEFNO=MEMBERCHEF.CHEFNO WHERE FOODORDER.MEMNO=?";
	private static final String GET_BY_CHEFNAME_STMT = 
			"SELECT DISTINCT MEMBERCHEF.CHEFNAME, MEMBERCHEF.CHEFREP, MENU.MAINCOURSE, MENULIST.MenuListNo,MENULIST.MENUTIMESLOT, MENU.UNITPRICE, MENU.MENUNO, MENULIST.MENUDATE, MENU.CHEFNO FROM MENULIST LEFT JOIN MENU ON MENULIST.MENUNO=MENU.MENUNO "
			+ "LEFT JOIN MEMBERCHEF ON MENU.CHEFNO=MEMBERCHEF.CHEFNO WHERE MEMBERCHEF.CHEFNAME=? ORDER BY MENULIST.MENUDATE";
	private static final String GET_BY_MENUTIMESLOT_STMT = 
			"SELECT * FROM MENULIST LEFT JOIN MENU ON MENULIST.MENUNO=MENU.MENUNO LEFT JOIN MEMBERCHEF ON MENU.CHEFNO=MEMBERCHEF.CHEFNO WHERE MENULIST.MENUTIMESLOT=?";
	
	private static final String GET_ONE_STMT = 
		"SELECT menulistno,menuno,menudate,menutimeslot from menulist where menulistno=?";
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

	public List<MenuListVO> findByMemno(String memno) {
		List<MenuListVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuListVO menulistVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_BY_MEMNO_STMT);
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();				
				menulistVO.setOrderno(rs.getString("orderno"));
				menulistVO.setOdno(rs.getString("odno"));
				menulistVO.setChefName(rs.getString("chefName"));
				menulistVO.setChefRep(rs.getString("chefRep"));
				menulistVO.setMainCourse(rs.getString("mainCourse"));
				menulistVO.setUnitPrice(rs.getInt("unitPrice"));
				menulistVO.setDeliverAddr(rs.getString("deliverAddr"));
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
	
	public List<MenuListVO> findByChefName(String chefName) {
		List<MenuListVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuListVO menulistVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_BY_CHEFNAME_STMT);
			pstmt.setString(1, chefName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();				
				menulistVO.setMenuListNo(rs.getString("MenuListNo"));
				menulistVO.setMenuDate(rs.getDate("MenuDate"));
				menulistVO.setChefRep(rs.getString("chefRep"));
				menulistVO.setChefName(rs.getString("chefName"));
				menulistVO.setChefNo(rs.getString("chefNo"));
				menulistVO.setMenuNo(rs.getString("menuNo"));
				menulistVO.setMainCourse(rs.getString("mainCourse"));
				menulistVO.setMenuTimeSlot(rs.getString("menuTimeSlot"));
				menulistVO.setUnitPrice(rs.getInt("unitPrice"));
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
	
	public List<MenuListVO> findByMenuTimeSlot(String menuTimeSlot) {
		List<MenuListVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuListVO menulistVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_BY_MENUTIMESLOT_STMT);
			pstmt.setString(1, menuTimeSlot);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();
				menulistVO.setMenuListNo(rs.getString("MenuListNo"));
				menulistVO.setChefRep(rs.getString("chefRep"));
				menulistVO.setMainCourse(rs.getString("mainCourse"));
				menulistVO.setMenuTimeSlot(rs.getString("menuTimeSlot"));
				menulistVO.setUnitPrice(rs.getInt("unitPrice"));
				
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
				menulistVO.setChefRep(rs.getString("chefRep"));
				menulistVO.setMainCourse(rs.getString("mainCourse"));
				menulistVO.setMenuTimeSlot(rs.getString("menuTimeSlot"));
				menulistVO.setAmount(rs.getInt("amount"));
				menulistVO.setUnitPrice(rs.getInt("unitPrice"));
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
		
		// 新增
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
		
//		// 用會員編號查詢
		List<MenuListVO> list = dao.findByMemno("M0001");
		for(MenuListVO amenulistVO : list) {
		System.out.print(amenulistVO.getOrderno() + " , ");
		System.out.print(amenulistVO.getOdno() + " , ");
		System.out.print(amenulistVO.getChefName() + " , ");
		System.out.print(amenulistVO.getChefRep() + " , ");
		System.out.print(amenulistVO.getMainCourse() + " , ");
		System.out.print(amenulistVO.getMenuTimeSlot() + " , ");
		System.out.println(amenulistVO.getUnitPrice());
		System.out.println(amenulistVO.getDeliverAddr());
		System.out.println("----------------------");
		}
		
//		// 用業者編號查詢
//		List<MenuListVO> list = dao.findByChefName("孫小美");
//		for(MenuListVO amenulistVO : list) {
//		System.out.print(amenulistVO.getChefName() + " , ");
//		System.out.print(amenulistVO.getMainCourse() + " , ");
//		System.out.print(amenulistVO.getMenuNo() + " , ");
//		System.out.print(amenulistVO.getMenuTimeSlot() + " , ");
//		System.out.print(amenulistVO.getMenuDate() + " , ");
//		System.out.println(amenulistVO.getUnitPrice());
//		System.out.println(amenulistVO.getChefNo());
//		System.out.println("----------------------");
//		}
		
		// 用供餐時間查詢
//		List<MenuListVO> list2 = dao.findByMenuTimeSlot("早");
//		for(MenuListVO amenulistVO : list2) {
//		System.out.print(amenulistVO.getChefRep() + " , ");
//		System.out.print(amenulistVO.getMainCourse() + " , ");
//		System.out.print(amenulistVO.getMenuTimeSlot() + " , ");
//		System.out.println(amenulistVO.getUnitPrice() + " , ");
//		System.out.println("----------------------------------------------------");
//		}
//		
//		// 查詢一筆
//		MenuListVO menulistVO3 = dao.findByPrimaryKey("20181213-0001");
//		System.out.print(menulistVO3.getMenuListNo() + " , ");
//		System.out.print(menulistVO3.getMenuNo() + " , ");
//		System.out.print(menulistVO3.getMenuDate() + " , ");
//		System.out.println(menulistVO3.getMenuTimeSlot() + " , ");
//		System.out.println("================================");
		
		// 查詢全部
//		List<MenuListVO> list = dao.getAll();
//		for(MenuListVO amenulistVO : list) {
//			System.out.print(amenulistVO.getChefNo() + " , ");
//			System.out.print(amenulistVO.getMainCourse() + " , ");
//			System.out.print(amenulistVO.getMenuTimeSlot() + " , ");
//			System.out.println(amenulistVO.getAmount() + " , ");
//			System.out.println(amenulistVO.getUnitPrice() + " , ");
//			System.out.println("--------------------------------");
//		}
	}

}
