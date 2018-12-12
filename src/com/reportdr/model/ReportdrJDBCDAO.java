package com.reportdr.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.administrator.model.AdministratorVO;
import com.favdr.model.FavdrJDBCDAO;
import com.favdr.model.FavdrVO;

public class ReportdrJDBCDAO implements Reportdr_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "ca105g3";
	String password = "ca105g3";

//	private static final String INSERT_STMT = 
//			"INSERT INTO Administrator (adminno,priority,status,reg) VALUES ('A'||lpad(to_char(administrator_seq.NEXTVAL), 4, '0'), ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT RDRNO, MEMNO, DRNO, RDRREASON, RDRTIME, RDRSTATE FROM REPORTDR";
	private static final String GET_ONE_STMT = 
			"SELECT RDRNO, MEMNO, DRNO, RDRREASON, RDRTIME, RDRSTATE FROM REPORTDR WHERE RDRNO = ?";
//	private static final String DELETE = 
//			"DELETE FROM Administrator where adminno = ? ";
//	private static final String UPDATE_PRIORITY_STATUS = 
//			"UPDATE Administrator set priority = ?, status = ? where adminno = ?";
//	private static final String UPDATE_PRIORITY =
//			"UPDATE Administrator set priority = ? where adminno = ?";
//	private static final String UPDATE_STATUS =
//			"UPDATE Administrator set status = ? where adminno = ?";
	
	
	@Override
	public void insert(ReportdrVO reportdrVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(ReportdrVO reportdrVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(ReportdrVO reportdrVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ReportdrVO findByPrimaryKey(String rdrno) {
		ReportdrVO reportdrVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, rdrno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reportdrVO = new ReportdrVO();
				reportdrVO.setRdrno(rs.getString("rdrno"));
				reportdrVO.setMemno(rs.getString("memno"));
				reportdrVO.setDrno(rs.getString("drno"));
				reportdrVO.setRdrreason(rs.getString("rdrreason"));
				reportdrVO.setRdrtime(rs.getDate("rdrtime"));
				reportdrVO.setRdrstate(rs.getString("rdrstate"));
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
			
		return reportdrVO;
	}

	@Override
	public List<ReportdrVO> getAll() {
		
		List<ReportdrVO> list = new ArrayList<ReportdrVO>();
		ReportdrVO reportdrVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
						
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reportdrVO = new ReportdrVO();
				reportdrVO.setRdrno(rs.getString("rdrno"));
				reportdrVO.setMemno(rs.getString("memno"));
				reportdrVO.setDrno(rs.getString("drno"));
				reportdrVO.setRdrreason(rs.getString("rdrreason"));
				reportdrVO.setRdrtime(rs.getDate("rdrtime"));
				reportdrVO.setRdrstate(rs.getString("rdrstate"));
				
				list.add(reportdrVO);
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
	
		ReportdrJDBCDAO dao = new ReportdrJDBCDAO();

		//查單筆
		ReportdrVO reportdrVO1 = new ReportdrVO();
		reportdrVO1 = dao.findByPrimaryKey("RDR0002");
		System.out.print(reportdrVO1.getRdrno() + ",");
		System.out.print(reportdrVO1.getMemno() + ",");
		System.out.print(reportdrVO1.getDrno() + ",");
		System.out.print(reportdrVO1.getRdrreason() + ",");
		System.out.print(reportdrVO1.getRdrtime() + ",");
		System.out.print(reportdrVO1.getRdrstate());

		
		//查全部
//		List<ReportdrVO> list2 = dao.getAll();
//		for(ReportdrVO reportdrVO : list2) {
//			System.out.print(reportdrVO.getRdrno() + "," );
//			System.out.print(reportdrVO.getMemno() + "," );
//			System.out.print(reportdrVO.getDrno() + ",");
//			System.out.print(reportdrVO.getRdrreason() + ",");
//			System.out.print(reportdrVO.getRdrtime() + ",");
//			System.out.print(reportdrVO.getRdrstate());
//			System.out.println();
//		}
		
	}
	
	
	

}
