package com.foodorder.model;

import java.sql.*;
import java.util.*;

import com.orderdetail.model.OrderDetailVO;



public class FoodOrderJDBCDAO implements FoodOrderDAO_Interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String psw = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO FOODORDER(ORDERNO, MEMNO, DELIVERADDR, CHEFNO, ORDERSTATUS, ORDTIME)"
			+ "VALUES(to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),?,?,?,?,current_timestamp)";
	private static final String GET_ALL_STMT = "SELECT * FROM FOODORDER ORDER BY ORDERNO";
	private static final String GET_ONE_STMT = "SELECT * FROM FOODORDER WHERE ORDERNO = ?";
	private static final String GET_OrderDetails_ByOrder_STMT = "SELECT * FROM ORDERDETAIL WHERE ORDERNO = ? ORDER BY ODNO";
	
	private static final String DELETE = "DELETE FROM FOODORDER WHERE ORDERNO = ?";
	private static final String UPDATE = 
			"UPDATE FOODORDER SET ORDERNO=?, MEMNO=?, DELIVERADDR=?, CHEFNO=?, ORDERSTATUS=?, ORDTIME=? WHERE ORDERNO=?";
	
	public void insert(FoodOrderVO foodOrderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, foodOrderVO.getMemno());
			pstmt.setString(2, foodOrderVO.getDeliverAddr());
			pstmt.setString(3, foodOrderVO.getChefno());
			pstmt.setString(4, foodOrderVO.getOrderStatus());
//			pstmt.setTimestamp(5, foodOrderVO.getOrdTime());
			
			pstmt.executeUpdate();
		}catch(ClassNotFoundException e) {
			throw new RuntimeException("Could't load database driver" + e.getMessage());
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
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

	public void delete(String orderno) { 

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, orderno);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load databse driver" + e.getMessage());
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
	
	public FoodOrderVO findByPrimaryKey(String orderno) {
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
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
				foodOrderVO.setOrdTime(rs.getTimestamp("ordTime"));				
			}
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" + e.getMessage());
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
		return foodOrderVO;
	}

	public List<FoodOrderVO> getAll(){
		List<FoodOrderVO> list = new ArrayList<FoodOrderVO>();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,userid, psw);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getTimestamp("ordTime"));
				list.add(foodOrderVO);
			}
		}catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" + e.getMessage());
		}catch (SQLException se) {
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
			return list;
	}

	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
		Set<OrderDetailVO> set = new LinkedHashSet<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(GET_OrderDetails_ByOrder_STMT);
			pstmt.setString(1, orderno);
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
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
	
	public static void main(String args[]) {
		FoodOrderJDBCDAO dao = new FoodOrderJDBCDAO();
		
//		//INSERT
//		FoodOrderVO foodOrderVO1 = new FoodOrderVO();
//		foodOrderVO1.setMemno("M0002");
//		foodOrderVO1.setDeliverAddr("中央大學中央路256號");
//		foodOrderVO1.setChefno("CHEF0001");
//		foodOrderVO1.setOrderStatus("接受");
//		dao.insert(foodOrderVO1);
		
//		//DELETE
//		dao.delete("20181212-0004");
		
//		//SELECT ONE
//		FoodOrderVO foodOrderVO2 = dao.findByPrimaryKey("20181210-0001");
//		System.out.println(foodOrderVO2.getMemno()+",");
//		System.out.println(foodOrderVO2.getDeliverAddr()+",");
//		System.out.println(foodOrderVO2.getChefno()+",");
//		System.out.println(foodOrderVO2.getOrderStatus()+",");
//		System.out.println(foodOrderVO2.getOrdTime());
		
//		//SELECT ALL
//		List<FoodOrderVO> list = dao.getAll();
//		for(FoodOrderVO aFoodOrder : list) {
//			System.out.println(aFoodOrder.getOrderno() + ",");
//			System.out.println(aFoodOrder.getMemno() + ",");
//			System.out.println(aFoodOrder.getDeliverAddr() + ",");
//			System.out.println(aFoodOrder.getChefno() + ",");
//			System.out.println(aFoodOrder.getOrderStatus() + ",");
//			System.out.println(aFoodOrder.getOrdTime());
//			System.out.println();
		
		//GET ORDER DETAILS BY FOOD ORDER
		Set<OrderDetailVO> set = dao.getOrderDetailsByFoodOrder("20181212-0005");
		for (OrderDetailVO orderDetailVO : set) {
			System.out.println(orderDetailVO.getOdno());
			System.out.println(orderDetailVO.getOrderno());
			System.out.println(orderDetailVO.getMenuListno());
			System.out.println(orderDetailVO.getAmount());
			System.out.println(orderDetailVO.getUnitPrice());
			System.out.println();
			System.out.println("資料取得成功");
		}
	}

}
