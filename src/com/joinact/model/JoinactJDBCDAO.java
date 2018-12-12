package com.joinact.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.activity.model.ActivityJDBCDAO;
import com.member.model.MemberVO;

public class JoinactJDBCDAO implements JoinactDAO_interface{
	
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO joinact(actno,memno)"
		+ "VALUES(?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM joinact ORDER BY actno";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from joinact WHERE actno=?";
	
	private static final String DELETE = 
		"DELETE FROM joinact WHERE MEMno = ?";
	
	private static final String UPDATE =
		"UPDATE joinact SET actno =? WHERE MEMno = ?";
	
	@Override
	public void insert(JoinactVO joinactVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,joinactVO.getActNo());
			pstmt.setString(2,joinactVO.getMemNo());
	
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
	public void update(JoinactVO joinactVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,joinactVO.getActNo());
			pstmt.setString(2,joinactVO.getMemNo());
		
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
	public void delete(String actno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1,actno);
		
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
	public JoinactVO findByPrimaryKey(String actno) {
		JoinactVO joinactVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, actno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				joinactVO = new JoinactVO();
				
				joinactVO.setActNo(rs.getString("actNO"));
				joinactVO.setMemNo(rs.getString("Memno"));

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
		return joinactVO;
	}

	@Override
	public List<JoinactVO> getAll() {
		List<JoinactVO> list = new ArrayList<JoinactVO>();
		JoinactVO joinactVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				joinactVO = new JoinactVO();
				
				joinactVO.setActNo(rs.getString("actNO"));
				joinactVO.setMemNo(rs.getString("Memno"));	
				list.add(joinactVO);	
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
		
		JoinactJDBCDAO dao = new JoinactJDBCDAO();
		
		//新增
//		JoinactVO joinactVO1 = new JoinactVO();
//		joinactVO1.setActNo("ACT0001");
//		joinactVO1.setMemNo("M0002");
//		dao.insert(joinactVO1);
//		
//		System.out.println("OK");
		
		//修改
//		JoinactVO joinactVO2 = new JoinactVO();
//		joinactVO2.setActNo("ACT0025");
//		joinactVO2.setMemNo("M0002");
//		dao.update(joinactVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//查詢一個
//		JoinactVO joinactVO3 = dao.findByPrimaryKey("ACT0001");
//		System.out.println(joinactVO3.getActNo());
//		System.out.println(joinactVO3.getMemNo());
//		System.out.println("----------------------------------");
		
		//查詢全部
//		List<JoinactVO> list = dao.getAll();
//		for(JoinactVO jvo:list) {
//			
//			System.out.print(jvo.getActNo()+",");
//			System.out.print(jvo.getMemNo()+"。");
//			System.out.println();	
//		}			
	}
}
