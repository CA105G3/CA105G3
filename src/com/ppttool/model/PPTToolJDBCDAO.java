package com.ppttool.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.doctor.model.DoctorVO;

import oracle.sql.BLOB;

public class PPTToolJDBCDAO implements PPTToolDAO_interface {
	private static final String dirver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String userid = "CA105G3";
	private static final String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO PPTTOOL(pptno,drno,ppt)"
			+ "VALUES('P'||lpad(to_char(PPTTOOL_SEQ.NEXTVAL), 4, '0'),?,?)";
	private static final String GET_ALL_STMT=
			"SELECT * FROM PPTTOOL ORDER BY PPTNO";
			
	private static final String GET_ONE_STMT = 
			"SELECT * from PPTTOOL WHERE pptno=?";
		
	private static final String DELETE = 
			"DELETE FROM PPTTOOL WHERE pptno = ?";
		
	private static final String UPDATE =
			"UPDATE PPTTOOL SET ppt =? WHERE pptno = ?";
	
	private static final String GET_PPTS_BY_DRNO=
			"SELECT * FROM PPTTOOL WHERE DRNO = ? ORDER BY PPTNO";
	@Override
	public void insert(PPTToolVO ppttoolvo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1,ppttoolvo.getDrno());
			pstmt.setBytes(2,ppttoolvo.getPpt());
			pstmt.executeUpdate();	
			}catch(SQLException | ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver." +e.getMessage());
			}finally{
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
	public void update(PPTToolVO ppttoolvo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(UPDATE);
			pstmt.setBytes(1, ppttoolvo.getPpt());
			pstmt.executeUpdate();	
			}catch(SQLException | ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver." +e.getMessage());
			}finally{
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
	public void delete(String pptno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(DELETE);
			pstmt.setString(1,pptno);
			pstmt.executeUpdate();	
			}catch(SQLException | ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver." +e.getMessage());
			}finally{
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
	public PPTToolVO findByPK(String Pptno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PPTToolVO ppttoolvo=null;
		ResultSet rs=null;
		// test
		File file =new File("D:/222.png");
		byte[] d;
		Blob blob;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt =con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, Pptno);
			
			rs=pstmt.executeQuery();
			
			FileOutputStream fos = new FileOutputStream(file);
			
			while(rs.next()) {
				ppttoolvo=new PPTToolVO();
				ppttoolvo.setPptno(rs.getString("pptno"));
				ppttoolvo.setDrno(rs.getString("drno"));
				//ppttoolvo.setPpt(rs.getBytes("ppt"));
				blob=rs.getBlob("ppt");
				d=blob.getBytes(1, (int)blob.length());
				fos.write(d);
				fos.close();
			}
			}catch(SQLException | ClassNotFoundException | IOException e) {
				throw new RuntimeException("Couldn't load database driver." +e.getMessage());
			}finally{
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
		return ppttoolvo;
	}

	@Override
	public List<PPTToolVO> getAll() {
		List<PPTToolVO> list = new ArrayList<PPTToolVO>();
		PPTToolVO ppttoolvo=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// test
		File file;
		byte[] d;
		Blob blob;
		int i=0;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ppttoolvo = new PPTToolVO();
				ppttoolvo.setPptno(rs.getString("pptno"));
				ppttoolvo.setDrno(rs.getString("drno"));
				ppttoolvo.setPpt(rs.getBytes("ppt"));
				//test
				file=new File("D:\\"+i+".png");
				FileOutputStream fos = new FileOutputStream(file);
				blob=rs.getBlob("ppt");
				d=blob.getBytes(1, (int)blob.length());
				fos.write(d);
				fos.close();
				list.add(ppttoolvo);
				i++;
				}
		} catch(SQLException | ClassNotFoundException | IOException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}finally{
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
	
	public List<PPTToolVO> getPPTsByDrno(String drno) {
		List<PPTToolVO> list = new ArrayList<PPTToolVO>();
		PPTToolVO ppttoolvo=null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		// test
		File file;
		byte[] d;
		Blob blob;
		int i=0;
		
		try {
			Class.forName(dirver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_PPTS_BY_DRNO);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ppttoolvo = new PPTToolVO();
				ppttoolvo.setPptno(rs.getString("pptno"));
				ppttoolvo.setDrno(rs.getString("drno"));
				ppttoolvo.setPpt(rs.getBytes("ppt"));
				//test
				file=new File("D:\\"+i+".png");
				FileOutputStream fos = new FileOutputStream(file);
				blob=rs.getBlob("ppt");
				d=blob.getBytes(1, (int)blob.length());
				fos.write(d);
				fos.close();
				list.add(ppttoolvo);
				i++;
				}
		} catch(SQLException | ClassNotFoundException | IOException e) {
			throw new RuntimeException("Couldn't load database driver." +e.getMessage());
		}finally{
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
	public static void main(String args[]) {
		PPTToolJDBCDAO dao = new PPTToolJDBCDAO();
		PPTToolVO pv = new PPTToolVO();
		List<PPTToolVO> list = new ArrayList<PPTToolVO>();
	    
		/*
		 //insert
		try {
			pv.setDrno("D0001");
			byte[] ppt =Files.readAllBytes(new File("D:/111.png").toPath());
			pv.setPpt(ppt);
			dao.insert(pv);
			System.out.println("新增測試成功!");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		
		/*
		//DELETE
		 dao.delete("P0001");
		 System.out.println("刪除測試成功!");
		*/
		
		/*
		//SELECT ONE
		 pv=dao.findByPK("P0006");
		 System.out.println(pv.getPptno());
		 System.out.println(pv.getDrno());
		 System.out.println(pv.getPpt());
		 System.out.println("查詢單一筆資料測試成功!");
		*/
		
		 //SELECT ALL
		list=dao.getAll();
		for(PPTToolVO pv2 : list) {
			System.out.println(pv2.getPptno());
			System.out.println(pv2.getDrno());
			System.out.println(pv2.getPpt());
			System.out.println("================");
		}
		System.out.println("查詢多筆資料測試成功!");
		
		 
	}
}
