package com.impression.model;

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

import com.activity.model.ActivityDAO;
import com.member.model.MemberVO;

public class ImpressionDAO implements ImpressionDAO_interface{
	private static DataSource ds = null;
	
	static {
		Context ctx;
		try {
			ctx = new InitialContext();
			ds=(DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	private static final String INSERT_STMT = 
		"INSERT INTO impression(impNo,impTime,impName,actno,memno,impcon,recvideo,recpic,impfield)"
		+ "VALUES('I'||lpad(to_char(impression_seq.NEXTVAL), 4, '0'),TO_DATE(sysdate),?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM impression ORDER BY impNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from impression WHERE impNo=?";
	
	private static final String DELETE = 
		"DELETE FROM impression WHERE impNo = ?";
	
	private static final String UPDATE =
		"UPDATE impression SET impName=?,impcon =?,recvideo =?,recpic =?,impfield =?WHERE impNo = ?";
	private static final String FIND_MY_IMP = 
			"SELECT * from impression WHERE memNo=?";	
	@Override
	public void insert(ImpressionVO impressionVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con=ds.getConnection();
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, impressionVO.getImpName());
			pstmt.setString(2,impressionVO.getActNo());
			pstmt.setString(3,impressionVO.getMemNo());
			pstmt.setString(4,impressionVO.getImpCon());
			pstmt.setBytes(5,impressionVO.getRecVideo());
			pstmt.setBytes(6,impressionVO.getRecPic());
			pstmt.setString(7,impressionVO.getImpField());
			
			pstmt.executeUpdate();
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
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, impressionVO.getImpName());
			pstmt.setString(2,impressionVO.getImpCon());
			pstmt.setBytes(3,impressionVO.getRecVideo());
			pstmt.setBytes(4,impressionVO.getRecPic());
			pstmt.setString(5,impressionVO.getImpField());
			pstmt.setString(6,impressionVO.getImpNo());
			System.out.println("JDBC " + impressionVO.getImpNo());
		
			
			pstmt.executeUpdate();
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
	public void delete(String impNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
		
			pstmt.setString(1,impNo);
		
			
			pstmt.executeUpdate();
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
	public ImpressionVO findByPrimaryKey(String impNo) {
		ImpressionVO impressionVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, impNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				impressionVO = new ImpressionVO();
				
				impressionVO.setImpNo(rs.getString("impNo"));
				impressionVO.setImpTime(rs.getDate("impTime"));
				impressionVO.setImpName(rs.getString("impName"));
				impressionVO.setActNo(rs.getString("actNo"));
				impressionVO.setMemNo(rs.getString("memNo"));
				impressionVO.setImpCon(rs.getString("impCon"));
				impressionVO.setRecVideo(rs.getBytes("recVideo"));
				impressionVO.setRecPic(rs.getBytes("recPic"));
				impressionVO.setImpField(rs.getString("impField"));
				
			}
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
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				impressionVO = new ImpressionVO();
				
				impressionVO.setImpNo(rs.getString("impNo"));
				impressionVO.setImpTime(rs.getDate("impTime"));
				impressionVO.setImpName(rs.getString("impName"));
				impressionVO.setActNo(rs.getString("ACTNO"));
				impressionVO.setMemNo(rs.getString("MEMNO"));
				impressionVO.setImpCon(rs.getString("IMPCON"));
				impressionVO.setRecVideo(rs.getBytes("RECVIDEO"));
				impressionVO.setRecPic(rs.getBytes("RECPIC"));
				impressionVO.setImpField(rs.getString("IMPFIELD"));
				list.add(impressionVO);	
			}
			
		
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


@Override
public List<ImpressionVO> findmyimp(String memNo) {
	List<ImpressionVO> list = new ArrayList<ImpressionVO>();
	ImpressionVO impressionVO = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con=ds.getConnection();
		pstmt = con.prepareStatement(FIND_MY_IMP);
		pstmt.setString(1, memNo);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			impressionVO = new ImpressionVO();
			
			impressionVO.setImpNo(rs.getString("impNo"));
			System.out.println("DAOrsIMPNO"+rs.getString("impNo"));
			impressionVO.setImpTime(rs.getDate("impTime"));
			impressionVO.setImpName(rs.getString("impName"));
			impressionVO.setActNo(rs.getString("ACTNO"));
			impressionVO.setMemNo(rs.getString("MEMNO"));
			impressionVO.setImpCon(rs.getString("IMPCON"));
			impressionVO.setRecVideo(rs.getBytes("RECVIDEO"));
			impressionVO.setRecPic(rs.getBytes("RECPIC"));
			impressionVO.setImpField(rs.getString("IMPFIELD"));
			list.add(impressionVO);	
		}
		
	
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
}
