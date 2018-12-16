package com.orderdetail.model;

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

public class OrderDetailDAO implements OrderDetailDAO_Interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException ne) {
			ne.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT =
			"INSERT INTO ORDERDETAIL (ODNO, ORDERNO, MENULISTNO, AMOUNT, UNITPRICE)"
			+ "VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(orderdetail_seq.NEXTVAL), 4, '0'), ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM ORDERDETAIL ORDER BY ODNO"; 
	private static final String GET_ONE_STMT = "SELECT * FROM ORDERDETAIL WHERE ODNO=?";
	private static final String DELETE = "DELETE FROM ORDERDETAIL WHERE ODNO=?";
	
	public void insert(OrderDetailVO orderDetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, orderDetailVO.getOrderno());
			pstmt.setString(2, orderDetailVO.getMenuListno());
			pstmt.setInt(3, orderDetailVO.getAmount());
			pstmt.setInt(4, orderDetailVO.getUnitPrice());
			
			pstmt.executeUpdate();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, odno);
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
}
