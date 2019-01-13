package com.activity.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.impression.model.ImpressionVO;
import com.member.model.MemberJDBCDAO;
import com.member.model.MemberVO;

public class ActivityDAO implements ActivityDAO_interface{
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
		"INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic,latitude,longtitude)"
		+ "VALUES('ACT'||lpad(to_char(MEMBER_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM ACTIVITY ORDER BY actNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from activity WHERE actNo=?";
	
	private static final String DELETE = 
		"DELETE FROM ACTIVITY WHERE actNo = ?";
	
	private static final String UPDATE =
		"UPDATE ACTIVITY SET memno=?,actname=?,actloc=?,acttime=?,actstatus=?,actmax=?,actlimit=?,timecheck=?,actDesc=?,actpic=?,latitude=?,longtitude=? WHERE actNo = ?";
	
	private static final String GET_MEM_BY_ACT = 
		"SELECT impNo,impName,actno,memno,impcon,recvideo,recpic,impfield FROM IMPRESSION WHERE ACTNO = ? ORDER BY IMPNO";
	
	private static final String GET_ACT_ALL =
			"SELECT * FROM ACTIVITY WHERE ACTSTATUS = ?";
	private static final String GET_MYACT_ALL = 
			"SELECT * FROM ACTIVITY WHERE MEMNO = ?";
	
