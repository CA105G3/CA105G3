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
	String user = "ca105g3";
	String password = "ca105g3";

//	private static final String INSERT_STMT = 
//			"INSERT INTO Administrator (adminno,priority,status,reg) VALUES ('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT RDrNo, MEmNo, DrNo, RDRReason, RDRTime, RDRState FROM REPORTDR";
	private static final String GET_ONE_STMT = 
			"SELECT RDrNo, MEmNo, DrNo, RDRReason, RDRTime, RDRState FROM REPORTDR WHERE RDrNo = ?";
//	private static final String DELETE = 
//			"DELETE FROM Administrator where adminno = ? ";
//	private static final String UPDATE_PRIORITY_STATUS = 
//			"UPDATE Administrator set priority = ?, status = ? where adminno = ?";
//	private static final String UPDATE_PRIORITY =
//			"UPDATE Administrator set priority = ? where adminno = ?";
//	private static final String UPDATE_STATUS =
//			"UPDATE Administrator set status = ? where adminno = ?";
	
	
	@Override
	public void insert(ReportDrVO reportDrVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(ReportDrVO reportDrVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(ReportDrVO reportDrVO) {
		// TODO Auto-generated method stub
		
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

		//查單筆
		ReportDrVO reportDrVO1 = new ReportDrVO();
		reportDrVO1 = dao.findByPrimaryKey("RDR0002");
		System.out.print(reportDrVO1.getRdrNo() + ",");
		System.out.print(reportDrVO1.getMemNo() + ",");
		System.out.print(reportDrVO1.getDrNo() + ",");
		System.out.print(reportDrVO1.getRdrReason() + ",");
		System.out.print(reportDrVO1.getRdrTime() + ",");
		System.out.print(reportDrVO1.getRdrState());

		
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
