package com.license.model;

import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class LicenseDAO implements LicenseDAO_interface{
	
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
	
	private static final String INSERT_STMT ="INSERT INTO License(licNo,memNo,licData,licStatus,licDesc,licDue) VALUES ('L'||lpad(to_char(license_seq.NEXTVAL), 4, '0'),?,?,?,?,?)";
	private static final String GET_ALL_STMT ="SELECT * FROM License order by licNo";
	private static final String GET_ONE_STMT = "SELECT * FROM License where licNo = ?";
	private static final String DELETE = "DELETE FROM License where licNo =　?";
	private static final String UPDATE = " UPDATE　License set memNo =?,licData=?,licStatus=?,licDesc=?,licDue=? where licNo=?";
	private static final String QUAL ="SELECT LicNo,license.MemNo,LicData,LicStatus,LicDesc,LicDue,ident From member,License where license.licStatus=? and member.memno = license.memno";
	private static final String CHANGE_STATUS=" UPDATE　License set licStatus=? where licNo=?";
	
	@Override
	public void insert(LicenseVO licenseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
		
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, licenseVO.getMemNo());
			//Blob寫入方式有三種  setBlob/setBytes/setBinaryStream
			pstmt.setBytes(2, licenseVO.getLicData());
			pstmt.setString(3,licenseVO.getLicStatus());
			pstmt.setString(4, licenseVO.getLicDesc());
			pstmt.setDate(5, licenseVO.getLicDue());
			pstmt.executeUpdate();
			
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
		}finally {
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
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	@Override
	public void update(LicenseVO licenseVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			pstmt.setString(1,licenseVO.getMemNo());
			pstmt.setBytes(2,licenseVO.getLicData());
			pstmt.setString(3, licenseVO.getLicStatus());
			pstmt.setString(4, licenseVO.getLicDesc());
			pstmt.setDate(5, licenseVO.getLicDue());
			pstmt.setString(6,licenseVO.getLicNo());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	@Override
	public void delete(String licNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
	
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1,licNo);
			pstmt.executeUpdate();
			
			} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+ e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	@Override
	public LicenseVO findByPrimaryKey(String licNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LicenseVO licenseVO = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, licNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				licenseVO = new LicenseVO();
				licenseVO.setLicNo(rs.getString(1));
				licenseVO.setMemNo(rs.getString(2));
				licenseVO.setLicData(rs.getBytes(3));
				licenseVO.setLicStatus(rs.getString(4));
				licenseVO.setLicDesc(rs.getString(5));
				licenseVO.setLicDue(rs.getDate(6));
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
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return licenseVO;
	}
	@Override
	public List<LicenseVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<LicenseVO> list = new ArrayList<>();
		LicenseVO licenseVO = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				licenseVO = new LicenseVO();
				licenseVO.setLicNo(rs.getString(1));
				licenseVO.setMemNo(rs.getString(2));
				licenseVO.setLicData(rs.getBytes(3));
				licenseVO.setLicStatus(rs.getString(4));
				licenseVO.setLicDesc(rs.getString(5));
				licenseVO.setLicDue(rs.getDate(6));
				list.add(licenseVO);
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
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public Set<QualifyVO> getChange(String licStatus) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Set<QualifyVO> set = new LinkedHashSet<QualifyVO>();
		QualifyVO qualifyVO = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(QUAL);
			pstmt.setString(1, licStatus);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				qualifyVO = new QualifyVO();
				qualifyVO.setLicNo(rs.getString(1));
				qualifyVO.setMemNo(rs.getString(2));
				qualifyVO.setLicData(rs.getBytes(3));
				qualifyVO.setLicStatus(rs.getString(4));
				qualifyVO.setLicDesc(rs.getString(5));
				qualifyVO.setLicDue(rs.getDate(6));
				qualifyVO.setIdent(rs.getString(7));
				set.add(qualifyVO);
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
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return set;
	}
	
	
	public static void main(String[] args) {
		LicenseVO vo= new LicenseVO();
		LicenseDAO dao = new LicenseDAO();
		
//		測試INSERT
//		vo.setMemNo("M0002");
//		vo.setLicStatus("生效中");
//		vo.setLicDesc("撿來的");
//		vo.setLicData(null);
//		Date date = Date.valueOf("2020-10-22");
//		vo.setLicDue(date);
//		dao.insert(vo);
		
		//測試update
//		vo.setMemNo("M0007");
//		vo.setLicStatus("已失效");
//		Date date = Date.valueOf("2020-10-30");
//		vo.setLicDue(date);
//		vo.setLicDesc("不知道說甚麼");
//		vo.setLicNo("L0001");
//		dao.update(vo);
		
		//測試delete
//		dao.delete("L0001");
		
		//測試findByPrimaryKey
//		vo = dao.findByPrimaryKey("L0010");
//		System.out.println(vo.getLicNo());
//		System.out.println(vo.getMemNo());
//		System.out.println(vo.getLicStatus());
//		System.out.println(vo.getLicDesc());
//		System.out.println(vo.getLicData());
//		System.out.println(vo.getLicDue());
		
		
		//測試list
//		List<LicenseVO> list = dao.getAll();
//		Iterator<LicenseVO> it = list.iterator();
//		if(it.hasNext()) {
//			LicenseVO lvo = it.next();
//			System.out.println(lvo.getLicNo());
//			System.out.println(lvo.getMemNo());
//			System.out.println(lvo.getLicStatus());
//			System.out.println(lvo.getLicDesc());
//			System.out.println(lvo.getLicData());
//			System.out.println(lvo.getLicDue());
//		}
		//測試qualify
//		List<QualifyVO> list = dao.getChange("M0017");
//		Iterator<QualifyVO> it = list.iterator();
//		if(it.hasNext()) {
//			QualifyVO lvo = it.next();
//			System.out.println(lvo.getLicNo());
//			System.out.println(lvo.getMemNo());
//			System.out.println(lvo.getLicData());
//			System.out.println(lvo.getLicStatus());
//			System.out.println(lvo.getLicDesc());
//			System.out.println(lvo.getLicDue());
//			System.out.println(lvo.getIdent());
//		}
		
	}
	@Override
	public void changestatus(String licNo,String licStatus) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con=ds.getConnection();
			pstmt = con.prepareStatement(CHANGE_STATUS);
			pstmt.setString(1, licStatus);
			pstmt.setString(2,licNo);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
}
