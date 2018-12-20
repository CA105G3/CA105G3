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
			"INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?,?)";
	private static final String DELETE = 
			"DELETE FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ONE_STMT =
			"SELECT * FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ALL_STMT =
			"SELECT * FROM MEDICALORDER";
	private static final String UPDATE = 
			"UPDATE MEDICALORDER SET MEMNO=? ,DRNO=? ,MOSTATUS=? ,MOCOST=? , MOTIME=? , MOTEXT=? ,MOVIDEO=? ,MOINTRO=? WHERE MONO=? ";
	
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
			pstmt.setString(6, medicalOrderVO.getMoIntro());
			pstmt.setBytes(7, medicalOrderVO.getMoVideo());
			pstmt.setString(8, medicalOrderVO.getMoText());
			
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
			pstmt.setString(6, medicalOrderVO.getMoText());
			pstmt.setBytes(7, medicalOrderVO.getMoVideo());
			pstmt.setString(8, medicalOrderVO.getMoIntro());
			pstmt.setString(9, medicalOrderVO.getMoNo());
			
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
				medicalOrderVO.setMoText(rs.getString("moText"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));
				
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
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));				
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
}
