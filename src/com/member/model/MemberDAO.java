package com.member.model;

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

import com.administrator.model.AdministratorVO;
import com.license.model.LicenseVO;
import com.tools.mail.Verifymail;

public class MemberDAO implements MemberDAO_interface{

	
	private static DataSource ds = null;
		static {
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TestDB");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
	
	private static final String INSERT_STMT = 
		"INSERT INTO  member(memno,memname,memid,addr,"
		+ "allergy,birth,bloodtype,email,"
		+ "famhistory,gender,ident,locno,"
		+ "medhistory,memstatus,phone,pwd,"
		+ "regdate,smoking,staytime) "
		+ "VALUES ('M'||LPAD(to_char(member_seq.NEXTVAL), 4, '0'), ?, ?, ?,"
		+ "?,?,?,?,"
		+ "?,?,?,?,"
		+ "?,?,?,?,"
		+ "?,?,?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM member order by memno";
	private static final String GET_ONE_STMT = 
		"SELECT * FROM member where memno = ?";
	private static final String DELETE = 
		"DELETE FROM member where memno = ?";
	private static final String UPDATE = 
		"UPDATE member set memname=?,memid=?,addr=?,allergy=?,"
		+ "birth=?,bloodtype=?,email=?,famhistory=?,"
		+ "gender=?,ident=?,locno=?,medhistory=?,"
		+ "memstatus=?,phone=?,pwd=?,regdate=?,"
		+ "smoking=?,staytime=?  where memno = ?";
	
	private static final String UPDATE_LOGIN="update member set staytime=? where memid=?";

	private static final String GET_ONE_STMT_BY_ID="select * from member where memid=?";
	
	private static final String UPDATE_FOR_BASIC_RECORD = 
			"UPDATE MEMBER SET bloodType=?, smoking=?, allergy=?, medHistory=?, famHistory=? where memId = ?";
	private static final String UPDATE_FOR_VERIFY="UPDATE MEMBER SET MEMSTATUS=? where memno=?";
	//license驗證
	private static final String CHANGE_IDNET =
			"UPDATE member set ident=? where memno=?";
	//license取得會員資料
	private static final String GET_MEM_BY_LIC=
			"SELECT licNo,memNo,licData,licStatus,licDesc,licDue FROM License WHERE memNO = ? ORDER BY LicNO";
	@Override
	public void insert(MemberVO memberVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=ds.getConnection();
			String col[] = {"MEMNO"};
			pstmt = con.prepareStatement(INSERT_STMT,col);
			
			pstmt.setString(1,memberVO.getMemName());
			pstmt.setString(2,memberVO.getMemId());
			pstmt.setString(3,memberVO.getAddr());
			pstmt.setString(4,memberVO.getAllergy());
			pstmt.setDate(5,memberVO.getBirth());
			pstmt.setString(6,memberVO.getBloodType());
			pstmt.setString(7,memberVO.getEmail());
			pstmt.setString(8,memberVO.getFamHistory());
			pstmt.setString(9,memberVO.getGender());
			pstmt.setString(10,memberVO.getIdent());
			pstmt.setInt(11,memberVO.getLocNo());
			pstmt.setString(12,memberVO.getMedHistory());
			pstmt.setString(13,memberVO.getMemStatus());
			pstmt.setString(14,memberVO.getPhone());
			pstmt.setString(15,memberVO.getPwd());
			pstmt.setDate(16,memberVO.getRegDate());
			pstmt.setString(17,memberVO.getSmoking());
			pstmt.setTimestamp(18,memberVO.getStayTime());
			pstmt.executeUpdate();
			
			
			String next_memno = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_memno = rs.getString(1);
			} else {
				System.out.println("未取得自增主鍵值");
			}
			rs.close();
			
			
			Verifymail sendmail = new Verifymail();
			String subject="線上醫療會員註冊驗證信件";
			String messageText="親愛的會員 "+memberVO.getMemName()+"您好"+"\n"
			+"感謝您註冊本網站，以下是您的驗證網址，請點擊通過驗證，謝謝!"+"\n"
			+"http://localhost:8081/ca105g3/front-end/member/member.do?action=verify&memno="+next_memno;
			sendmail.sendMail(memberVO.getEmail(), subject, messageText);
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
	}

