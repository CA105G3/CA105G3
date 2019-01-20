package Android.foodorder.model;

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

public class OrderDetailDAO implements OrderDetailDAO_Interface{
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
			"INSERT INTO ORDERDETAIL (ODNO, ORDERNO, MENULISTNO, AMOUNT, UNITPRICE,ODSTATUS)"
			+ "VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(orderdetail_seq.NEXTVAL), 4, '0'), ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM ORDERDETAIL ORDER BY ODNO"; 
	private static final String FIND_IMG_BY_ISBN = "SELECT MENUPIC FROM MENU WHERE menuno = ?";
	private static final String UPDATE_STMT ="UPDATE ORDERDETAIL SET  amount = ?, odstatus = ? WHERE odno = ?";
	private static final String GET_ONE_STMT = "SELECT * FROM ORDERDETAIL WHERE ODNO=?";
	private static final String DELETE = "DELETE FROM ORDERDETAIL WHERE ODNO=?";
	private static final String GET_ALL_STMT_BY_ORDERNO = "SELECT * FROM ORDERDETAIL WHERE ORDERNO = ?";
	private static final String GET_ALL_DETAIL_BY_ORDERNO =""
			+ "select" + 
			"    od.ODNO as odno, " + 
			"    od.AMOUNT as amount, " + 
			"    od.UNITPRICE as unitPrice, " + 
			"    od.ODSTATUS as odStatus, " + 
			"    ml.MENUDATE as menuDate, " + 
			"    ml.MENUTIMESLOT as menutimeslot, " + 
			"    m.MENUNO as menuno, " + 
			"    m.MAINCOURSE as maincourse, " + 
			"    mbc.CHEFNO as chefno, " + 
			"    mbc.CHEFADDR as chefAddr, " + 
			"    mbc.CHEFREP as chefRep, " + 
			"    mbc.CHEFPHONE as chefphone, " + 
			"    mbc.CHEFDESCRIP as chefDescript " + 
			"from    orderdetail od " + 
			"    left join menulist ml " + 
			"    on  (od.menulistno = ml.menulistno) " + 
			"    left join menu m " + 
			"    on (ml.menuno = m.menuno) " + 
			"    left join memberchef mbc " + 
			"    on  (m.chefno = mbc.chefno) " + 
			"where od.orderno = ?";
	
	@Override
	public List<DetailInfo> getAllDetailByOrderno(String orderno) {
		List<DetailInfo> list = new ArrayList<DetailInfo>();
		DetailInfo detailInfo = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_DETAIL_BY_ORDERNO);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				detailInfo = new DetailInfo();
				detailInfo.setOdno(rs.getString("odno"));
				detailInfo.setAmount(rs.getInt("amount"));
				detailInfo.setUnitPrice(rs.getInt("unitPrice"));
				detailInfo.setOdStatus(rs.getString("odStatus"));
				detailInfo.setMenuDate(rs.getDate("menuDate"));
				detailInfo.setMenutimeslot(rs.getString("menutimeslot"));
				detailInfo.setMenuno(rs.getString("menuno"));
				detailInfo.setMaincourse(rs.getString("mainCourse"));
				detailInfo.setChefno(rs.getString("chefno"));
				detailInfo.setChefRep(rs.getString("chefrep"));
				detailInfo.setChefphone(rs.getInt("chefphone"));
				detailInfo.setChefDescript(rs.getString("chefDescript"));
				list.add(detailInfo);
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
	
	
	
	@Override
	public void insert2(OrderDetailVO orderDetailVO, Connection con) {
		PreparedStatement pstmt = null;

		try {

     		pstmt = con.prepareStatement(INSERT_STMT);

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
	
	
	
	
	
	
	
	
	
	
	@Override
	public boolean update(OrderDetailVO orderDetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean isUpdated = false;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setInt(1, orderDetailVO.getAmount());
			pstmt.setString(2, orderDetailVO.getOdStatus());
			pstmt.setString(3, orderDetailVO.getOdno());
			int count = pstmt.executeUpdate();
			isUpdated = count > 0 ? true : false;

			// Handle any driver errors
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
		return isUpdated;
	}
	
	
	public byte[] getImage(String isbn) {
		byte[] picture = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con=ds.getConnection();
			pstmt = con.prepareStatement(FIND_IMG_BY_ISBN);
			
			pstmt.setString(1, isbn);
			
			rs = pstmt.executeQuery();

			if (rs.next()) {
				picture = rs.getBytes(1);
			}
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
		return picture;
	}
	
	
	
	
	
	
	
	
	
	
	
	public void insert(OrderDetailVO orderDetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, orderDetailVO.getOrderno());
			pstmt.setString(2, orderDetailVO.getMenuListno());
			pstmt.setInt(3, orderDetailVO.getAmount());
			pstmt.setInt(4, orderDetailVO.getUnitPrice());
			pstmt.setString(5, orderDetailVO.getOdStatus());
			
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
			con=ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, odno);
			
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

	public OrderDetailVO findByPrimaryKey(String odno) {
		OrderDetailVO orderDetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
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
				orderDetailVO.setOdStatus(rs.getString("odStatus"));
			}
		}  catch (SQLException se) {
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
			con=ds.getConnection();
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
				orderDetailVO.setOdStatus(rs.getString("OdStatus"));
				list.add(orderDetailVO);
			}
		}  catch (SQLException se) {
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
	
	@Override
	public List<OrderDetailVO> getAllByOrderno(String orderno) {
		List<OrderDetailVO> list = new ArrayList<OrderDetailVO>();
		OrderDetailVO orderDetailVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT_BY_ORDERNO);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orderDetailVO = new OrderDetailVO();
				orderDetailVO.setOdno(rs.getString("odno"));
				orderDetailVO.setOrderno(rs.getString("orderno"));
				orderDetailVO.setMenuListno(rs.getString("menuListno"));
				orderDetailVO.setAmount(rs.getInt("amount"));
				orderDetailVO.setUnitPrice(rs.getInt("unitPrice"));
				orderDetailVO.setOdno(rs.getString("odno"));
				orderDetailVO.setOdStatus(rs.getString("odStatus"));
				list.add(orderDetailVO);
			}
		}  catch (SQLException se) {
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
		
		//INSERT
//		OrderDetailVO orderDetailVO1 = new OrderDetailVO();
//		orderDetailVO1.setOrderno("20181225-0001");
//		orderDetailVO1.setMenuListno("20181225-0001");
//		orderDetailVO1.setAmount(3);
//		orderDetailVO1.setUnitPrice(300);
//		orderDetailVO1.setOdStatus("取消");
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
		List<OrderDetailVO> list = dao.getAllByOrderno("20181225-0001");
		for (OrderDetailVO aOrderDetail : list) {
			System.out.print(aOrderDetail.getOdno() + ",");
			System.out.print(aOrderDetail.getOrderno() + ",");
			System.out.print(aOrderDetail.getMenuListno() + ",");
			System.out.print(aOrderDetail.getAmount() + ",");
			System.out.print(aOrderDetail.getUnitPrice());
			System.out.println(aOrderDetail.getOdStatus());
			System.out.println();
		}
	}







}
