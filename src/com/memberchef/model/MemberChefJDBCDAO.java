package com.memberchef.model;

import java.util.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;

public class MemberChefJDBCDAO implements MemberChefDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G3";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
		"INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M0002', ?, ?, ?, ?, ?, ?)";
//		"INSERT INTO memberchef VALUES ('CHEF'||lpad(to_char(memberchef_seq.NEXTVAL), 4, '0'),'M'||LPAD(to_char(member_seq.CURRVAL), 4, '0'), ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT chefno,memno,chefdescrip,chefstatus,chefphone,chefaddr,chefrep from memberchef order by chefno";
	private static final String GET_ONE_STMT = 
		"SELECT chefno,memno,chefdescrip,chefstatus,chefphone,chefaddr,chefrep from memberchef where chefno=?";
	private static final String DELETE = 
		"DELETE FROM memberchef where chefno = ?";
	private static final String UPDATE = 
		"UPDATE memberchef set chefpic=?, chefdescrip=?, chefstatus=?, chefphone=?, chefaddr=?, chefrep=? where chefno = ?";
	
	@Override
	public void insert(MemberChefVO memberChefVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			Blob blob = con.createBlob();
			blob.setBytes(1, memberChefVO.getChefPic());
			pstmt.setBlob(1, blob);
			pstmt.setString(2, memberChefVO.getChefDescrip());
			pstmt.setString(3, memberChefVO.getChefStatus());
			pstmt.setString(4, memberChefVO.getChefPhone());
			pstmt.setString(5, memberChefVO.getChefAddr());
			pstmt.setString(6, memberChefVO.getChefRep());

			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public void update(MemberChefVO memberChefVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);		

			Blob blob = con.createBlob();
			blob.setBytes(1, memberChefVO.getChefPic());
			pstmt.setBlob(1, blob);
			pstmt.setString(2, memberChefVO.getChefDescrip());
			pstmt.setString(3, memberChefVO.getChefStatus());
			pstmt.setString(4, memberChefVO.getChefPhone());
			pstmt.setString(5, memberChefVO.getChefAddr());
			pstmt.setString(6, memberChefVO.getChefRep());
			pstmt.setString(7, memberChefVO.getChefNo());

			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public void delete(String chefno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, chefno);

			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
	public MemberChefVO findByPrimaryKey(String chefno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberChefVO memberChefVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, chefno);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberChefVO = new MemberChefVO();
				memberChefVO.setChefNo(rs.getString(1));
				memberChefVO.setMemNo(rs.getString(2));
//				memberChefVO.setChefPic(rs.getBytes(3));
				memberChefVO.setChefDescrip(rs.getString(3));
				memberChefVO.setChefStatus(rs.getString(4));
				memberChefVO.setChefPhone(rs.getString(5));
				memberChefVO.setChefAddr(rs.getString(6));
				memberChefVO.setChefRep(rs.getString(7));
			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
		return memberChefVO ;
	}

	@Override
	public List<MemberChefVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MemberChefVO> list = new ArrayList<MemberChefVO>();
		MemberChefVO memberChefVO = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberChefVO = new MemberChefVO();
				memberChefVO.setChefNo(rs.getString(1));
				memberChefVO.setMemNo(rs.getString(2));
				memberChefVO.setChefPic(rs.getBytes(3));
				memberChefVO.setChefDescrip(rs.getString(3));
				memberChefVO.setChefStatus(rs.getString(4));
				memberChefVO.setChefPhone(rs.getString(5));
				memberChefVO.setChefAddr(rs.getString(6));
				memberChefVO.setChefRep(rs.getString(7));
				list.add(memberChefVO);
			}
			
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+ e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "	+ se.getMessage());
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
		return list;
	}

	public static byte[] getPictureByteArray(String path) throws IOException {
		File file = new File(path);
		FileInputStream fis = new FileInputStream(file);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192];
		int i;
		while ((i = fis.read(buffer)) != -1) {
			baos.write(buffer, 0, i);
		}
		baos.close();
		fis.close();

		return baos.toByteArray();
	}
			
	public static void main(String[] args) {
		MemberChefJDBCDAO dao = new MemberChefJDBCDAO();
		
		// 新增
		MemberChefVO memberChefVO1 = new MemberChefVO();

		byte[] pic1 = null;
		try {
			pic1 = getPictureByteArray("WebContent/imgs/chef.jpg");
		} catch (IOException e) {
			e.printStackTrace();
		}
		memberChefVO1.setChefPic(pic1);
		memberChefVO1.setChefDescrip("我是食神");
		memberChefVO1.setChefStatus("啓用");
		memberChefVO1.setChefPhone("54875487");
		memberChefVO1.setChefAddr("少林廚藝學苑");
		memberChefVO1.setChefRep("方丈");
		dao.insert(memberChefVO1);
		
		// 修改
		MemberChefVO memberChefVO2 = new MemberChefVO();
		
		memberChefVO2.setChefNo("CHEF0002");
		byte[] pic2 = null;
		try {
			pic2 = getPictureByteArray("WebContent/imgs/chef.jpg");
		} catch (IOException e) {
			e.printStackTrace();
		}
		memberChefVO2.setChefPic(pic2);
		memberChefVO2.setChefDescrip("我是特級食神");
		memberChefVO2.setChefStatus("啓用");
		memberChefVO2.setChefPhone("54875487");
		memberChefVO2.setChefAddr("少林廚藝學苑");
		memberChefVO2.setChefRep("火焰方丈");
		dao.update(memberChefVO2);
				
		// 刪除
		dao.delete("CHEF0002");
		
		// 查詢一筆
		MemberChefVO memberChefVO3 = dao.findByPrimaryKey("CHEF0002");
		System.out.print(memberChefVO3.getChefNo() + " , ");
		System.out.print(memberChefVO3.getMemNo() + " , ");
		System.out.print(memberChefVO3.getChefDescrip() + " , ");
		System.out.print(memberChefVO3.getChefStatus() + " , ");
		System.out.print(memberChefVO3.getChefPhone() + " , ");
		System.out.print(memberChefVO3.getChefAddr() + " , ");
		System.out.println(memberChefVO3.getChefRep());
		System.out.println("================================");
		
		// 查詢全部
		List<MemberChefVO> memberCheflist = dao.getAll();
		for(MemberChefVO amemberChefVO : memberCheflist) {
			System.out.print(amemberChefVO.getChefNo() + " , ");
			System.out.print(amemberChefVO.getMemNo() + " , ");
			System.out.print(amemberChefVO.getChefDescrip() + " , ");
			System.out.print(amemberChefVO.getChefStatus() + " , ");
			System.out.print(amemberChefVO.getChefPhone() + " , ");
			System.out.print(amemberChefVO.getChefAddr() + " , ");
			System.out.println(amemberChefVO.getChefRep());
			System.out.println("--------------------------------");
		}
	}
}
