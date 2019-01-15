package com.menulist.model2;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MenuListDAO implements MenuListDAO_interface{
	
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
			"INSERT INTO menulist VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menulist_seq.NEXTVAL), 4, '0'), ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT menulistno,menuno,menudate,menutimeslot from menulist order by menulistno";
		
		private static final String GET_BY_CHEFREP_STMT = 
				"SELECT * FROM MENULIST LEFT JOIN MENU ON MENULIST.MENUNO=MENU.MENUNO LEFT JOIN MEMBERCHEF ON MENU.CHEFNO=MEMBERCHEF.CHEFNO WHERE MEMBERCHEF.CHEFREP=?";
		private static final String GET_BY_MENUTIMESLOT_STMT = 
				"SELECT * FROM MENULIST LEFT JOIN MENU ON MENULIST.MENUNO=MENU.MENUNO LEFT JOIN MEMBERCHEF ON MENU.CHEFNO=MEMBERCHEF.CHEFNO WHERE MENULIST.MENUTIMESLOT=?";
		
		private static final String GET_ONE_STMT = 
			"SELECT menulistno,menuno,menudate,menutimeslot from menulist where menulistno=?";
		private static final String DELETE = 
			"DELETE FROM menulist where menulistno = ?";
		private static final String UPDATE = 
			"UPDATE menulist set menuno=?, menudate=?, menutimeslot=? where menulistno=?";
	
	public void insert(MenuListVO menuListVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, menuListVO.getMenuNo());
			pstmt.setDate(2, menuListVO.getMenuDate());
			pstmt.setString(3, menuListVO.getMenuTimeSlot());
			
			pstmt.executeUpdate();
			
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1, menuListVO.getMenuNo());
			pstmt.setDate(2, menuListVO.getMenuDate());
			pstmt.setString(3, menuListVO.getMenuTimeSlot());
			pstmt.setString(4, menuListVO.getMenuListNo());
			
			pstmt.executeUpdate();
			
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, menuListNo);
			
			pstmt.executeUpdate();
			
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

	public List<MenuListVO> findByChefRep(String chefRep) {
		List<MenuListVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuListVO menulistVO = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_CHEFREP_STMT);
			pstmt.setString(1, chefRep);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();			
				menulistVO.setMenuListNo(rs.getString("menuListNo"));
				menulistVO.setChefRep(rs.getString("chefRep"));
				menulistVO.setMainCourse(rs.getString("mainCourse"));
				menulistVO.setMenuTimeSlot(rs.getString("menuTimeSlot"));
				menulistVO.setUnitPrice(rs.getInt("unitPrice"));
				list.add(menulistVO);
			}
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_MENUTIMESLOT_STMT);
			pstmt.setString(1, menuTimeSlot);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menulistVO = new MenuListVO();
				menulistVO.setChefRep(rs.getString("chefRep"));
				menulistVO.setMainCourse(rs.getString("mainCourse"));
				menulistVO.setMenuTimeSlot(rs.getString("menuTimeSlot"));
				menulistVO.setUnitPrice(rs.getInt("unitPrice"));
				list.add(menulistVO);
			}
			
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
}