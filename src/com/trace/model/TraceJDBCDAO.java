package com.trace.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.activity.model.ActivityJDBCDAO;
import com.joinact.model.JoinactVO;

public class TraceJDBCDAO implements TraceDAO_interface{
	
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO trace(memno,ActNo)"
		+ "VALUES(?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM trace ORDER BY ActNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from trace WHERE ActNo=?";
	
	private static final String DELETE = 
		"DELETE FROM trace WHERE MEMno = ?";
	
	private static final String UPDATE =
		"UPDATE trace SET ActNo =? WHERE MEMno = ?";
	
	@Override
	public void insert(TraceVO traceVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,traceVO.getMemNo());
			pstmt.setString(2,traceVO.getActNo());
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
	public void update(TraceVO traceVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,traceVO.getActNo());
			pstmt.setString(2,traceVO.getMemNo());
			
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
	public void delete(String ActNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1,ActNo);
		
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
	public TraceVO findByPrimaryKey(String ActNo) {
		TraceVO traceVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, ActNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				traceVO = new TraceVO();
				
				traceVO.setActNo(rs.getString("ActNo"));
				traceVO.setMemNo(rs.getString("Memno"));

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
		return traceVO;
	}

	@Override
	public List<TraceVO> getAll() {
		List<TraceVO> list = new ArrayList<TraceVO>();
		TraceVO traceVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				traceVO = new TraceVO();
				
				traceVO.setActNo(rs.getString("ActNo"));
				traceVO.setMemNo(rs.getString("Memno"));	
				list.add(traceVO);	
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
		
		TraceJDBCDAO dao = new TraceJDBCDAO();
		
		//新增
//		TraceVO TraceVO1 = new TraceVO();
//		
//		TraceVO1.setMemNo("M0005");
//		TraceVO1.setActNo("ACT0001");
//		dao.insert(TraceVO1);
//		
//		System.out.println("OK");
		
		//修改
//		TraceVO TraceVO2 = new TraceVO();
//		TraceVO2.setActNo("ACT0025");
//		TraceVO2.setMemNo("M0005");
//		
//		dao.update(TraceVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//查詢一個
//		TraceVO traceVO3 = dao.findByPrimaryKey("ACT0001");
//		System.out.println(traceVO3.getActNo());
//		System.out.println(traceVO3.getMemNo());
//		System.out.println("----------------------------------");
		
		//查詢全部
		List<TraceVO> list = dao.getAll();
		for(TraceVO tvo:list) {
			
			System.out.print(tvo.getActNo()+",");
			System.out.print(tvo.getMemNo()+"。");
			System.out.println();	
		}	
	}

}
