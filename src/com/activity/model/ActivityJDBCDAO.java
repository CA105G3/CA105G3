package com.activity.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.member.model.MemberJDBCDAO;
import com.member.model.MemberVO;

public class ActivityJDBCDAO implements ActivityDAO_interface{
	
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO activity(actNo,memno,actname,actloc,acttime,actstatus,actlimit,timecheck)"
		+ "VALUES('ACT'||lpad(to_char(MEMBER_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM ACTIVITY ORDER BY actNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from activity WHERE actNo=?";
	
	private static final String DELETE = 
		"DELETE FROM ACTIVITY WHERE actNo = ?";
	
	private static final String UPDATE =
		"UPDATE ACTIVITY SET ACTLOC =? WHERE actNo = ?";
	
	
	@Override
	public void insert(ActivityVO activityVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,activityVO.getMemNo());
			pstmt.setString(2,activityVO.getActName());
			pstmt.setString(3,activityVO.getActLoc());
			pstmt.setDate(4,activityVO.getActTime());
			pstmt.setString(5,activityVO.getActStatus());
			pstmt.setInt(6,activityVO.getActLimit());
			pstmt.setInt(7,activityVO.getTimeCheck());
			
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
	public void update(ActivityVO activityVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,activityVO.getActLoc());
			pstmt.setString(2,activityVO.getActNo());
		
			
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
	public void delete(String actNo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,actNo);
		
			
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
	public ActivityVO findByPrimaryKey(String actNo) {
		
		ActivityVO activityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, actNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				activityVO = new ActivityVO();
				
				activityVO.setActNo(rs.getString("actNo"));
				activityVO.setMemNo(rs.getString("MEMNO"));
				activityVO.setActName(rs.getString("ACTNAME"));
				activityVO.setActLoc(rs.getString("ACTLOC"));
				activityVO.setActTime(rs.getDate("ACTTIME"));
				activityVO.setActStatus(rs.getString("ACTSTATUS"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				
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

		return activityVO;
	}

	@Override
	public List<ActivityVO> getAll() {
		List<ActivityVO> list = new ArrayList<ActivityVO>();
		ActivityVO activityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				activityVO = new ActivityVO();
				
				activityVO.setActNo(rs.getString("actNo"));
				activityVO.setMemNo(rs.getString("MEMNO"));
				activityVO.setActName(rs.getString("ACTNAME"));
				activityVO.setActLoc(rs.getString("ACTLOC"));
				activityVO.setActTime(rs.getDate("ACTTIME"));
				activityVO.setActStatus(rs.getString("ACTSTATUS"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				list.add(activityVO);	
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
		
		ActivityJDBCDAO dao = new ActivityJDBCDAO();
		
		//新增
		ActivityVO activityVO1 = new ActivityVO();
		activityVO1.setMemNo("M0002");
		activityVO1.setActName("���F���j��");;
		Date date = Date.valueOf("2008-11-04");
		activityVO1.setActLoc("9�S3/4��x");
		activityVO1.setActTime(date);
		activityVO1.setActStatus("�w����");
		activityVO1.setActLimit(2);
		activityVO1.setTimeCheck(2);
		
		dao.insert(activityVO1);
		
		System.out.println("OK");
		
		//修改
//		ActivityVO activityVO2 = new ActivityVO();
//		activityVO2.setActLoc("�J���P");
//		activityVO2.setactNo("ACT0023");
//		dao.update(activityVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//查詢一個
//		ActivityVO activityVO3 = dao.findByPrimaryKey("ACT0001");
//		System.out.println(activityVO3.getMemNo());
//		System.out.println(activityVO3.getActName());
//		System.out.println(activityVO3.getActLoc());
//		System.out.println(activityVO3.getActTime());
//		System.out.println(activityVO3.getActStatus());
//		System.out.println(activityVO3.getActLimit());
//		System.out.println(activityVO3.getTimeCheck());
//		System.out.println("----------------------------------");
		
		//查詢全部
//		List<ActivityVO> list = dao.getAll();
//		for(ActivityVO avo:list) {
//			
//			System.out.print(avo.getactNo()+",");
//			System.out.print(avo.getMemNo()+",");
//			System.out.print(avo.getActName()+",");
//			System.out.print(avo.getActLoc()+",");
//			System.out.print(avo.getActTime()+",");
//			System.out.print(avo.getActStatus()+",");
//			System.out.print("�̤֤H�Ƭ�"+avo.getActLimit()+"�H,");
//			System.out.print(avo.getTimeCheck()+"�ѫᵲ���έp�C");
//			System.out.println();	
//		}			
	}
}
