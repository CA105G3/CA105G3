package com.reportdr.model;

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

public class ReportDrDAO implements ReportDr_interface{

	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookupLink("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			e.printStackTrace();
		}		
	}
	
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
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, reportDrVO.getMemNo());
			pstmt.setString(2, reportDrVO.getDrNo());
			pstmt.setString(3, reportDrVO.getRdrReason());
			pstmt.setString(4, reportDrVO.getRdrState());
			
			pstmt.executeUpdate();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_RDRREASON_RDRSTATE);
			
			pstmt.setString(1, reportDrVO.getRdrReason());
			pstmt.setString(2, reportDrVO.getRdrState());
			pstmt.setString(3, reportDrVO.getRdrNo());
			
			pstmt.executeUpdate();
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_RDRREASON);
			
			pstmt.setString(1, reportDrVO.getRdrState());
			pstmt.setString(2, reportDrVO.getRdrNo());
			
			pstmt.executeUpdate();
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_RDRSTATE);
			
			pstmt.setString(1, reportDrVO.getRdrState());
			pstmt.setString(2, reportDrVO.getRdrNo());
			
			pstmt.executeUpdate();
			
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, rdrNo);		
			pstmt.executeUpdate();
			
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
			con = ds.getConnection();
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
							
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
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
						
			con = ds.getConnection();
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
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
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
