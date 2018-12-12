package com.favdr.model;

import java.sql.*;
import java.util.*;

import com.administrator.model.AdministratorVO;

public class FavdrJDBCDAO implements Favdr_interface {

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "ca105g3";
	String password = "ca105g3";

	private static final String INSERT_STMT = "INSERT INTO favdr (memno,drno) VALUES (?,?)";
	private static final String GET_ALL_STMT = "SELECT adminno,priority,status,reg FROM Administrator order by adminno";
	private static final String GET_ONE_STMT = "SELECT MEMNO, DRNO FROM FAVDR WHERE MEMNO = ?";
	private static final String DELETE = "DELETE FROM favdr where memno = ? and drno = ?";

	@Override
	public void insert(FavdrVO favdrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, favdrVO.getMemno());
			pstmt.setString(2, favdrVO.getDrno());

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
	public void update(FavdrVO favdrVO) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(FavdrVO favdrVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, favdrVO.memno);
			pstmt.setString(2, favdrVO.drno);
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
	/*追蹤功能是要讓一個會員抓到他所有追蹤的醫生，所以要用List來裝不同列的物件
	 */
	public List<FavdrVO> findByPrimaryKey(String memno) {//List只能裝FavdrVO泛型物件

		List<FavdrVO> list = null; //先宣告一個list
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			list = new ArrayList();	//這個List是ArrayList類別
			
			pstmt.setString(1, memno);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				FavdrVO favdrVO = new FavdrVO();
				favdrVO.setMemno(rs.getString("memno"));
				favdrVO.setDrno(rs.getString("drno"));
				
				list.add(favdrVO);
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
	public List<FavdrVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	public static void main(String[] args) {

		FavdrJDBCDAO dao = new FavdrJDBCDAO();

		// 新增
//		FavdrVO favdrVO1 = new FavdrVO();
//		favdrVO1.setMemno("M0001");
//		favdrVO1.setDrno("D0004");
//		dao.insert(favdrVO1);
//		System.out.println(favdrVO1.getDrno());

		// 刪除
//		FavdrVO favdrVO2 = new FavdrVO();
//		favdrVO2.setMemno("M0003");
//		favdrVO2.setDrno("D0004");
//		dao.delete(favdrVO2);
		
//		查單一會員追蹤
		List<FavdrVO> list1 = dao.findByPrimaryKey("M0007");
		
		for(FavdrVO favdr1 :list1) {
			System.out.print(favdr1.getMemno() + ",");
			System.out.print(favdr1.getDrno() + "," );
			System.out.println();		
		}
		
	}

}
