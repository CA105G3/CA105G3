package com.reportdr.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.administrator.model.AdministratorVO;
import com.favdr.model.FavDrJDBCDAO;
import com.favdr.model.FavDrVO;

public class ReportDrJDBCDAO implements ReportDr_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "CA105G3";
	String password = "123456";

	private static final String INSERT_STMT = 
			"INSERT INTO reportdr VALUES ('RDR'||lpad(to_char(reportdr_seq.NEXTVAL), 4, '0'),?,?,?,current_timestamp,?)";
	private static final String GET_ALL_STMT = 
			"SELECT RDrNo, MEmNo, DrNo, RDRReason, RDRTime, RDRState FROM REPORTDR";
	private static final String GET_ONE_STMT = 
			"SELECT RDrNo, MEmNo, DrNo, RDRReason, RDRTime, RDRState FROM REPORTDR WHERE RDrNo = ?";
	private static final String DELETE = 
			"DELETE FROM REPORTDR where RDRNO = ? ";
	private static final String UPDATE_RDRREASON_RDRSTATE = 
			"UPDATE REPORTDR SET RDRREASON = ?, RDRSTATE = ? WHERE RDRNO = ?";
	private static final String UPDATE_RDRREASON = 
			"UPDATE REPORTDR SET RDRREASON = ? WHERE RDRNO = ? ";
	private static final String UPDATE_RDRSTATE = 
			"UPDATE REPORTDR SET RDRSTATE = ? WHERE RDRNO = ? ";
	
	@Override
 	public void insert(ReportDrVO reportDrVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, reportDrVO.getMemNo());
			pstmt.setString(2, reportDrVO.getDrNo());
			pstmt.setString(3, reportDrVO.getRdrReason());
			pstmt.setString(4, reportDrVO.getRdrState());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database err occured." + e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		
	}

	@Override
	public void update_rdrReason_rdrState(ReportDrVO reportDrVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_RDRREASON_RDRSTATE);
			
			pstmt.setString(1, reportDrVO.getRdrReason());
			pstmt.setString(2, reportDrVO.getRdrState());
			pstmt.setString(3, reportDrVO.getRdrNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Cloudn't load database driver" + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	
	@Override
	public void update_rdrReason(ReportDrVO reportDrVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_RDRSTATE);
			
			pstmt.setString(1, reportDrVO.getRdrState());
			pstmt.setString(2, reportDrVO.getRdrNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database err occured." + e.getMessage());
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
	public void update_rdrState(ReportDrVO reportDrVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_RDRSTATE);
			
			pstmt.setString(1, reportDrVO.getRdrState());
			pstmt.setString(2, reportDrVO.getRdrNo());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't loda database driver" + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database err occurd." + e.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		
	}
			

	@Override
	public void delete(String rdrNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, rdrNo);		
			pstmt.executeUpdate();
			
		}catch (ClassNotFoundException e){
			throw new RuntimeException("Couldn't load database driver." + e.getMessage());
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public ReportDrVO findByPrimaryKey(String rdrNo) {
		ReportDrVO reportDrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, rdrNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reportDrVO = new ReportDrVO();
				reportDrVO.setRdrNo(rs.getString("rdrNo"));
				reportDrVO.setMemNo(rs.getString("memNo"));
				reportDrVO.setDrNo(rs.getString("drNo"));
				reportDrVO.setRdrReason(rs.getString("rdrReason"));
				reportDrVO.setRdrTime(rs.getDate("rdrTime"));
				reportDrVO.setRdrState(rs.getString("rdrState"));
			}
							
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
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
			
		return reportDrVO;
	}

	@Override
	public List<ReportDrVO> getAll() {
		
		List<ReportDrVO> list = new ArrayList<ReportDrVO>();
		ReportDrVO reportDrVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
						
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reportDrVO = new ReportDrVO();
				reportDrVO.setRdrNo(rs.getString("rdrNo"));
				reportDrVO.setMemNo(rs.getString("memNo"));
				reportDrVO.setDrNo(rs.getString("drNo"));
				reportDrVO.setRdrReason(rs.getString("rdrReason"));
				reportDrVO.setRdrTime(rs.getDate("rdrTime"));
				reportDrVO.setRdrState(rs.getString("rdrState"));
				
				list.add(reportDrVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
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
		
		return list;
	}

	public static void main(String[] arg) {
	
		ReportDrJDBCDAO dao = new ReportDrJDBCDAO();

		//修改rdrState 
//		ReportDrVO reportDrVO5 = new ReportDrVO();
//		reportDrVO5.setRdrState("已處理");
//		reportDrVO5.setRdrNo("RDR0004");
//		dao.update_rdrReason(reportDrVO5);
		
		//修改rdrReason
//		ReportDrVO reportDrVO4 = new ReportDrVO();
//		reportDrVO4.setRdrReason("語焉不詳");
//		reportDrVO4.setRdrNo("RDR0003");
//		dao.update_rdrReason(reportDrVO4);
		
		//修改rdrReason&rdrState
//		ReportDrVO reportDrVO3 = new ReportDrVO();
//		reportDrVO3.setRdrReason("隨便寫寫");
//		reportDrVO3.setRdrState("未處理");
//		reportDrVO3.setRdrNo("RDR0004");
//		dao.update_rdrReason_rdrState(reportDrVO3);
		
		//新增
//		ReportDrVO reportDrVO2 = new ReportDrVO();
//		reportDrVO2.setMemNo("M0005");
//		reportDrVO2.setDrNo("D0002");
//		reportDrVO2.setRdrReason("履歷表亂填寫");
//		reportDrVO2.setRdrState("未處理");
//		dao.insert(reportDrVO2);
		
		//刪除
//		dao.delete("RDR0005");
		
		
		//查單筆
//		ReportDrVO reportDrVO1 = new ReportDrVO();
//		reportDrVO1 = dao.findByPrimaryKey("RDR0002");
//		System.out.print(reportDrVO1.getRdrNo() + ",");
//		System.out.print(reportDrVO1.getMemNo() + ",");
//		System.out.print(reportDrVO1.getDrNo() + ",");
//		System.out.print(reportDrVO1.getRdrReason() + ",");
//		System.out.print(reportDrVO1.getRdrTime() + ",");
//		System.out.print(reportDrVO1.getRdrState());

		
		//查全部
//		List<ReportDrVO> list2 = dao.getAll();
//		for(ReportDrVO reportDrVO : list2) {
//			System.out.print(reportDrVO.getRdrNo() + "," );
//			System.out.print(reportDrVO.getMemNo() + "," );
//			System.out.print(reportDrVO.getDrNo() + ",");
//			System.out.print(reportDrVO.getRdrReason() + ",");
//			System.out.print(reportDrVO.getRdrTime() + ",");
//			System.out.print(reportDrVO.getRdrState());
//			System.out.println();
//		}
		
	}
	
	
	

}
