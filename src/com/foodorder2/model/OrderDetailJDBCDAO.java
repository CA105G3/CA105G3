package com.foodorder2.model;

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

public class OrderDetailJDBCDAO implements OrderDetailDAO_Interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO ORDERDETAIL (ODNO, ORDERNO, MENULISTNO, AMOUNT, UNITPRICE)"
			+ "VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(orderdetail_seq.NEXTVAL), 4, '0'), ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM ORDERDETAIL ORDER BY ODNO"; 
	private static final String GET_ONE_STMT = "SELECT * FROM ORDERDETAIL WHERE ODNO=?";
	private static final String DELETE = "DELETE FROM ORDERDETAIL WHERE ODNO=?";
	private static final String INSERT_STMT2 =
			"INSERT INTO ORDERDETAIL (ODNO, ORDERNO, MENULISTNO, AMOUNT, UNITPRICE,ODSTATUS)"
			+ "VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(orderdetail_seq.NEXTVAL), 4, '0'), ?, ?, ?, ?, ?)";
	 
	
	@Override
	public void insert2(OrderDetailVO orderDetailVO, Connection con) {
		PreparedStatement pstmt = null;

		try {

     		pstmt = con.prepareStatement(INSERT_STMT2);

			pstmt.setString(1, orderDetailVO.getOrderno());
			pstmt.setString(2, orderDetailVO.getMenuListno());
			pstmt.setInt(3, orderDetailVO.getAmount());
			pstmt.setInt(4, orderDetailVO.getUnitPrice());
			pstmt.setString(5, orderDetailVO.getOdStatus());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-OrderDetail");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
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
		}

	}
	
	public void insert(OrderDetailVO orderDetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, orderDetailVO.getOrderno());
			pstmt.setString(2, orderDetailVO.getMenuListno());
			pstmt.setInt(3, orderDetailVO.getAmount());
			pstmt.setInt(4, orderDetailVO.getUnitPrice());
			
			pstmt.executeUpdate();
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		}catch (SQLException se) {
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
	
	public void delete(String odno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, odno);
			
			pstmt.executeUpdate();
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		}catch (SQLException se) {
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

	public OrderDetailVO findByPrimaryKey(String odno) {
		OrderDetailVO orderDetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, odno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orderDetailVO = new OrderDetailVO();
				orderDetailVO.setOdno(rs.getString("odno"));
				orderDetailVO.setOrderno(rs.getString("orderno"));
				orderDetailVO.setMenuListno(rs.getString("menuListno"));
				orderDetailVO.setAmount(rs.getInt("amount"));
				orderDetailVO.setUnitPrice(rs.getInt("unitPrice"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
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
		return orderDetailVO;
	}

	public List<OrderDetailVO> getAll(){
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orderDetailVO = new OrderDetailVO();
				orderDetailVO.setOdno(rs.getString("odno"));
				orderDetailVO.setOrderno(rs.getString("orderno"));
				orderDetailVO.setMenuListno(rs.getString("menuListno"));
				orderDetailVO.setAmount(rs.getInt("amount"));
				orderDetailVO.setUnitPrice(rs.getInt("unitPrice"));
				orderDetailVO.setOdno(rs.getString("odno"));
				list.add(orderDetailVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
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

	public static void main(String args[]) {
		OrderDetailJDBCDAO dao = new OrderDetailJDBCDAO();
		
//		//INSERT
//		OrderDetailVO orderDetailVO1 = new OrderDetailVO();
//		orderDetailVO1.setOrderno("20181212-0005");
//		orderDetailVO1.setMenuListno("20181210-0001");
//		orderDetailVO1.setAmount(3);
//		orderDetailVO1.setUnitPrice(300);
//		dao.insert(orderDetailVO1);
		
//		//DELETE
//		dao.delete("20181213-0008");
		
//		//SELECT ONE
//		OrderDetailVO orderDetailVO2 = dao.findByPrimaryKey("20181210-0001");
//		System.out.println("OrderDetail Number: " + orderDetailVO2.getOrderno() + ",");
//		System.out.println("Order Number: " + orderDetailVO2.getMenuListno() + ",");
//		System.out.println("Amount: " + orderDetailVO2.getAmount() + ",");
//		System.out.println("Unit Price: " + orderDetailVO2.getUnitPrice());
//		System.out.println("----------------------------------");
	
		//SELECT ALL
		List<OrderDetailVO> list = dao.getAll();
		for (OrderDetailVO aOrderDetail : list) {
			System.out.print(aOrderDetail.getOdno() + ",");
			System.out.print(aOrderDetail.getOrderno() + ",");
			System.out.print(aOrderDetail.getMenuListno() + ",");
			System.out.print(aOrderDetail.getAmount() + ",");
			System.out.print(aOrderDetail.getUnitPrice());
			System.out.println();
		}
	}
}
