package com.medicalorder.model;

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
import javax.sql.*;

public class MedicalOrderDAO implements MedicalOrder_interface{

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
			"INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?,?,?,?)";
	private static final String DELETE = 
			"DELETE FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ONE_STMT =
			"SELECT * FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ALL_STMT =
			"SELECT * FROM MEDICALORDER";
	private static final String UPDATE = 
			"UPDATE MEDICALORDER SET MEMNO=? ,DRNO= ? ,MOSTATUS=? ,MOCOST=? ,MOTIME=? , MoHour=? ,MOINTRO=?, MOCANCELREASON=? ,MOVIDEO=? ,MOTEXT=?  WHERE MONO=?";
	private static final String FIND_LIST_FOR_MEMBER = 
			"SELECT MONO, MEMNO, DRNO, MOSTATUS, MOCOST, MOTIME, MOHOUR, MOINTRO, MOCANCELREASON, MOVIDEO, MOTEXT FROM MEDICALORDER WHERE MEMNO = ?";
	private static final String UPDATE_CANCEL_FROM_MONO =
			"UPDATE MEDICALORDER SET MOSTATUS='取消問診',MOCANCELREASON = ? WHERE MONO = ?";
	
	
	//=======================================================================
	//醫生歷史看診紀錄
	private static final String GET_BY_DRNO = "SELECT* FROM MEDICALORDER WHERE DRNO=? AND MOSTATUS = '問診完成' ORDER BY MOTIME, MOHOUR, MONO";
	//醫生查詢預約
	private static final String GET_BY_DRNO_TODAY = "SELECT* FROM MEDICALORDER WHERE DRNO=? AND MOSTATUS = '等待問診' AND TO_CHAR(MOTIME, 'YYMMDD') = TO_CHAR(SYSDATE, 'YYMMDD') ORDER BY MOHOUR, MONO";
	private static final String GET_BY_DRNO_THISMONTH = "SELECT* FROM MEDICALORDER WHERE DRNO=? AND MOSTATUS = '等待問診' AND TO_CHAR(MOTIME, 'YYMMDD') >= TO_CHAR(SYSDATE, 'YYMMDD')  AND TO_CHAR(MOTIME, 'YYMM') = TO_CHAR(SYSDATE, 'YYMM') ORDER BY MOTIME, MOHOUR, MONO";
	private static final String GET_BY_DRNO_THISMONTH_DONE = "SELECT* FROM MEDICALORDER WHERE DRNO=? AND MOSTATUS = '問診完成' AND TO_CHAR(MOTIME, 'YYMMDD') <= TO_CHAR(SYSDATE, 'YYMMDD')  AND TO_CHAR(MOTIME, 'YYMM') = TO_CHAR(SYSDATE, 'YYMM') ORDER BY MOTIME, MOHOUR, MONO";
	private static final String GET_BY_DRNO_NEXTMONTH = "SELECT* FROM MEDICALORDER WHERE DRNO=? AND MOSTATUS = '等待問診' AND TO_CHAR(MOTIME, 'YYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, 1), 'YYMM') ORDER BY MOTIME, MOHOUR, MONO"; 
	private static final String GET_BY_DRNO_THISWEEK = "SELECT* FROM MEDICALORDER WHERE DRNO=? AND  MOSTATUS = '等待問診' AND TO_CHAR(MOTIME, 'YYMMDD') <= TO_CHAR(NEXT_DAY(SYSDATE, 7), 'YYMMDD') "
			+ "AND TO_CHAR(MOTIME, 'YYMMDD') >= TO_CHAR(SYSDATE, 'YYMMDD') ORDER BY MOTIME, MOHOUR, MONO";
	private static final String CANCEL_BY_DR = "UPDATE MEDICALORDER SET MOSTATUS=? WHERE MONO=?";
	//========================================================================		
	//問診結束後新增醫囑
		private static final String UPDATE_MOTEXT="UPDATE MEDICALORDER SET MOTEXT=? ,MOSTATUS = '問診完成'  WHERE MONO=?";
	
	
	@Override
	public void insert(MedicalOrderVO medicalOrderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, medicalOrderVO.getMemNo());
			pstmt.setString(2, medicalOrderVO.getDrNo());
			pstmt.setString(3, medicalOrderVO.getMoStatus());
			pstmt.setInt(4, medicalOrderVO.getMoCost());
			pstmt.setDate(5, medicalOrderVO.getMoTime());
			pstmt.setInt(6, medicalOrderVO.getMoHour());
			pstmt.setString(7, medicalOrderVO.getMoIntro());
			pstmt.setString(8, medicalOrderVO.getMoCancelReason());
			pstmt.setBytes(9, medicalOrderVO.getMoVideo());
			pstmt.setString(10, medicalOrderVO.getMoText());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
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
	public void delete(String moNo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
				
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, moNo);
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
	public void update(MedicalOrderVO medicalOrderVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, medicalOrderVO.getMemNo());
			pstmt.setString(2, medicalOrderVO.getDrNo());
			pstmt.setString(3, medicalOrderVO.getMoStatus());
			pstmt.setInt(4, medicalOrderVO.getMoCost());
			pstmt.setDate(5, medicalOrderVO.getMoTime());
			pstmt.setInt(6, medicalOrderVO.getMoHour());
			pstmt.setString(7, medicalOrderVO.getMoIntro());
			pstmt.setString(8, medicalOrderVO.getMoCancelReason());
			pstmt.setBytes(9, medicalOrderVO.getMoVideo());
			pstmt.setString(10, medicalOrderVO.getMoText());
			pstmt.setString(11, medicalOrderVO.getMoNo());
			
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
	public MedicalOrderVO findByPrimaryKey(String moNo) {
		
		MedicalOrderVO medicalOrderVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
				
			pstmt.setString(1, moNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));
				medicalOrderVO.setMoCancelReason("moCancelReason");
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));				
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return medicalOrderVO;
	}

	@Override
	public List<MedicalOrderVO> getAll() {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}	
	
	@Override
	public List<MedicalOrderVO> findListforMember(String memNo) {
		List<MedicalOrderVO> list = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_LIST_FOR_MEMBER);
			
			list = new ArrayList();
			pstmt.setString(1, memNo);
			rs = pstmt.executeQuery();
			

			while(rs.next()) {	
				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();	
				medicalOrderVO.setMoNo(rs.getString("MONO"));
				medicalOrderVO.setMemNo(rs.getString("MEMNO"));
				medicalOrderVO.setDrNo(rs.getString("DRNO"));
				medicalOrderVO.setMoStatus(rs.getString("MOSTATUS"));
				medicalOrderVO.setMoCost(rs.getInt("MOCOST"));
				medicalOrderVO.setMoTime(rs.getDate("MOTIME"));
				medicalOrderVO.setMoHour(rs.getInt("MOHOUR"));
				medicalOrderVO.setMoIntro(rs.getString("MOINTRO"));
				medicalOrderVO.setMoCancelReason(rs.getString("MOCANCELREASON"));
				medicalOrderVO.setMoVideo(rs.getBytes("MOVIDEO"));
				medicalOrderVO.setMoText(rs.getString("MOTEXT"));				
				list.add(medicalOrderVO);			
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		return list;
	}	
	
	@Override
	public void cancelMedicalOrder(MedicalOrderVO medicalOrderVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			
			pstmt = con.prepareStatement(UPDATE_CANCEL_FROM_MONO);
			
			pstmt.setString(1, medicalOrderVO.getMoCancelReason());
			pstmt.setString(2, medicalOrderVO.getMoNo());
	
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
	
	
	
	
	
//	==============================================================
	public List<MedicalOrderVO> getByDrno(String drno) {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_DRNO);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}
	
	public List<MedicalOrderVO> getByDrnoToday(String drno) {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_DRNO_TODAY);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}
	
	public List<MedicalOrderVO> getByDrnoThisMonth(String drno) {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_DRNO_THISMONTH);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}
	
public List<MedicalOrderVO> getByDrnoThisMonthDone(String drno) {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_DRNO_THISMONTH_DONE);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}
	
	public List<MedicalOrderVO> getByDrnoNextMonth(String drno) {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_DRNO_NEXTMONTH);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}

	public List<MedicalOrderVO> getByDrnoThisWeek(String drno) {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_BY_DRNO_THISWEEK);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMoNo(rs.getString("moNo"));
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoHour(rs.getInt("moHour"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				list.add(medicalOrderVO);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured." + e.getMessage());
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
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
		
		return list;
	}
	
	public void calcelByDr(MedicalOrderVO medicalOrderVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(CANCEL_BY_DR);
			pstmt.setString(1, medicalOrderVO.getMoStatus());
			pstmt.setString(2, medicalOrderVO.getMoNo());
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
//==================================================================

	@Override
	public void updatemotext(String mono, String motext) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_MOTEXT);
			pstmt.setString(1, motext);
			pstmt.setString(2, mono);
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
}
