package com.reportact.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.activity.model.ActivityDAO;
import com.activity.model.ActivityVO;

public class ReportactDAO implements ReportactDAO_interface{
	
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO Reportact(repaNo,actno,memno,repastatus)"
		+ "VALUES('repa'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'),?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM Reportact ORDER BY repaNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from Reportact WHERE repaNo=?";
	
	private static final String DELETE = 
		"DELETE FROM Reportact WHERE repaNo = ?";
	
	private static final String UPDATE =
		"UPDATE Reportact SET repastatus =? WHERE repaNo = ?";
	
	@Override
	public void insert(ReportactVO reportactVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,reportactVO.getActNo());
			pstmt.setString(2,reportactVO.getMemNo());
			pstmt.setString(3,reportactVO.getRepaStatus());
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(ReportactVO reportactVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,reportactVO.getRepaStatus());
			pstmt.setString(2,reportactVO.getRepaNo());
		
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." +se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void delete(String repaNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,repaNo);
		
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured." +se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public ReportactVO findByPrimaryKey(String repaNo) {
		ReportactVO reportactVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, repaNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reportactVO = new ReportactVO();
				
				reportactVO.setRepaNo(rs.getString("repaNo"));
				reportactVO.setActNo(rs.getString("ACTNO"));
				reportactVO.setMemNo(rs.getString("MEMNO"));
				reportactVO.setRepaStatus(rs.getString("REPASTATUS"));
				
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		return reportactVO;
	}

	@Override
	public List<ReportactVO> getAll() {
		List<ReportactVO> list = new ArrayList<ReportactVO>();
		ReportactVO reportactVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reportactVO = new ReportactVO();
				
				reportactVO.setRepaNo(rs.getString("repaNo"));
				reportactVO.setActNo(rs.getString("ACTNO"));
				reportactVO.setMemNo(rs.getString("MEMNO"));
				reportactVO.setRepaStatus(rs.getString("REPASTATUS"));
				list.add(reportactVO);	
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	public static void main(String[] args){
		
		ReportactDAO dao = new ReportactDAO();
		
		//新增
//		ReportactVO ReportactVO1 = new ReportactVO();
//		ReportactVO1.setActNo("ACT0001");
//		ReportactVO1.setMemNo("M0001");
//		ReportactVO1.setRepaStatus("���ˬd");
//		dao.insert(ReportactVO1);
//		
//		System.out.println("OK");
		
		//修改
//		ReportactVO ReportactVO2 = new ReportactVO();
//		ReportactVO2.setRepaStatus("�w�ˬd");
//		ReportactVO2.setrepaNo("repa0026");
//		dao.update(ReportactVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//查詢一個
//		ReportactVO ReportactVO3 = dao.findByPrimaryKey("REPA0026");
//		System.out.println(ReportactVO3.getrepaNo());
//		System.out.println(ReportactVO3.getActNo());
//		System.out.println(ReportactVO3.getMemNo());
//		System.out.println(ReportactVO3.getRepaStatus());
//		System.out.println("----------------------------------");
		
		//查詢全部
//		List<ReportactVO> list = dao.getAll();
//		for(ReportactVO rvo:list) {
//			
//			System.out.print(rvo.getrepaNo()+",");
//			System.out.print(rvo.getActNo()+",");
//			System.out.print(rvo.getMemNo()+",");
//			System.out.print(rvo.getRepaStatus()+"�C");
//			System.out.println();	
//		}			
	}

}
