package com.foodorder.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import com.foodorder.model.FoodOrderVO;
import com.orderdetail.model.OrderDetailVO;
import com.orderdetail.model.OrderDetailJDBCDAO;

public class FoodOrderJDBCDAO implements FoodOrderDAO_Interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String psw = "123456";
	
	private static final String INSERT_STMT =
			"INSERT INTO FOODORDER(ORDERNO, MEMNO, DELIVERADDR, CHEFNO, ORDERSTATUS, ORDTIME)"
			+ "VALUES(to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),?,?,?,?,?)";
	private static final String INSERT_STMT2 =
			"INSERT INTO FOODORDER(ORDERNO, MEMNO, DELIVERADDR, CHEFNO, ORDERSTATUS, ORDTIME)"
			+ "VALUES(to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(foodorder_seq.NEXTVAL), 4, '0'),?,?,?,?,to_date(current_date))";
	
	private static final String UPDATE_ORDERSTATUS_STMT ="UPDATE FOODORDER SET ORDERSTATUS= ? WHERE ORDERNO= ?";
	private static final String GET_BY_ORDERNO_STMT = "SELECT * FROM FOODORDER WHERE ORDERNO = ?"; 
	private static final String GET_BY_MEMNO_STMT = "SELECT * FROM FOODORDER WHERE MEMNO=? ORDER BY ORDERNO";
	private static final String GET_BY_MEMID_STMT = "SELECT * FROM FOODORDER LEFT JOIN MEMBER ON FOODORDER.MEMNO=MEMBER.MEMNO WHERE MEMID=?";
	private static final String GET_BY_EMAIL_STMT = "SELECT * FROM FOODORDER LEFT JOIN MEMBER ON FOODORDER.MEMNO=MEMBER.MEMNO WHERE EMAIL=?";
	
	private static final String GET_OrderDetails_ByOrder_STMT = "SELECT * FROM ORDERDETAIL WHERE ORDERNO = ? ORDER BY ODNO";
	private static final String GET_OrderDetails_ByOrder_STMT2 = "SELECT * FROM ORDERDETAIL LEFT JOIN MENULIST ON ORDERDETAIL.MENULISTNO = MENULIST.MENULISTNO "
			+ "LEFT JOIN MENU ON MENULIST.MENUNO = MENU.MENUNO WHERE ORDERNO = ? ORDER BY ODNO";
	
	private static final String GET_ALL_STMT = "SELECT * FROM FOODORDER ORDER BY ORDERNO";
	
	
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
			pstmt.setDate(5, foodOrderVO.getOrdTime());
			
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

	public void insertWithOrderDetails(FoodOrderVO foodOrderVO, List<OrderDetailVO> list) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			
			con.setAutoCommit(false);
			
			String cols[] = {"ORDERNO"};
			pstmt = con.prepareStatement(INSERT_STMT2, cols);
			pstmt.setString(1, foodOrderVO.getMemno());
			pstmt.setString(2, foodOrderVO.getDeliverAddr());
			pstmt.setString(3, foodOrderVO.getChefno());
			pstmt.setString(4, foodOrderVO.getOrderStatus());
			pstmt.executeUpdate();
			
			String next_orderno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_orderno = rs.getString(1);
				System.out.println("自增主鍵值 = " + next_orderno + "(剛新增成功的訂單編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			OrderDetailJDBCDAO dao = new OrderDetailJDBCDAO();
			System.out.println("list.size()-A=" + list.size());
			for (OrderDetailVO anOrderDetail : list) {
				anOrderDetail.setOrderno(new String(next_orderno));
				dao.insert2(anOrderDetail, con);
			}
			con.commit();
			con.setAutoCommit(true);
			System.out.println("list.size()-B=" + list.size());
			System.out.println("新增部門編號" + next_orderno + "時,共有" + list.size() + "筆訂單明細同時被新增");
			
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Could't load database driver" + e.getMessage());
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.print("Transaction is being ");
					System.err.println("rolled back by foodorder");
					con.rollback();
				} catch (SQLException excep) {
			throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			} 
			throw new RuntimeException("Adatabase error occured. " +se.getMessage());
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
	
	public void update_OrderStatus(FoodOrderVO foodOrderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(UPDATE_ORDERSTATUS_STMT);

			pstmt.setString(1, foodOrderVO.getOrderStatus());
			pstmt.setString(2, foodOrderVO.getOrderno());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
	
	public FoodOrderVO findBy_Orderno(String orderno) {
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(GET_BY_ORDERNO_STMT);
			
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

	public List<FoodOrderVO> findBy_Memno(String memno){
		List<FoodOrderVO> list = new ArrayList();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(GET_BY_MEMNO_STMT);
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));	
				list.add(foodOrderVO);
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
		return list;
	}

	public List<FoodOrderVO> findBy_MemId(String memId){
		List<FoodOrderVO> list = new ArrayList();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(GET_BY_MEMID_STMT);
			pstmt.setString(1, memId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));	
				list.add(foodOrderVO);
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
		return list;
	}

	public List<FoodOrderVO> findBy_Email(String email){
		List<FoodOrderVO> list = new ArrayList();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, psw);
			pstmt = con.prepareStatement(GET_BY_EMAIL_STMT);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				foodOrderVO = new FoodOrderVO();
				foodOrderVO.setOrderno(rs.getString("orderno"));
				foodOrderVO.setMemno(rs.getString("memno"));
				foodOrderVO.setDeliverAddr(rs.getString("deliverAddr"));
				foodOrderVO.setChefno(rs.getString("chefno"));
				foodOrderVO.setOrderStatus(rs.getString("orderStatus"));
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));	
				list.add(foodOrderVO);
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
			pstmt = con.prepareStatement(GET_OrderDetails_ByOrder_STMT2);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				orderDetailVO = new OrderDetailVO();
				orderDetailVO.setOdno(rs.getString("odno"));
				orderDetailVO.setOrderno(rs.getString("orderno"));
				orderDetailVO.setMainCourse(rs.getString("mainCourse"));
				orderDetailVO.setMenuDate(rs.getDate("menuDate"));
				orderDetailVO.setMenuTimeSlot(rs.getString("menuTimeSlot"));
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
	
	public List<FoodOrderVO> getAll(){
		List<FoodOrderVO> list1 = new ArrayList<FoodOrderVO>();
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
				foodOrderVO.setOrdTime(rs.getDate("ordTime"));
				list1.add(foodOrderVO);
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
			return list1;
	}
	
	public static void main(String args[]) {
		FoodOrderJDBCDAO dao = new FoodOrderJDBCDAO();
		
//		//INSERT
//		FoodOrderVO foodOrderVO1 = new FoodOrderVO();
//		foodOrderVO1.setMemno("M0004");
//		foodOrderVO1.setDeliverAddr("中央大學中央路256號");
//		foodOrderVO1.setChefno("CHEF0001");
//		foodOrderVO1.setOrderStatus("接受");
//		Date ordTime = Date.valueOf("2018-12-31");
//		foodOrderVO1.setOrdTime(ordTime);
//		dao.insert(foodOrderVO1);
//		System.out.println("訂單新增成功!");
		
//		//UPDATE ORDER STATUS
//		FoodOrderVO foodOrderVO = new FoodOrderVO();
//		foodOrderVO.setOrderStatus("不接受");
//		foodOrderVO.setOrderno("20181222-0019");
//		dao.update_OrderStatus(foodOrderVO);
//		System.out.println("訂單狀態更新成功!");
		
//		//SEARCH BY ORDERNO
//		FoodOrderVO foodOrderVO2 = dao.findBy_Orderno("20181222-0019");
//		System.out.println(foodOrderVO2.getMemno()+",");
//		System.out.println(foodOrderVO2.getDeliverAddr()+",");
//		System.out.println(foodOrderVO2.getChefno()+",");
//		System.out.println(foodOrderVO2.getOrderStatus()+",");
//		System.out.println(foodOrderVO2.getOrdTime());
		
//		//SEARCH ORDERS BY MEMNO
//		List<FoodOrderVO> list = dao.findBy_Memno("M0001");
//		for (FoodOrderVO FoodOrder : list) {
//		System.out.println(FoodOrder.getOrderno() + ",");
//		System.out.println(FoodOrder.getMemno() + ",");
//		System.out.println(FoodOrder.getDeliverAddr() + ",");
//		System.out.println(FoodOrder.getChefno() + ",");
//		System.out.println(FoodOrder.getOrderStatus() + ",");
//		System.out.println(FoodOrder.getOrdTime() + ",");
//		System.out.println("========================");
//		}
		
//		//SEARCH ORDERS BY MEMID
//		List<FoodOrderVO> list = dao.findBy_MemId("David");
//		for (FoodOrderVO FoodOrder : list) {
//		System.out.println(FoodOrder.getOrderno() + ",");
//		System.out.println(FoodOrder.getMemno() + ",");
//		System.out.println(FoodOrder.getDeliverAddr() + ",");
//		System.out.println(FoodOrder.getChefno() + ",");
//		System.out.println(FoodOrder.getOrderStatus() + ",");
//		System.out.println(FoodOrder.getOrdTime() + ",");
//		System.out.println("========================");
//		}
		
//		//SEARCH ORDERS BY EMAIL
//		List<FoodOrderVO> list = dao.findBy_Email("mary001@gmail.com");
//		for (FoodOrderVO FoodOrder : list) {
//		System.out.println(FoodOrder.getOrderno() + ",");
//		System.out.println(FoodOrder.getMemno() + ",");
//		System.out.println(FoodOrder.getDeliverAddr() + ",");
//		System.out.println(FoodOrder.getChefno() + ",");
//		System.out.println(FoodOrder.getOrderStatus() + ",");
//		System.out.println(FoodOrder.getOrdTime() + ",");
//		System.out.println("========================");
//		}
			
//		//GET ORDER DETAILS BY FOOD ORDER
		Set<OrderDetailVO> set = dao.getOrderDetailsByFoodOrder("20190118-0001");
		for (OrderDetailVO orderDetailVO : set) {
			System.out.println(orderDetailVO.getOdno());
			System.out.println(orderDetailVO.getOrderno());
			System.out.println(orderDetailVO.getMainCourse());
			System.out.println(orderDetailVO.getMenuDate());
			System.out.println(orderDetailVO.getMenuTimeSlot());
			System.out.println(orderDetailVO.getAmount());
			System.out.println(orderDetailVO.getUnitPrice());
			System.out.println();
			System.out.println("資料取得成功");
		}
		
//		//SELECT ALL
//		List<FoodOrderVO> list1 = dao.getAll();
//		for(FoodOrderVO aFoodOrder : list1) {
//			System.out.println(aFoodOrder.getOrderno() + ",");
//			System.out.println(aFoodOrder.getMemno() + ",");
//			System.out.println(aFoodOrder.getDeliverAddr() + ",");
//			System.out.println(aFoodOrder.getChefno() + ",");
//			System.out.println(aFoodOrder.getOrderStatus() + ",");
//			System.out.println(aFoodOrder.getOrdTime());
//			System.out.println();	
	
	}

}
