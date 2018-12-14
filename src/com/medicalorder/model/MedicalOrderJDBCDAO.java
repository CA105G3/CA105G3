package com.medicalorder.model;

import java.sql.*;
import java.util.*;

public class MedicalOrderJDBCDAO implements MedicalOrder_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "ca105g3";
	String password = "ca105g3";
	
	private static final String INSERT_STMT = 
			"INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?,?)";
	private static final String DELETE = 
			"DELETE FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ONE_STMT =
			"SELECT MEMNO, DRNO, MOSTATUS, MOCOST, MOTIME, MOTEXT, MOVIDEO, MOINTRO FROM MEDICALORDER WHERE MEMNO = ?";
	private static final String GET_ALL_STMT =
			"SELECT * FROM MEDICALORDER";
	
	@Override
	public void insert(MedicalOrderVO medicalOrderVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, medicalOrderVO.getMemNo());
			pstmt.setString(2, medicalOrderVO.getDrNo());
			pstmt.setString(3, medicalOrderVO.getMoStatus());
			pstmt.setInt(4, medicalOrderVO.getMoCost());
			pstmt.setDate(5, medicalOrderVO.getMoTime());
			pstmt.setString(6, medicalOrderVO.getMoText());
			pstmt.setBytes(7, medicalOrderVO.getMoVideo());
			pstmt.setString(8, medicalOrderVO.getMoIntro());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Cloudn't load database driver." + e.getMessage());
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
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, moNo);
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MedicalOrderVO> findByPrimaryKey(String memNo) {
		
		List<MedicalOrderVO> list = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			list = new ArrayList();		
			pstmt.setString(1, memNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();
				medicalOrderVO.setMemNo(rs.getString("memNo"));
				medicalOrderVO.setDrNo(rs.getString("drNo"));
				medicalOrderVO.setMoStatus(rs.getString("moStatus"));
				medicalOrderVO.setMoCost(rs.getInt("moCost"));
				medicalOrderVO.setMoTime(rs.getDate("moTime"));
				medicalOrderVO.setMoText(rs.getString("moText"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));
				
				list.add(medicalOrderVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" +e.getMessage());
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
		
		return list;
	}

	@Override
	public List<MedicalOrderVO> getAll() {
		
		List<MedicalOrderVO> list = new ArrayList<MedicalOrderVO>();
		MedicalOrderVO medicalOrderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
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
				medicalOrderVO.setMoText(rs.getString("moText"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));
				list.add(medicalOrderVO);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" + e.getMessage());
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

	public static void main(String[] args) {
		
		MedicalOrderJDBCDAO dao = new MedicalOrderJDBCDAO();

		//查全部
//		List<MedicalOrderVO> list2 = dao.getAll();
//		for(MedicalOrderVO medicalOrderVO1 : list2) {
//			System.out.print(medicalOrderVO1.getMoNo() +",");
//			System.out.print(medicalOrderVO1.getMemNo() +",");
//			System.out.print(medicalOrderVO1.getDrNo() +",");
//			System.out.print(medicalOrderVO1.getMoStatus() +",");
//			System.out.print(medicalOrderVO1.getMoCost() +",");
//			System.out.print(medicalOrderVO1.getMoTime() +",");
//			System.out.print(medicalOrderVO1.getMoText() +",");
//			System.out.print(medicalOrderVO1.getMoVideo() +",");
//			System.out.print(medicalOrderVO1.getMoIntro() +",");
//			System.out.println();
//		}		
		
		//查單筆
//		List<MedicalOrderVO> list1 = dao.findByPrimaryKey("M0002");
//		for(MedicalOrderVO medicalOrderVO1 : list1) {
//			System.out.print(medicalOrderVO1.getMemNo() +",");
//			System.out.print(medicalOrderVO1.getDrNo() +",");
//			System.out.print(medicalOrderVO1.getMoStatus() +",");
//			System.out.print(medicalOrderVO1.getMoCost() +",");
//			System.out.print(medicalOrderVO1.getMoTime() +",");
//			System.out.print(medicalOrderVO1.getMoText() +",");
//			System.out.print(medicalOrderVO1.getMoVideo() +",");
//			System.out.print(medicalOrderVO1.getMoIntro() +",");
//			System.out.println();
//		}
		
				
		//刪除
//		dao.delete("20181214-0009");
				
		//新增
//		MedicalOrderVO medicalOrderVO1 = new MedicalOrderVO();
//		medicalOrderVO1.setMemNo("M0001");
//		medicalOrderVO1.setDrNo("D0002");
//		medicalOrderVO1.setMoStatus("等待問診");
//		medicalOrderVO1.setMoCost(9487);
//		medicalOrderVO1.setMoTime(java.sql.Date.valueOf("2018-10-09"));
//		medicalOrderVO1.setMoText("蚊蟲咬傷");
//		medicalOrderVO1.setMoVideo(null);
//		medicalOrderVO1.setMoIntro(null);
//		dao.insert(medicalOrderVO1);
		
		
		
		
		
	}

}
