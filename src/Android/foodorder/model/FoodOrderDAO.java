package Android.foodorder.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;




public class FoodOrderDAO implements FoodOrderDAO_Interface{
	private static DataSource ds = null;
	
	static {
		Context ctx;
		try {
			ctx = new InitialContext();
			ds=(DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
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
	private static final String GET_OrderDetails_ByOrder_STMT = "SELECT * FROM ORDERDETAIL WHERE ORDERNO = ? ORDER BY ODNO";
	private static final String GET_ALL_OrderMemno_STMT = "SELECT DISTINCT MEMNO FROM FOODORDER WHERE CHEFNO='CHEF0001' order by memno";
	private static final String GET_OrderByMemno_STMT = "SELECT * FROM FOODORDER WHERE MEMNO=?";
	
	private static final String DELETE = "DELETE FROM FOODORDER WHERE ORDERNO = ?";
	private static final String UPDATE = 
			"UPDATE FOODORDER SET ORDERNO=?, MEMNO=?, DELIVERADDR=?, CHEFNO=?, ORDERSTATUS=?, ORDTIME=? WHERE ORDERNO=?";
	
	
	
	
	
	
	
	
	
	
	@Override
	public Boolean insertWithOrderDetail(FoodOrderVO foodOrderVO, List<OrderDetailVO> list) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con=ds.getConnection();
			
			// 1●設定於 pstm.executeUpdate()之前
    		con.setAutoCommit(false);
			
    		// 先新增部門
			String cols[] = {"ORDERNO"};
			pstmt = con.prepareStatement(INSERT_STMT , cols);			
			pstmt.setString(1, foodOrderVO.getMemno());
			pstmt.setString(2, foodOrderVO.getDeliverAddr());
			pstmt.setString(3, foodOrderVO.getChefno());
			pstmt.setString(4, foodOrderVO.getOrderStatus());
			pstmt.setDate(5, foodOrderVO.getOrdTime());
			pstmt.executeUpdate();
			
			//掘取對應的自增主鍵值
			String next_orderno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_orderno = rs.getString(1);
				System.out.println("自增主鍵值= " + next_orderno +"(剛新增成功的部門編號)");
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			// 再同時新增員工
			OrderDetailDAO_Interface dao = new OrderDetailJDBCDAO();
			System.out.println("list.size()-A="+list.size());
			for (OrderDetailVO orderDetailVO : list) {
				orderDetailVO.setOrderno(next_orderno) ;
				dao.insert2(orderDetailVO,con);
			}

			// 2●設定於 pstm.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
			System.out.println("list.size()-B="+list.size());
			System.out.println("新增訂單編號" + next_orderno + "時,共有訂單明細" + list.size()
					+ "筆同時被新增");
			
			// Handle any driver errors
		
		} catch (SQLException se) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-FoodOrderDAO");
					con.rollback();
					return false;
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "+ se.getMessage());
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
		return true;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public void insert(FoodOrderVO foodOrderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, foodOrderVO.getMemno());
			pstmt.setString(2, foodOrderVO.getDeliverAddr());
			pstmt.setString(3, foodOrderVO.getChefno());
			pstmt.setString(4, foodOrderVO.getOrderStatus());
			pstmt.setDate(5, foodOrderVO.getOrdTime());
			
			pstmt.executeUpdate();
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

	public FoodOrderVO findByPrimaryKey(String orderno) {
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
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
		List<FoodOrderVO> list1 = new ArrayList<FoodOrderVO>();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
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
	
	public List<String> getAllOrderMemno(){
		List<String> list2 = new ArrayList<>();
		
//		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_OrderMemno_STMT); 
			rs = pstmt.executeQuery();            
			while (rs.next()) {                   
//				foodOrderVO = new FoodOrderVO();  			                        
//				foodOrderVO.setMemno(rs.getString("memno"));
//				list2.add(foodOrderVO.getMemno());
				
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
		List<FoodOrderVO> list3 = new ArrayList<>();
		FoodOrderVO foodOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_OrderByMemno_STMT);
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
				list3.add(foodOrderVO);
			}
		}  catch(SQLException se) {
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

//	public Set<OrderDetailVO> getOrderDetailsByFoodOrder(String orderno){
//		Set<OrderDetailVO> set = new LinkedHashSet<OrderDetailVO>();
//		OrderDetailVO orderDetailVO = null;
//		
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//	
//		try {
//	
//			Class.forName(driver);
//			con = DriverManager.getConnection(url, userid, psw);
//			pstmt = con.prepareStatement(GET_OrderDetails_ByOrder_STMT);
//			pstmt.setString(1, orderno);
//			rs = pstmt.executeQuery();
//		
//			while(rs.next()) {
//				orderDetailVO = new OrderDetailVO();
//				orderDetailVO.setOdno(rs.getString("odno"));
//				orderDetailVO.setOrderno(rs.getString("orderno"));
//				orderDetailVO.setMenuListno(rs.getString("menuListno"));
//				orderDetailVO.setAmount(rs.getInt("amount"));
//				orderDetailVO.setUnitPrice(rs.getInt("unitPrice"));
//				set.add(orderDetailVO);
//			}
//		} catch(ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
//		} catch (SQLException se) {
//			throw new RuntimeException("A database error occured. "
//					+ se.getMessage());
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return set;
//	}
	
	public static void main(String args[]) {
		FoodOrderJDBCDAO dao = new FoodOrderJDBCDAO();
		
//		//INSERT
		FoodOrderVO foodOrderVO1 = new FoodOrderVO();
		foodOrderVO1.setMemno("M0002");
		foodOrderVO1.setDeliverAddr("1111111111");
		foodOrderVO1.setChefno("CHEF0001");
		foodOrderVO1.setOrderStatus("接受");
		Date date = Date.valueOf("1999-06-04");
		foodOrderVO1.setOrdTime(date);
		dao.insert(foodOrderVO1);
		
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
//		List<FoodOrderVO> list1 = dao.getAll();
//		for(FoodOrderVO aFoodOrder : list1) {
//			System.out.println(aFoodOrder.getOrderno() + ",");
//			System.out.println(aFoodOrder.getMemno() + ",");
//			System.out.println(aFoodOrder.getDeliverAddr() + ",");
//			System.out.println(aFoodOrder.getChefno() + ",");
//			System.out.println(aFoodOrder.getOrderStatus() + ",");
//			System.out.println(aFoodOrder.getOrdTime());
//			System.out.println();
		
//		//GET MEMBER NUMBERS FROM FOODORDER TABLE
//		List<String> list2 = dao.getAllOrderMemno();
//		for (String FoodOrder : list2) {
//			System.out.println(FoodOrder);
//		}
		
		//GET ORDERS BY MEMBER NUMBER
		List<FoodOrderVO> list3 = dao.findByMemno("M0001");
		for (FoodOrderVO FoodOrder : list3) {
		System.out.println(FoodOrder.getOrderno() + ",");
		System.out.println(FoodOrder.getMemno() + ",");
		System.out.println(FoodOrder.getDeliverAddr() + ",");
		System.out.println(FoodOrder.getChefno() + ",");
		System.out.println(FoodOrder.getOrderStatus() + ",");
		System.out.println(FoodOrder.getOrdTime() + ",");
		System.out.println("========================");
		}
		
//		//GET ORDER DETAILS BY FOOD ORDER
//		Set<OrderDetailVO> set = dao.getOrderDetailsByFoodOrder("20181212-0005");
//		for (OrderDetailVO orderDetailVO : set) {
//			System.out.println(orderDetailVO.getOdno());
//			System.out.println(orderDetailVO.getOrderno());
//			System.out.println(orderDetailVO.getMenuListno());
//			System.out.println(orderDetailVO.getAmount());
//			System.out.println(orderDetailVO.getUnitPrice());
//			System.out.println();
//			System.out.println("鞈������");
//		}
	}






}