	@Override
	public void insert(ActivityVO activityVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,activityVO.getMemNo());
			pstmt.setString(2,activityVO.getActName());
			pstmt.setString(3,activityVO.getActLoc());
			pstmt.setDate(4,activityVO.getActTime());
			pstmt.setString(5,activityVO.getActStatus());
			pstmt.setInt(6, activityVO.getActMax());
			pstmt.setInt(7,activityVO.getActLimit());
			pstmt.setInt(8,activityVO.getTimeCheck());
			pstmt.setString(9, activityVO.getActDesc());
			pstmt.setBytes(10,activityVO.getActPic());
			pstmt.setString(11, activityVO.getLatiTude());
			pstmt.setString(12, activityVO.getLongtiTude());
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
	public void update(ActivityVO activityVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,activityVO.getMemNo());
			pstmt.setString(2,activityVO.getActName());
			pstmt.setString(3,activityVO.getActLoc());
			pstmt.setDate(4,activityVO.getActTime());
			pstmt.setString(5,activityVO.getActStatus());
			pstmt.setInt(6,activityVO.getActMax());
			pstmt.setInt(7,activityVO.getActLimit());
			pstmt.setInt(8,activityVO.getTimeCheck());
			pstmt.setString(9, activityVO.getActDesc());
			pstmt.setBytes(10,activityVO.getActPic());
			pstmt.setString(11, activityVO.getLatiTude());
			pstmt.setString(12, activityVO.getLongtiTude());
			pstmt.setString(13,activityVO.getActNo());
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
	public void delete(String actNo) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1,actNo);
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
	public ActivityVO findByPrimaryKey(String actNo) {
		
		ActivityVO activityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
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
				activityVO.setActMax(rs.getInt("ACTMAX"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				activityVO.setActDesc(rs.getString("ACTDESC"));
				activityVO.setActPic(rs.getBytes("ACTPIC"));
				activityVO.setLatiTude(rs.getString("latitude"));
				activityVO.setLongtiTude(rs.getString("longtiTude"));
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
			con=ds.getConnection();
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
				activityVO.setActMax(rs.getInt("ACTMAX"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				activityVO.setActDesc(rs.getString("ACTDESC"));
				activityVO.setActPic(rs.getBytes("ACTPIC"));
				activityVO.setLatiTude(rs.getString("latitude"));
				activityVO.setLongtiTude(rs.getString("longtiTude"));
				list.add(activityVO);	
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
	public Set<ImpressionVO> getmembyactno(String actNo) {
		Set<ImpressionVO> set = new LinkedHashSet<ImpressionVO>();
		ImpressionVO impressionVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_MEM_BY_ACT);
			
			pstmt.setString(1, actNo);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				impressionVO = new ImpressionVO();
				impressionVO.setImpNo(rs.getString("impNo"));
				impressionVO.setImpName(rs.getString("impName"));
				impressionVO.setActNo(rs.getString("actNo"));
				impressionVO.setMemNo(rs.getString("memNo"));
				impressionVO.setImpCon(rs.getString("impCon"));
				impressionVO.setRecVideo(rs.getBytes("recVideo"));
				impressionVO.setRecPic(rs.getBytes("recPic"));
				impressionVO.setImpField(rs.getString("impField"));
				set.add(impressionVO); // Store the row in the vector
			}
	
			// Handle any SQL errors 
		}catch (SQLException se) {
			throw new RuntimeException("Couldn't load database driver."+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return set;
	}

	@Override
	public List<ActivityVO> getact(String actStatus) {
		List<ActivityVO> list = new ArrayList<ActivityVO>();
		ActivityVO activityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ACT_ALL);
			pstmt.setString(1, actStatus);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				activityVO = new ActivityVO();
				
				activityVO.setActNo(rs.getString("ACTNO"));
				activityVO.setMemNo(rs.getString("MEMNO"));
				activityVO.setActName(rs.getString("ACTNAME"));
				activityVO.setActLoc(rs.getString("ACTLOC"));
				activityVO.setActTime(rs.getDate("ACTTIME"));
				activityVO.setActStatus(rs.getString("ACTSTATUS"));
				activityVO.setActMax(rs.getInt("ACTMAX"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				activityVO.setActDesc(rs.getString("ACTDESC"));
				activityVO.setActPic(rs.getBytes("ACTPIC"));
				activityVO.setLatiTude(rs.getString("latitude"));
				activityVO.setLongtiTude(rs.getString("longtiTude"));
				list.add(activityVO);
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
	
	public List<ActivityVO> getmyact(String memNo) {
		List<ActivityVO> list = new ArrayList<ActivityVO>();
		ActivityVO activityVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_MYACT_ALL);
			pstmt.setString(1, memNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				activityVO = new ActivityVO();
				
				activityVO.setActNo(rs.getString("actNo"));
				activityVO.setMemNo(rs.getString("MEMNO"));
				activityVO.setActName(rs.getString("ACTNAME"));
				activityVO.setActLoc(rs.getString("ACTLOC"));
				activityVO.setActTime(rs.getDate("ACTTIME"));
				activityVO.setActStatus(rs.getString("ACTSTATUS"));
				activityVO.setActMax(rs.getInt("ACTMAX"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				activityVO.setActDesc(rs.getString("ACTDESC"));
				activityVO.setActPic(rs.getBytes("ACTPIC"));
				activityVO.setLatiTude(rs.getString("latitude"));
				activityVO.setLongtiTude(rs.getString("longtiTude"));
				list.add(activityVO);	
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
	public List<ActivityVO> getactall(Map<String, String[]> map) {
		List<ActivityVO> list = new ArrayList<ActivityVO>();
		ActivityVO activityVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			
			con = ds.getConnection();
			String finalSQL = "select * from activity "
		          + jdbcUtil_CompositeQuery_Emp2.get_WhereCondition(map)
		          + "and actStatus = '募集中' "
		          + "order by actNo";
			pstmt = con.prepareStatement(finalSQL);
			System.out.println("●●finalSQL(by DAO) = "+finalSQL);
			rs = pstmt.executeQuery();
	
			while (rs.next()) {
				activityVO = new ActivityVO();
				activityVO.setActNo(rs.getString("actNo"));
				activityVO.setMemNo(rs.getString("MEMNO"));
				activityVO.setActName(rs.getString("ACTNAME"));
				activityVO.setActLoc(rs.getString("ACTLOC"));
				activityVO.setActTime(rs.getDate("ACTTIME"));
				activityVO.setActStatus(rs.getString("ACTSTATUS"));
				activityVO.setActMax(rs.getInt("ACTMAX"));
				activityVO.setActLimit(rs.getInt("ACTLIMIT"));
				activityVO.setTimeCheck(rs.getInt("TIMECHECK"));
				activityVO.setActDesc(rs.getString("ACTDESC"));
				activityVO.setActPic(rs.getBytes("ACTPIC"));
				activityVO.setLatiTude(rs.getString("latitude"));
				activityVO.setLongtiTude(rs.getString("longtiTude"));
				list.add(activityVO); // Store the row in the List
			}
	
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
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
