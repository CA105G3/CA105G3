package com.foodorder.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.orderdetail.model.OrderDetailVO;


public class FoodOrderDAO implements FoodOrderDAO_Interface {
	private static DataSource ds = null;
	static {
		Context ctx;
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT =
			"INSERT INTO FOODORDER(ORDERNO, MEMNO, DELIVERADDR, CHEFNO, ORDERSTATUS, ORDTIME)"
			+ "VALUES(to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),?,?,?,?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM FOODORDER ORDER BY ORDERNO";
	private static final String GET_ONE_STMT = "SELECT * FROM FOODORDER WHERE ORDERNO = ?";
	private static final String GET_ALL_OrderMemno_STMT = "SELECT DISTINCT MEMNO FROM FOODORDER WHERE CHEFNO='CHEF0001'";
	private static final String GET_OrderByMemno_STMT = "SELECT * FROM FOODORDER WHERE MEMNO='M0001'";
	private static final String GET_OrderDetails_ByOrder_STMT = "SELECT * FROM ORDERDETAIL WHERE ORDERNO = ? ORDER BY ODNO";
	private static final String DELETE = "DELETE FROM FOODORDER WHERE ORDERNO = ?";
	
	public void insert(FoodOrderVO foodOrderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, foodOrderVO.getMemno());
			pstmt.setString(2, foodOrderVO.getDeliverAddr());
			pstmt.setString(3, foodOrderVO.getChefno());
			pstmt.setString(4, foodOrderVO.getOrderStatus());
			pstmt.setDate(5, foodOrderVO.getOrdTime());
			
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
	
	public FoodOrderVO findByPrimaryKey(String orderno) {
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, orderno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));				
			}
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured" + se.getMessage());
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
		return foodOrderVO;
	}

	public List<FoodOrderVO> getAll(){
		List<FoodOrderVO> list = new ArrayList<FoodOrderVO>();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));
			}
		}catch (SQLException se) {
				new RuntimeException("A database error occured" + se.getMessage());
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
	
	public List<String> getAllOrderMemno(){
		List<String> list2 = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_OrderMemno_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {                   //new一個FoodOrderVO讓rs放值
//				foodOrderVO = new FoodOrderVO();  //在這裡把取到的值轉成字串，("memno")為欄位名稱				                        
//				foodOrderVO.setMemno(rs.getString("memno"));
//				list2.add(foodOrderVO.getMemno());//再把從rs取出來、放到foodOrderVO的值，利用getMemno()取出並加進list2裡面
				
				//或是把取出的值直接加入list2裡即可
				list2.add(rs.getString("memno"));				
			}
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured" + se.getMessage());
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
		return list2;
	}
	
	public List<FoodOrderVO> findByMemno(String memno){
		List<FoodOrderVO> list3 = new ArrayList();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_OrderByMemno_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));	
				list3.add(foodOrderVO);
			}
		} catch(SQLException se) {
			throw new RuntimeException("A database error occured" + se.getMessage());
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
		return list3;
	}
	
	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
		Set<OrderDetailVO> set = new LinkedHashSet<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_OrderDetails_ByOrder_STMT);
			rs = pstmt.executeQuery();
			
		while(rs.next()) {
			orderDetailVO = new OrderDetailVO();
			orderDetailVO.setOdno(rs.getString("odno"));
			orderDetailVO.setOrderno(rs.getString("orderno"));
			orderDetailVO.setMenuListno(rs.getString("menuListno"));
			orderDetailVO.setAmount(rs.getInt("amount"));
			orderDetailVO.setUnitPrice(rs.getInt("unitPrice"));
			set.add(orderDetailVO);
		}
		}catch (SQLException se) {
			new RuntimeException("A database error occured" + se.getMessage());
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
		return set;
	}

}
