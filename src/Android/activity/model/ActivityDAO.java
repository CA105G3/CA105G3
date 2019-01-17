package Android.activity.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//import com.impression.model.ImpressionVO;
//import com.member.model.MemberJDBCDAO;
//import com.member.model.MemberVO;

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
		"INSERT INTO activity(actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,actpic)"
		+ "VALUES('ACT'||lpad(to_char(MEMBER_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT=
		"SELECT actno,memno,actname,actloc,acttime,actstatus,actmax,actlimit,timecheck,actDesc,latitude,longtitude FROM ACTIVITY ORDER BY actNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from activity WHERE actNo=?";
	
	private static final String DELETE = 
		"DELETE FROM ACTIVITY WHERE actNo = ?";
	
	private static final String UPDATE =
		"UPDATE ACTIVITY SET memno=?,actname=?,actloc=?,acttime=?,actstatus=?,actmax=?,actlimit=?,timecheck=?,actDesc=?,actpic=?,latitude=?,longtitude=? WHERE actNo = ?";
	
	private static final String GET_MEM_BY_ACT = 
		"SELECT impNo,impName,actno,memno,impcon,recvideo,recpic,impfield FROM IMPRESSION WHERE ACTNO = ? ORDER BY IMPNO";
	private static final String FIND_IMG_BY_ISBN = "SELECT actpic FROM activity WHERE actno = ?";
	
	
	@Override
	public byte[] getImage(String isbn) {
		byte[] picture = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(FIND_IMG_BY_ISBN);
			
			pstmt.setString(1, isbn);
			
			rs = pstmt.executeQuery();
	
			if (rs.next()) {
				picture = rs.getBytes(1);
			}
			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
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
		return picture;
	}
	
	
	
	
	
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
			pstmt.setString(11,activityVO.getActNo());
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
				activityVO.setLongtitude(rs.getString("Longtitude"));
				activityVO.setLatitude(rs.getString("Latitude"));
//				activityVO.setActPic(rs.getBytes("ACTPIC"));
				
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
				activityVO.setLongtitude(rs.getString("Longtitude"));
				activityVO.setLatitude(rs.getString("Latitude"));
//				activityVO.setActPic(rs.getBytes("ACTPIC"));
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


	
//	@Override
//	public Set<ImpressionVO> getmembyactno(String actNo) {
//		Set<ImpressionVO> set = new LinkedHashSet<ImpressionVO>();
//		ImpressionVO impressionVO = null;
//	
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//	
//		try {
//	
//			con=ds.getConnection();
//			pstmt = con.prepareStatement(GET_MEM_BY_ACT);
//			//SELECT impNo,impName,actno,memno,impcon,recvideo,recpic,impfield FROM IMPRESSION WHERE ACTNO = ? ORDER BY IMPNO
//			pstmt.setString(1, actNo);
//			rs = pstmt.executeQuery();
//			
//			while (rs.next()) {
//				impressionVO = new ImpressionVO();
//				impressionVO.setImpNo(rs.getString("impNo"));
//				impressionVO.setImpName(rs.getString("impName"));
//				impressionVO.setActNo(rs.getString("actNo"));
//				impressionVO.setMemNo(rs.getString("memNo"));
//				impressionVO.setImpCon(rs.getString("impCon"));
//				impressionVO.setRecVideo(rs.getBytes("recVideo"));
//				impressionVO.setRecPic(rs.getBytes("recPic"));
//				impressionVO.setImpField(rs.getString("impField"));
//				set.add(impressionVO); // Store the row in the vector
//			}
//	
//			// Handle any SQL errors 
//		}catch (SQLException se) {
//			throw new RuntimeException("Couldn't load database driver."+ se.getMessage());
//		} finally {
//			if (rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException se) {
//					se.printStackTrace(System.err);
//				}
//			}
//			if (con != null) {
//				try {
//					con.close();
//				} catch (Exception e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}
//		return set;
//	}
	
	
	
	
	
//	public static void main(String[] args){
//		
//		ActivityJDBCDAO dao = new ActivityJDBCDAO();
//		
//		//�憓�
//		ActivityVO activityVO1 = new ActivityVO();
//		activityVO1.setMemNo("M0002");
//		activityVO1.setActName("嚙踝蕭嚙瘤嚙踝蕭嚙篌嚙踝蕭");;
//		Date date = Date.valueOf("2008-11-04");
//		activityVO1.setActLoc("9嚙磅3/4嚙踝蕭x");
//		activityVO1.setActTime(date);
//		activityVO1.setActStatus("嚙緩嚙踝蕭嚙踝蕭");
//		activityVO1.setActLimit(2);
//		activityVO1.setTimeCheck(2);
//		
//		dao.insert(activityVO1);
//		
//		System.out.println("OK");
		
	
		
		//靽格
//		ActivityVO activityVO2 = new ActivityVO();
//		activityVO2.setActLoc("嚙皚嚙踝蕭嚙瞑");
//		activityVO2.setactNo("ACT0023");
//		dao.update(activityVO2);
//		System.out.println("OKOK");
		
		//��
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//�閰Ｖ���
//		ActivityVO activityVO3 = dao.findByPrimaryKey("ACT0001");
//		System.out.println(activityVO3.getMemNo());
//		System.out.println(activityVO3.getActName());
//		System.out.println(activityVO3.getActLoc());
//		System.out.println(activityVO3.getActTime());
//		System.out.println(activityVO3.getActStatus());
//		System.out.println(activityVO3.getActLimit());
//		System.out.println(activityVO3.getTimeCheck());
//		System.out.println("----------------------------------");
		
		//�閰Ｗ�
//		List<ActivityVO> list = dao.getAll();
//		for(ActivityVO avo:list) {
//			
//			System.out.print(avo.getactNo()+",");
//			System.out.print(avo.getMemNo()+",");
//			System.out.print(avo.getActName()+",");
//			System.out.print(avo.getActLoc()+",");
//			System.out.print(avo.getActTime()+",");
//			System.out.print(avo.getActStatus()+",");
//			System.out.print("嚙諒少人嚙複穿蕭"+avo.getActLimit()+"嚙瘡,");
//			System.out.print(avo.getTimeCheck()+"嚙諸後結嚙踝蕭嚙諄計嚙瘠");
//			System.out.println();	
//		}			
	

}
