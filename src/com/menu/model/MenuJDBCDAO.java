package com.menu.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class MenuJDBCDAO implements MenuDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO menu VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(menu_seq.NEXTVAL), 4, '0'),'CHEF0001', ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT menuno,chefno,unitprice,maincourse,delivertime from menu order by menuno";
	private static final String GET_ONE_STMT = 
		"SELECT menuno,chefno,unitprice,maincourse,delivertime from menu where menuno=?";
	private static final String DELETE = 
		"DELETE FROM menu where menuno = ?";
	private static final String UPDATE = 
		"UPDATE menu set unitprice=?, maincourse=?, menupic=?, delivertime=? where menuno=?";
	
	@Override
	public void insert(MenuVO menuVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setInt(1, menuVO.getUnitPrice());
			pstmt.setString(2, menuVO.getMainCourse());
			Blob blob = con.createBlob();
			blob.setBytes(1, menuVO.getMenuPic());
			pstmt.setBlob(3, blob);
			pstmt.setString(4, menuVO.getDeliverable());
			
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
	public void update(MenuVO menuVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setInt(1, menuVO.getUnitPrice());
			pstmt.setString(2, menuVO.getMainCourse());
			Blob blob = con.createBlob();
			blob.setBytes(1, menuVO.getMenuPic());
			pstmt.setBlob(3, blob);
			pstmt.setString(4, menuVO.getDeliverable());
			pstmt.setString(5, menuVO.getMenuNo());
			
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
	public void delete(String menuNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, menuNo);
			
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
	public MenuVO findByPrimaryKey(String menuNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MenuVO menuVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, menuNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menuVO = new MenuVO();
				menuVO.setMenuNo(rs.getString(1));
				menuVO.setChefNo(rs.getString(2));
				menuVO.setUnitPrice(rs.getInt(3));
				menuVO.setMainCourse(rs.getString(4));
//				menuVO.setMenuPic(rs.getBytes(5));
				menuVO.setDeliverable(rs.getString(5));
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menuVO = new MenuVO();
				menuVO.setMenuNo(rs.getString(1));
				menuVO.setChefNo(rs.getString(2));
				menuVO.setUnitPrice(rs.getInt(3));
				menuVO.setMainCourse(rs.getString(4));
//				menuVO.setMenuPic(rs.getBytes(5));
				menuVO.setDeliverable(rs.getString(5));
				list.add(menuVO);
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

	public static byte[] getPictureByteArray(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = fis.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();

		return baos.toByteArray();
	}
	
	public static void main(String[] args) {
		MenuJDBCDAO dao = new MenuJDBCDAO();
		
		// 新增
		MenuVO menuVO1 = new MenuVO();
		menuVO1.setUnitPrice(90);
		menuVO1.setMainCourse("彗星炒飯");
		byte[] pic1 = null;
		try {
			pic1 = getPictureByteArray("WebContent/imgs/friedrice.jpg");
		} catch (IOException e) {
			e.printStackTrace();
		}
		menuVO1.setMenuPic(pic1);
		menuVO1.setDeliverable("可送餐");
		dao.insert(menuVO1);
		
		// 修改
		MenuVO menuVO2 = new MenuVO();
		menuVO2.setMenuNo("20181212-0003");
		menuVO2.setUnitPrice(90);
		menuVO2.setMainCourse("麥哲倫彗星炒飯");
		byte[] pic2 = null;
		try {
			pic2 = getPictureByteArray("WebContent/imgs/friedrice.jpg");
		} catch (IOException e) {
			e.printStackTrace();
		}
		menuVO2.setMenuPic(pic2);
		menuVO2.setDeliverable("不可送餐");
		dao.update(menuVO2);
		
		// 刪除
		dao.delete("20181212-0003");
		
		// 查詢一筆
		MenuVO menuVO3 = dao.findByPrimaryKey("20181212-0001");
		System.out.print(menuVO3.getMenuNo() + " , ");
		System.out.print(menuVO3.getChefNo() + " , ");
		System.out.print(menuVO3.getUnitPrice() + " , ");
		System.out.print(menuVO3.getMainCourse() + " , ");
		System.out.println(menuVO3.getDeliverable());
		System.out.println("================================");
		
		// 查詢全部
		List<MenuVO> list = dao.getAll();
		for(MenuVO amenuVO : list) {
			System.out.print(amenuVO.getMenuNo() + " , ");
			System.out.print(amenuVO.getChefNo() + " , ");
			System.out.print(amenuVO.getUnitPrice() + " , ");
			System.out.print(amenuVO.getMainCourse() + " , ");
			System.out.println(amenuVO.getDeliverable());
			System.out.println("--------------------------------");
		}
	}
}
