package com.medicalorder.model;

import java.sql.*;
import java.util.*;

import javax.management.RuntimeErrorException;

public class MedicalOrderJDBCDAO implements MedicalOrder_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user = "CA105G3";
	String password = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO medicalorder VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(medicalorder_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?,?,?)";
	private static final String DELETE = 
			"DELETE FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ONE_STMT =
			"SELECT * FROM MEDICALORDER WHERE MONO = ?";
	private static final String GET_ALL_STMT =
			"SELECT * FROM MEDICALORDER";
	private static final String UPDATE = 
			"UPDATE MEDICALORDER SET MEMNO=? ,DRNO= ? ,MOSTATUS=? ,MOCOST=? ,MOTIME=? ,MOINTRO=?, MOCANCELREASON=? ,MOVIDEO=? ,MOTEXT=?  WHERE MONO=?";
	private static final String FIND_LIST_FOR_MEMBER = 
			"SELECT MEMNO, DRNO, MOSTATUS, MOCOST, MOTIME, MOINTRO, MOVIDEO, MOTEXT FROM MEDICALORDER WHERE MEMNO = ?";
	
	
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
			pstmt.setString(6, medicalOrderVO.getMoIntro());
			pstmt.setString(7, medicalOrderVO.getMoCancelReason());
			pstmt.setBytes(8, medicalOrderVO.getMoVideo());
			pstmt.setString(9, medicalOrderVO.getMoText());
			
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
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, medicalOrderVO.getMemNo());
			pstmt.setString(2, medicalOrderVO.getDrNo());
			pstmt.setString(3, medicalOrderVO.getMoStatus());
			pstmt.setInt(4, medicalOrderVO.getMoCost());
			pstmt.setDate(5, medicalOrderVO.getMoTime());
			pstmt.setString(6, medicalOrderVO.getMoIntro());
			pstmt.setString(7, medicalOrderVO.getMoCancelReason());
			pstmt.setBytes(8, medicalOrderVO.getMoVideo());
			pstmt.setString(9, medicalOrderVO.getMoText());
			pstmt.setString(10, medicalOrderVO.getMoNo());
			
			pstmt.executeUpdate();

		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver" + e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
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
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));
				medicalOrderVO.setMoCancelReason("moCancelReason");
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
			
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
				medicalOrderVO.setMoIntro(rs.getString("moIntro"));			
				medicalOrderVO.setMoCancelReason(rs.getString("moCancelReason"));
				medicalOrderVO.setMoVideo(rs.getBytes("moVideo"));
				medicalOrderVO.setMoText(rs.getString("moText"));
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

	@Override
	public List<MedicalOrderVO> findListforMember(String memNo) {
		
		List<MedicalOrderVO> list = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_LIST_FOR_MEMBER);
			
			list = new ArrayList();
			pstmt.setString(1, memNo);
			rs = pstmt.executeQuery();
			

			while(rs.next()) {	
				MedicalOrderVO medicalOrderVO = new MedicalOrderVO();			
				medicalOrderVO.setMemNo(rs.getString("MEMNO"));
				medicalOrderVO.setDrNo(rs.getString("DRNO"));
				medicalOrderVO.setMoStatus(rs.getString("MOSTATUS"));
				medicalOrderVO.setMoCost(rs.getInt("MOCOST"));
				medicalOrderVO.setMoTime(rs.getDate("MOTIME"));
				medicalOrderVO.setMoIntro(rs.getString("MOINTRO"));
				medicalOrderVO.setMoVideo(rs.getBytes("MOVIDEO"));
				medicalOrderVO.setMoText(rs.getString("MOTEXT"));
				
				list.add(medicalOrderVO);			
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
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

	public static void main(String[] args) {
		
		MedicalOrderJDBCDAO dao = new MedicalOrderJDBCDAO();

		//查全部
//		List<MedicalOrderVO> list1 = dao.getAll();
//		for(MedicalOrderVO medicalOrderVO1 : list1) {
//			System.out.print(medicalOrderVO1.getMoNo() +",");
//			System.out.print(medicalOrderVO1.getMemNo() +",");
//			System.out.print(medicalOrderVO1.getDrNo() +",");
//			System.out.print(medicalOrderVO1.getMoStatus() +",");
//			System.out.print(medicalOrderVO1.getMoCost() +",");
//			System.out.print(medicalOrderVO1.getMoTime() +",");
//			System.out.print(medicalOrderVO1.getMoIntro() +",");
//			System.out.print(medicalOrderVO1.getMoCancelReason() + ",");
//			System.out.print(medicalOrderVO1.getMoVideo() +",");
//			System.out.print(medicalOrderVO1.getMoText() +",");
//			System.out.println();
//		}		
		
		//查單筆
//		MedicalOrderVO medicalOrderVO2 = dao.findByPrimaryKey("20181225-0009");
//			System.out.print(medicalOrderVO2.getMoNo() +",");
//			System.out.print(medicalOrderVO2.getMemNo() +",");
//			System.out.print(medicalOrderVO2.getDrNo() +",");
//			System.out.print(medicalOrderVO2.getMoStatus() +",");
//			System.out.print(medicalOrderVO2.getMoCost() +",");
//			System.out.print(medicalOrderVO2.getMoTime() +",");
//			System.out.print(medicalOrderVO2.getMoIntro() +",");	
//			System.out.print(medicalOrderVO2.getMoCancelReason() + ",");
//			System.out.print(medicalOrderVO2.getMoVideo() +",");
//			System.out.print(medicalOrderVO2.getMoText() +",");
//			System.out.println();
		
				
		//刪除
//		dao.delete("20181225-0010");
				
		//新增
//		MedicalOrderVO medicalOrderVO1 = new MedicalOrderVO();
//		medicalOrderVO1.setMemNo("M0001");
//		medicalOrderVO1.setDrNo("D0002");
//		medicalOrderVO1.setMoStatus("等待問診");
//		medicalOrderVO1.setMoCost(9487);
//		medicalOrderVO1.setMoTime(java.sql.Date.valueOf("2018-10-09"));
//		medicalOrderVO1.setMoIntro("蚊蟲咬傷");
//		medicalOrderVO1.setMoCancelReason(null);
//		medicalOrderVO1.setMoVideo(null);
//		medicalOrderVO1.setMoText(null);
//		dao.insert(medicalOrderVO1);
		
		//修改
//		MedicalOrderVO medicalOrderVO2 = new MedicalOrderVO();
//		medicalOrderVO2.setMemNo("M0001");
//		medicalOrderVO2.setDrNo("D0002");
//		medicalOrderVO2.setMoStatus("等待問診");
//		medicalOrderVO2.setMoCost(9999);
//		medicalOrderVO2.setMoTime(java.sql.Date.valueOf("2018-10-20"));
//		medicalOrderVO2.setMoIntro("狀況不明");
//		medicalOrderVO2.setMoCancelReason(null);
//		medicalOrderVO2.setMoVideo(null);
//		medicalOrderVO2.setMoText("開藥給你吃");
//		medicalOrderVO2.setMoNo("20181225-0009");
//		dao.update(medicalOrderVO2);
		
		//查單一會員的病例歷史紀錄
		List<MedicalOrderVO> list = dao.findListforMember("M0001");
		
		for(MedicalOrderVO medicalOrderVO : list) {
			System.out.print(medicalOrderVO.getMemNo() +",");
			System.out.print(medicalOrderVO.getDrNo() +",");
			System.out.print(medicalOrderVO.getMoStatus() +",");
			System.out.print(medicalOrderVO.getMoCost() +",");
			System.out.print(medicalOrderVO.getMoTime() +",");
			System.out.print(medicalOrderVO.getMoIntro() +",");
			System.out.print(medicalOrderVO.getMoVideo() +",");
			System.out.print(medicalOrderVO.getMoText() +",");
			System.out.println();
		}
		
	}

}
