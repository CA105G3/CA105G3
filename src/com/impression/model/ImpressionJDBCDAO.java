package com.impression.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.activity.model.ActivityJDBCDAO;
import com.member.model.MemberVO;

public class ImpressionJDBCDAO implements ImpressionDAO_interface{
	
	String dirver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO impression(impno,actno,memno,impcon,recvideo,recpic,impfield)"
		+ "VALUES(to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM impression ORDER BY impno";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from impression WHERE impno=?";
	
	private static final String DELETE = 
		"DELETE FROM impression WHERE impno = ?";
	
	private static final String UPDATE =
		"UPDATE impression SET impcon =? WHERE impno = ?";
	
	@Override
	public void insert(ImpressionVO impressionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,impressionVO.getActNo());
			pstmt.setString(2,impressionVO.getMemNo());
			pstmt.setString(3,impressionVO.getImpCon());
			pstmt.setBytes(4,impressionVO.getRecVideo());
			pstmt.setBytes(5,impressionVO.getRecPic());
			pstmt.setString(6,impressionVO.getImpField());
			
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
	public void update(ImpressionVO impressionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setBytes(1,impressionVO.getRecPic());
			pstmt.setString(2,impressionVO.getImpNo());
		
			
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
	public void delete(String impno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			
			pstmt.setString(1,impno);
		
			
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
	public ImpressionVO findByPrimaryKey(String impno) {
		ImpressionVO impressionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, impno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				impressionVO = new ImpressionVO();
				
				impressionVO.setImpNo(rs.getString("IMPNO"));
				impressionVO.setActNo(rs.getString("ACTNO"));
				impressionVO.setMemNo(rs.getString("MEMNO"));
				impressionVO.setImpCon(rs.getString("IMPCON"));
				impressionVO.setRecVideo(rs.getBytes("RECVIDEO"));
				impressionVO.setRecPic(rs.getBytes("RECPIC"));
				impressionVO.setImpField(rs.getString("IMPFIELD"));
				
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
		
		return impressionVO;
	}

	@Override
	public List<ImpressionVO> getAll() {
		List<ImpressionVO> list = new ArrayList<ImpressionVO>();
		ImpressionVO impressionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				impressionVO = new ImpressionVO();
				
				impressionVO.setImpNo(rs.getString("IMPNO"));
				impressionVO.setActNo(rs.getString("ACTNO"));
				impressionVO.setMemNo(rs.getString("MEMNO"));
				impressionVO.setImpCon(rs.getString("IMPCON"));
				impressionVO.setRecVideo(rs.getBytes("RECVIDEO"));
				impressionVO.setRecPic(rs.getBytes("RECPIC"));
				impressionVO.setImpField(rs.getString("IMPFIELD"));
				list.add(impressionVO);	
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
		
		ImpressionJDBCDAO dao = new ImpressionJDBCDAO();
		
		//新增
//		ImpressionVO ImpressionVO1 = new ImpressionVO();
//		ImpressionVO1.setActNo("ACT0001");
//		ImpressionVO1.setMemNo("M0001");
//		ImpressionVO1.setImpCon("很好");
//		ImpressionVO1.setRecVideo(null);
//		ImpressionVO1.setRecPic(null);
//		ImpressionVO1.setImpField("文字心得");
//		
//		dao.insert(ImpressionVO1);
//		
//		System.out.println("OK");
		
		//修改
//		ImpressionVO impressionVO2 = new ImpressionVO();
//		impressionVO2.setImpCon("自從我每天都吃了撒尿牛丸之後，我每次考試都考一百分");
//		impressionVO2.setImpNo("20181212-0003");
//		dao.update(impressionVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//查詢一個
//		ImpressionVO impressionVO3 = dao.findByPrimaryKey("20181212-0003");
//		System.out.println(impressionVO3.getImpNo());
//		System.out.println(impressionVO3.getActNo());
//		System.out.println(impressionVO3.getMemNo());
//		System.out.println(impressionVO3.getImpCon());
//		System.out.println(impressionVO3.getRecVideo());
//		System.out.println(impressionVO3.getRecPic());
//		System.out.println(impressionVO3.getImpField());
//		System.out.println("----------------------------------");
		 
//		List<ImpressionVO> list = dao.getAll();
//		for(ImpressionVO impvo:list) {
//			
//			System.out.print(impvo.getImpNo()+",");
//			System.out.print(impvo.getActNo()+",");
//			System.out.print(impvo.getMemNo()+",");
//			System.out.print(impvo.getImpCon()+",");
//			System.out.print(impvo.getRecVideo()+",");
//			System.out.print(impvo.getRecPic()+",");
//			System.out.print(impvo.getImpField()+"。");
//			System.out.println();	
//		}			
	}
}