	@Override
	public void update(MemberVO memberVO) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1,memberVO.getMemName());
			pstmt.setString(2,memberVO.getMemId());
			pstmt.setString(3,memberVO.getAddr());
			pstmt.setString(4,memberVO.getAllergy());
			pstmt.setDate(5,memberVO.getBirth());
			pstmt.setString(6,memberVO.getBloodType());
			pstmt.setString(7,memberVO.getEmail());
			pstmt.setString(8,memberVO.getFamHistory());
			pstmt.setString(9,memberVO.getGender());
			pstmt.setString(10,memberVO.getIdent());
			pstmt.setInt(11,memberVO.getLocNo());
			pstmt.setString(12,memberVO.getMedHistory());
			pstmt.setString(13,memberVO.getMemStatus());
			pstmt.setString(14,memberVO.getPhone());
			pstmt.setString(15,memberVO.getPwd());
			pstmt.setDate(16,memberVO.getRegDate());
			pstmt.setString(17,memberVO.getSmoking());
			pstmt.setTimestamp(18,memberVO.getStayTime());
			pstmt.setString(19, memberVO.getMemNo());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
	}

	@Override
	public void delete(String memberno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, memberno);
			pstmt.executeUpdate();
			// Handle any driver errors
		} catch (SQLException se) {
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
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public MemberVO findByPrimaryKey(String memberno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberVO memberVO =null;
		
		try {
			con=ds.getConnection();
			pstmt=con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1,memberno);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				memberVO=new MemberVO();
				memberVO.setMemNo(rs.getString("memno"));
				memberVO.setMemId(rs.getString("memid"));
				memberVO.setPwd(rs.getString("pwd"));
				memberVO.setMemName(rs.getString("memname"));
				memberVO.setAddr(rs.getString("addr"));
				memberVO.setAllergy(rs.getString("allergy"));
				memberVO.setBirth(rs.getDate("birth"));
				memberVO.setBloodType(rs.getString("bloodtype"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setFamHistory(rs.getString("famhistory"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setIdent(rs.getString("ident"));
				memberVO.setLocNo(rs.getInt("locno"));
				memberVO.setMedHistory(rs.getString("medhistory"));
				memberVO.setMemStatus(rs.getString("memstatus"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setRegDate(rs.getDate("regdate"));
				memberVO.setSmoking(rs.getString("smoking"));
				memberVO.setStayTime(rs.getTimestamp("staytime"));
			}
			// Handle any driver errors
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return memberVO;
	}

	@Override
	public List<MemberVO> getAll() {
		Connection con=null;
		PreparedStatement pstmt=null;
		List<MemberVO> list = new ArrayList<MemberVO>();
		ResultSet rs = null;
		MemberVO memberVO=null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberVO=new MemberVO();
				memberVO.setMemNo(rs.getString("memno"));
				memberVO.setMemId(rs.getString("memid"));
				memberVO.setPwd(rs.getString("pwd"));
				memberVO.setMemName(rs.getString("memname"));
				memberVO.setAddr(rs.getString("addr"));
				memberVO.setAllergy(rs.getString("allergy"));
				memberVO.setBirth(rs.getDate("birth"));
				memberVO.setBloodType(rs.getString("bloodtype"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setFamHistory(rs.getString("famhistory"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setIdent(rs.getString("ident"));
				memberVO.setLocNo(rs.getInt("locno"));
				memberVO.setMedHistory(rs.getString("medhistory"));
				memberVO.setMemStatus(rs.getString("memstatus"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setRegDate(rs.getDate("regdate"));
				memberVO.setSmoking(rs.getString("smoking"));
				memberVO.setStayTime(rs.getTimestamp("staytime"));
				list.add(memberVO);
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return list;
	}
	
	public MemberVO findByID(String memid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberVO memberVO =null;
		
		try {
			con=ds.getConnection();
			pstmt=con.prepareStatement(GET_ONE_STMT_BY_ID);
			pstmt.setString(1,memid);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				memberVO=new MemberVO();
				memberVO.setMemNo(rs.getString("memno"));
				memberVO.setMemId(rs.getString("memid"));
				memberVO.setPwd(rs.getString("pwd"));
				memberVO.setMemName(rs.getString("memname"));
				memberVO.setAddr(rs.getString("addr"));
				memberVO.setAllergy(rs.getString("allergy"));
				memberVO.setBirth(rs.getDate("birth"));
				memberVO.setBloodType(rs.getString("bloodtype"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setFamHistory(rs.getString("famhistory"));
				memberVO.setGender(rs.getString("gender"));
				memberVO.setIdent(rs.getString("ident"));
				memberVO.setLocNo(rs.getInt("locno"));
				memberVO.setMedHistory(rs.getString("medhistory"));
				memberVO.setMemStatus(rs.getString("memstatus"));
				memberVO.setPhone(rs.getString("phone"));
				memberVO.setRegDate(rs.getDate("regdate"));
				memberVO.setSmoking(rs.getString("smoking"));
				memberVO.setStayTime(rs.getTimestamp("staytime"));
			}
			// Handle any driver errors
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return memberVO;
	}
	@Override
	public MemberVO UpdateForBasicRecord(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_FOR_BASIC_RECORD);

			pstmt.setString(1, memberVO.getBloodType());
			pstmt.setString(2, memberVO.getSmoking());
			pstmt.setString(3, memberVO.getMedHistory());
			pstmt.setString(4, memberVO.getFamHistory());
			pstmt.setString(5, memberVO.getAllergy());
			pstmt.setString(6, memberVO.getMemId());

			pstmt.executeUpdate();	

		} catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		} finally {
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
		return memberVO;
	}	
	
	public void UpdateVerify(String memno) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_FOR_VERIFY);
			pstmt.setString(1, "正常");
			pstmt.setString(2,memno);
			pstmt.executeUpdate();	

		} catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		} finally {
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
	public void UpdateLogin(String memno,java.sql.Timestamp lastlogin) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_LOGIN);
			pstmt.setTimestamp(1, lastlogin);
			pstmt.setString(2,memno);
			pstmt.executeUpdate();	

		} catch(SQLException se) {
			throw new RuntimeException("Couldn't load database driver." +se.getMessage());
		} finally {
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
	//licnese 驗證
	@Override
	public void changeident(String memNo,String ident) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(CHANGE_IDNET);
			
			pstmt.setString(1,ident);
			pstmt.setString(2, memNo);
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
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
	}

	@Override
	public Set<LicenseVO> findByMemNo(String memNo) {
		
			Set<LicenseVO> set = new LinkedHashSet<LicenseVO>();
			LicenseVO licenseVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
		
			try {
		
				con=ds.getConnection();
				pstmt = con.prepareStatement(GET_MEM_BY_LIC);
				//SELECT licNo,memNo,licData,licStatus,licDesc,licDue FROM License WHERE memNO = ? ORDER BY LicNO
				pstmt.setString(1, memNo);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					licenseVO = new LicenseVO();
					licenseVO.setLicNo(rs.getString("licNo"));
					licenseVO.setMemNo(rs.getString("memNo"));
					licenseVO.setLicData(rs.getBytes("licData"));
					licenseVO.setLicStatus(rs.getString("licStatus"));
					licenseVO.setLicDesc(rs.getString("licDesc"));
					licenseVO.setLicDue(rs.getDate("licDue"));
					set.add(licenseVO); // Store the row in the vector
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
}
