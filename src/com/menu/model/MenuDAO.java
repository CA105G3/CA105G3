package com.menu.model;

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

public class MenuDAO implements MenuDAO_interface{
	
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
		"INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT menuno,chefno,unitprice,maincourse,menupic,deliverable,menuintro from menu order by menuno";
	private static final String GET_ONE_STMT = 
		"SELECT menuno,chefno,unitprice,maincourse,menupic,deliverable,menuintro from menu where menuno=?";
	private static final String GET_MENU_STMT = 
		"SELECT menuno,chefno,unitprice,maincourse,menupic,deliverable,menuintro from menu where chefno=?";
	private static final String DELETE = 
		"DELETE FROM menu where menuno = ?";
	private static final String UPDATE = 
		"UPDATE menu set unitprice=?, maincourse=?, menupic=?, deliverable=?, menuintro=? where menuno=?";
	
	@Override
	public void insert(MenuVO menuVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, menuVO.getChefNo());
			pstmt.setInt(2, menuVO.getUnitPrice());
			pstmt.setString(3, menuVO.getMainCourse());
			pstmt.setBytes(4, menuVO.getMenuPic());
			pstmt.setString(5, menuVO.getDeliverable());
			pstmt.setString(6, menuVO.getMenuIntro());
			
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
	public void update(MenuVO menuVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, menuVO.getUnitPrice());
			pstmt.setString(2, menuVO.getMainCourse());
			pstmt.setBytes(3, menuVO.getMenuPic());
			pstmt.setString(4, menuVO.getDeliverable());
			pstmt.setString(5, menuVO.getMenuIntro());
			pstmt.setString(6, menuVO.getMenuNo());
			
			
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
	public void delete(String menuNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, menuNo);
			
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
	public MenuVO findByPrimaryKey(String menuNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuVO menuVO = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, menuNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menuVO = new MenuVO();
				menuVO.setMenuNo(rs.getString(1));
				menuVO.setChefNo(rs.getString(2));
				menuVO.setUnitPrice(rs.getInt(3));
				menuVO.setMainCourse(rs.getString(4));
				menuVO.setMenuPic(rs.getBytes(5));
				menuVO.setDeliverable(rs.getString(6));
				menuVO.setMenuIntro(rs.getString(7));
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
		return menuVO;
	}

	@Override
	public List<MenuVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuVO> list = new ArrayList<MenuVO>();
		MenuVO menuVO = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menuVO = new MenuVO();
				menuVO.setMenuNo(rs.getString(1));
				menuVO.setChefNo(rs.getString(2));
				menuVO.setUnitPrice(rs.getInt(3));
				menuVO.setMainCourse(rs.getString(4));
				menuVO.setMenuPic(rs.getBytes(5));
				menuVO.setDeliverable(rs.getString(6));
				menuVO.setMenuIntro(rs.getString(7));
				list.add(menuVO);
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
	public List<MenuVO> findByChefNo(String chefNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MenuVO> list = new ArrayList<MenuVO>();
		MenuVO menuVO = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_MENU_STMT);
			pstmt.setString(1, chefNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menuVO = new MenuVO();
				menuVO.setMenuNo(rs.getString(1));
				menuVO.setChefNo(rs.getString(2));
				menuVO.setUnitPrice(rs.getInt(3));
				menuVO.setMainCourse(rs.getString(4));
				menuVO.setMenuPic(rs.getBytes(5));
				menuVO.setDeliverable(rs.getString(6));
				menuVO.setMenuIntro(rs.getString(7));
				list.add(menuVO);
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
