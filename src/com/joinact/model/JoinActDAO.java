package com.joinact.model;

import java.sql.Connection;
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

import com.activity.model.ActivityDAO;
import com.license.model.QualifyVO;
import com.member.model.MemberVO;

public class JoinActDAO implements JoinActDAO_interface{
	
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
		"INSERT INTO joinact(actNo,memno,joinstatus)"
		+ "VALUES(?,?,1)";
	private static final String GET_ALL_STMT=
		"SELECT * FROM joinact ORDER BY actNo";
		
	private static final String GET_ONE_STMT = 
		"SELECT * from joinact WHERE actNo=?";
	
	private static final String DELETE = 
		"UPDATE joinact SET joinstatus=0 WHERE actno = ? and memno = ?";
	private static final String UPDATE =
		"UPDATE joinact SET actNo =? WHERE memNo = ?";
	//查詢會員參加的活動
	private static final String FIND_JOIN_ACT =
		"select joinact.memno,joinact.actno,activity.actname,activity.actloc,activity.acttime,activity.actpic,activity.actdesc,activity.latitude,activity.longtitude "
		+ "from joinact join activity on joinact.actno=activity.actno where joinact.memno=? and joinact.joinstatus=1 order by joinact.actno";
	//查詢會員是否有參加過活動
	private static final String FIND_REPEATACT = 
		"select joinact.memno,joinact.actno,activity.actname,activity.actloc,activity.acttime,activity.actpic,activity.actdesc "
		+ "from joinact join activity on joinact.actno=activity.actno where joinact.memno=? and joinact.actNo=? order by joinact.actno";	
	//查詢參加活動的會員名稱
	private static final String FIND_NAME_IN_CHAT = 
			"SELECT joinact.memno,joinact.actno,member.memname,member.mempic from joinact,member where joinact.memno = member.memno and actNo =?";
	private static final String FIND_OFF_ACT =
			"select joinact.memno,joinact.actno,activity.actname,activity.actloc,activity.acttime,activity.actpic,activity.actdesc "
			+ "from joinact join activity on joinact.actno=activity.actno where joinact.memno=? and activity.actstatus='已結束' order by joinact.actno";
	@Override
	public void insert(JoinActVO joinactVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con=ds.getConnection();
			pstmt =con.prepareStatement(INSERT_STMT);
			pstmt.setString(1,joinactVO.getActNo());
			pstmt.setString(2,joinactVO.getMemNo());
	
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
	public void update(JoinActVO joinactVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,joinactVO.getActNo());
			pstmt.setString(2,joinactVO.getMemNo());
		
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
	public void delete(String actNo,String memNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1,actNo);
			pstmt.setString(2, memNo);
		
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
	public List<JoinActVO> findByPrimaryKey(String actNo) {
		JoinActVO joinactVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<JoinActVO> list = new ArrayList<JoinActVO>();
		
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, actNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				joinactVO = new JoinActVO();
				
				joinactVO.setActNo(rs.getString("actNo"));
				joinactVO.setMemNo(rs.getString("Memno"));
				
				list.add(joinactVO);
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
	public List<JoinActVO> getAll() {
		List<JoinActVO> list = new ArrayList<JoinActVO>();
		JoinActVO joinactVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				joinactVO = new JoinActVO();
				
				joinactVO.setActNo(rs.getString("actNo"));
				joinactVO.setMemNo(rs.getString("Memno"));	
				list.add(joinactVO);	
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
	
	
	
	
	
public static void main(String[] args){
		
		JoinActDAO dao = new JoinActDAO();
		
		//新增
//		JoinactVO joinactVO1 = new JoinactVO();
//		joinactVO1.setactNo("ACT0001");
//		joinactVO1.setMemNo("M0002");
//		dao.insert(joinactVO1);
//		
//		System.out.println("OK");
		
		//修改
//		JoinactVO joinactVO2 = new JoinactVO();
//		joinactVO2.setactNo("ACT0025");
//		joinactVO2.setMemNo("M0002");
//		dao.update(joinactVO2);
//		System.out.println("OKOK");
		
		//刪除
//		dao.delete("ACT0023");
//		System.out.println("no problem");
		
		//查詢一個
//		JoinactVO joinactVO3 = dao.findByPrimaryKey("ACT0001");
//		System.out.println(joinactVO3.getactNo());
//		System.out.println(joinactVO3.getMemNo());
//		System.out.println("----------------------------------");
		
		//查詢全部
//		List<JoinactVO> list = dao.getAll();
//		for(JoinactVO jvo:list) {
//			
//			System.out.print(jvo.getactNo()+",");
//			System.out.print(jvo.getMemNo()+"�C");
//			System.out.println();	
//		}			
	}

@Override
public Set<PersonActVO> getAll(String memNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Set<PersonActVO> set = new LinkedHashSet<PersonActVO>();
		PersonActVO personActVO = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(FIND_JOIN_ACT);
			pstmt.setString(1, memNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				personActVO = new PersonActVO();
				personActVO.setMemNo(rs.getString(1));
				personActVO.setActNo(rs.getString(2));
				personActVO.setActName(rs.getString(3));
				personActVO.setActLoc(rs.getString(4));
				personActVO.setActTime(rs.getDate(5));
				personActVO.setActPic(rs.getBytes(6));
				personActVO.setActDesc(rs.getString(7));
				set.add(personActVO);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
		}finally {
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return set;
}

@Override
public JoinActVO findrepeatact(String actNo,String memNo) {
	Connection con = null;
	PreparedStatement pstmt = null;
	JoinActVO jvo = null;
	ResultSet rs = null;
	
	try {
		con=ds.getConnection();
		pstmt =con.prepareStatement(FIND_REPEATACT);
		pstmt.setString(1,memNo);
		System.out.println(memNo);
		pstmt.setString(2,actNo);
		rs = pstmt.executeQuery();
		System.out.println(actNo);
		
		while(rs.next()) {
			jvo = new JoinActVO();
			System.out.println("rs.getString(1) = " + rs.getString(1));
			jvo.setMemNo(rs.getString(1));
			jvo.setActNo(rs.getString(2));
			System.out.println("rs.getString(1) = "+rs.getString(2));
		}
		return jvo;
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
public List<ChatRoomVO> chatroomall(String actNo) {
	List<ChatRoomVO> list = new ArrayList<ChatRoomVO>();
	ChatRoomVO chatRoomVO = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con=ds.getConnection();
		pstmt = con.prepareStatement(FIND_NAME_IN_CHAT);
		pstmt.setString(1, actNo);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			chatRoomVO = new ChatRoomVO();
			
			chatRoomVO.setMemNo(rs.getString("Memno"));	
			chatRoomVO.setActNo(rs.getString("actNo"));
			chatRoomVO.setMemName(rs.getString("memName"));
			chatRoomVO.setMemPic(rs.getBytes("memPic"));
			list.add(chatRoomVO);
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
public List<PersonActVO> findoffact(String memNo) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	List<PersonActVO> list = new ArrayList<PersonActVO>();
	PersonActVO personActVO = null;
	
	try {
		con=ds.getConnection();
		pstmt = con.prepareStatement(FIND_JOIN_ACT);
		pstmt.setString(1, memNo);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			personActVO = new PersonActVO();
			personActVO.setMemNo(rs.getString(1));
			personActVO.setActNo(rs.getString(2));
			personActVO.setActName(rs.getString(3));
			personActVO.setActLoc(rs.getString(4));
			personActVO.setActTime(rs.getDate(5));
			personActVO.setActPic(rs.getBytes(6));
			personActVO.setActDesc(rs.getString(7));
			personActVO.setLatiTude(rs.getString(8));
			personActVO.setLongtiTude(rs.getString(9));
			
			list.add(personActVO);
		}
	} catch (SQLException se) {
		throw new RuntimeException("A database error occured. "	+ se.getMessage());
	}finally {
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException se) {
				se.printStackTrace(System.err);
			}
		}
		if(pstmt != null) {
			try {
				pstmt.close();
			}catch(SQLException se) {
				se.printStackTrace(System.err);
			}
		}
		if(con != null) {
			try {
				con.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	return list;
}

@Override
public void insert2(JoinActVO joinActVO, Connection con) {
	PreparedStatement pstmt = null;

	try {

 		pstmt = con.prepareStatement(INSERT_STMT);

		pstmt.setString(1, joinActVO.getActNo());
		pstmt.setString(2, joinActVO.getMemNo());
		System.out.println(joinActVO.getMemNo());
		pstmt.executeUpdate();
		// Handle any SQL errors
	} catch (SQLException se) {
		if (con != null) {
			try {
				// 3●設定於當有exception發生時之catch區塊內
				System.err.print("Transaction is being ");
				System.err.println("rolled back-由-joinact");
				con.rollback();
			} catch (SQLException excep) {
				throw new RuntimeException("rollback error occured. "
						+ excep.getMessage());
			}
		}
		throw new RuntimeException("A database error occured. "
				+ se.getMessage());
		// Clean up JDBC resources
	} finally {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException se) {
				se.printStackTrace(System.err);
			}
//			if(con != null) {
//				try {
//					con.close();
//				}catch(SQLException e) {
//					e.printStackTrace();
//				}
//			}
		}
	}
	
}

}
