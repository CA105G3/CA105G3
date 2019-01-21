package com.doctor.model;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.doctoravailable.model.DravailableVO;

public class DoctorJDBCDAO implements DoctorDAO_interface{
	private final String driver = "oracle.jdbc.driver.OracleDriver";
	private final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	private final String user = "CA105G3";
	private final String password = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO DOCTOR VALUES "
			+ "('D'||lpad(to_char(doctor_seq.NEXTVAL), 4, '0'),?,?,?,?,?,?,?)";
	private static final String UPDATE_STMT = "UPDATE DOCTOR SET "
			+ "MEMNO = ?, RESUME = ?, ISONLINE = ?, STATUS = ?, MAJOR = ?, FEE = ?, PHOTO = ? WHERE DRNO = ?";  
	private static final String DELETE_STMT = "DELETE FROM DOCTOR WHERE DRNO = ?";
	private static final String FIND_BY_PK = "SELECT * FROM DOCTOR WHERE DRNO = ?";	
	private static final String FIND_BY_MAJOR = "SELECT * FROM DOCTOR WHERE MAJOR = ?";
	private static final String GET_ALL = "SELECT * FROM DOCTOR ORDER BY DRNO";
	private static final String GET_MAJOR = "SELECT DISTINCT MAJOR FROM DOCTOR";
	private static final String GET_DRNO = "SELECT DRNO FROM DOCTOR WHERE MEMNO = ?";
	private static final String UPDATE_ISONLINE_BY_MEMNO = "UPDATE DOCTOR SET ISONLINE = ? WHERE MEMNO = ? ";

	@Override
	public void insert(DoctorVO doctorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, doctorVO.getMemno());
			pstmt.setString(2, doctorVO.getResume());
			pstmt.setString(3, doctorVO.getIsonline());
			pstmt.setString(4, doctorVO.getStatus());
			pstmt.setString(5, doctorVO.getMajor());
			pstmt.setInt(6, doctorVO.getFee());
			pstmt.setBytes(7, doctorVO.getPhoto());
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage()); 
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	@Override
	public void update(DoctorVO doctorVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STMT);
			
			pstmt.setString(1, doctorVO.getMemno());
			pstmt.setString(2, doctorVO.getResume());
			pstmt.setString(3, doctorVO.getIsonline());
			pstmt.setString(4, doctorVO.getStatus());
			pstmt.setString(5, doctorVO.getMajor());
			pstmt.setInt(6, doctorVO.getFee());
			pstmt.setBytes(7, doctorVO.getPhoto());
			pstmt.setString(8, doctorVO.getDrno());
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage()); 
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public void delete(String drno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, drno);
			pstmt.executeUpdate();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	
	}

	@Override
	public DoctorVO findByPK(String drno) {
		DoctorVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			pstmt.clearParameters();
			while(rs.next()) {
				dvo = new DoctorVO();
				dvo.setDrno(rs.getString(1));
				dvo.setMemno(rs.getString(2));
				dvo.setResume(rs.getString(3));
				dvo.setIsonline(rs.getString(4));
				dvo.setStatus(rs.getString(5));
				dvo.setMajor(rs.getString(6));
				dvo.setFee(rs.getInt(7));
				dvo.setPhoto(rs.getBytes(8));
			}
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return dvo;
	}

	public List<DoctorVO> findByMajor(String major) {
		List<DoctorVO> list = new ArrayList<DoctorVO>();
		DoctorVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_BY_MAJOR);
			pstmt.setString(1, major);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dvo = new DoctorVO();
				dvo.setDrno(rs.getString(1));
				dvo.setMemno(rs.getString(2));
				dvo.setResume(rs.getString(3));
				dvo.setIsonline(rs.getString(4));
				dvo.setStatus(rs.getString(5));
				dvo.setMajor(rs.getString(6));
				dvo.setFee(rs.getInt(7));
				dvo.setPhoto(rs.getBytes(8));
				list.add(dvo);
			}
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	
	@Override
	public List<DoctorVO> getAll() {
		List<DoctorVO> list = new ArrayList<DoctorVO>();
		DoctorVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			pstmt.clearParameters();
			while(rs.next()) {
				dvo = new DoctorVO();
				dvo.setDrno(rs.getString(1));
				dvo.setMemno(rs.getString(2));
				dvo.setResume(rs.getString(3));
				dvo.setIsonline(rs.getString(4));
				dvo.setStatus(rs.getString(5));
				dvo.setMajor(rs.getString(6));
				dvo.setFee(rs.getInt(7));
				dvo.setPhoto(rs.getBytes(8));
				list.add(dvo);
			}
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public List<DoctorVO> getMajor(){
		List<DoctorVO> list = new ArrayList<DoctorVO>();
		DoctorVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_MAJOR);
			rs = pstmt.executeQuery();
			pstmt.clearParameters();
			while(rs.next()) {
				dvo = new DoctorVO();
				dvo.setMajor(rs.getString("MAJOR"));
				list.add(dvo);
			}
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public void UpdateIsonline(String isonline,String memno) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_ISONLINE_BY_MEMNO);
			pstmt.setString(1, isonline);
			pstmt.setString(2, memno);
			pstmt.executeUpdate();
			pstmt.clearParameters();
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	
	public DoctorVO getDrno(String memno) {
		DoctorVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_DRNO);
			pstmt.setString(1, memno);
			rs = pstmt.executeQuery();
			pstmt.clearParameters();
			while(rs.next()) {
				dvo = new DoctorVO();
				dvo.setDrno(rs.getString("DRNO"));
			}
		} catch(ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return dvo;
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
	
	public static void readPicture(byte[] bytes, String path) throws IOException {
		FileOutputStream fos = new FileOutputStream(path);
		fos.write(bytes);
		fos.flush();
		fos.close();
	}
	public static void main(String[] args) throws IOException {
		DoctorJDBCDAO dao = new DoctorJDBCDAO();
		//新增
//		DoctorVO dvo1 = new DoctorVO();
//		dvo1.setMemno("M0020");
//		dvo1.setResume("【我們心理諮商所】合作心理師\r\n" + 
//				"【龍華科技大學】專任諮商心理師\r\n" + 
//				"【新北市泰山高中】專任輔導教師\r\n" + 
//				"【新北市泰山區】國小專任輔導教師\r\n" + 
//				"​【亞東醫院精神科自殺防治中心】輔導員\r\n" + 
//				"【新北市厚德國小】高風險家庭團體帶領者\r\n" + 
//				"【法務部矯正署台北監獄】性侵加害人團體觀察員");
//		dvo1.setIsonline("線上");
//		dvo1.setStatus("生效中");
//		dvo1.setMajor("心理諮商");
//		dvo1.setFee(6666);
//		byte[] pic;
//		try {
//			pic = getPictureByteArray("C:/Users/Java/git/CA105G3/WebContent/images/07.jpg");	
//			dvo1.setPhoto(pic);
//		} catch (IOException e) {
//			e.printStackTrace(System.err);
//		}
//		dao.insert(dvo1);
//		System.out.println("新增成功!");
		//修改
//		DoctorVO dvo2 = new DoctorVO();
//		dvo2.setMemno("M0015");
//		dvo2.setResume("中華民國外科醫師、無黨籍政治人物，現任臺北市市長。\r\n" + 
//				"國立臺灣大學醫學院臨床醫學研究所博士畢業，曾任臺大醫院急診部醫師、臺大醫院創傷醫學部主任、臺大醫學院教授，\r\n" + 
//				"專長為外科重症醫學、器官移植 、人工器官等，是臺灣第一個急診與重症加護專職醫生，\r\n" + 
//				"為臺灣器官標準移植程序的建立者，也是首位將葉克膜（ECMO）技術引進臺灣的醫師。\r\n" + 
//				"2018年任命(學姊)黃瀞瑩為臺北市政府媒體事務組組員" );
//		dvo2.setIsonline("線上");
//		dvo2.setStatus("失效");
//		dvo2.setMajor("外科");
//		dvo2.setFee(4);
//		byte[] pic2;
//		try {
//			pic2 = getPictureByteArray("images/07.jpg");	
//			dvo2.setPhoto(pic2);
//		} catch (IOException e) {
//			e.printStackTrace(System.err);
//		}
//		dvo2.setDrno("D0002");
//		dao.update(dvo2);
//		System.out.println("修改成功");
		//刪除
//		dao.delete("D0001");
		//findByPK
//		DoctorVO dvo3 = dao.findByPK("D0007");
//		System.out.println(dvo3.getDrno());
//		System.out.println(dvo3.getMemno());
//		System.out.println(dvo3.getResume());
//		System.out.println(dvo3.getIsonline());
//		System.out.println(dvo3.getStatus());
//		System.out.println(dvo3.getMajor());
//		System.out.println(dvo3.getFee());
//		readPicture(dvo3.getPhoto(), "images/" + dvo3.getDrno() + ".jpg");

		//finByMajor
	
//		List<DoctorVO> list0 = dao.findByMajor("外科");
//		for(DoctorVO dvo : list0) {
//			System.out.println(dvo.getDrno());
//			System.out.println(dvo.getMemno());
//			System.out.println(dvo.getResume());
//			System.out.println(dvo.getIsonline());
//			System.out.println(dvo.getStatus());
//			System.out.println(dvo.getMajor());
//			System.out.println(dvo.getFee());
//			readPicture(dvo.getPhoto(), "images/" + dvo.getDrno() + ".jpg");
//			System.out.println("--------------------------------------------");
//		}
		
		//findAll
//		List<DoctorVO> list = dao.getAll();
//		for(DoctorVO dvo : list) {
//			System.out.println(dvo.getDrno());
//			System.out.println(dvo.getMemno());
//			System.out.println(dvo.getResume());
//			System.out.println(dvo.getIsonline());
//			System.out.println(dvo.getStatus());
//			System.out.println(dvo.getMajor());
//			System.out.println(dvo.getFee());
//			readPicture(dvo.getPhoto(), "images/" + dvo.getDrno() + ".jpg");
//			System.out.println("--------------------------------------------");
//		}
		//getMajor
//		List<DoctorVO> list = dao.getMajor();
//		for(DoctorVO dvo : list) {
//			System.out.println(dvo.getMajor());
//		}
		
		//updateIsOnline
//		dao.UpdateIsonline("離線", "M0002");
	}

	@Override
	public void UpdateStatus(String status, String memno) {
		// TODO Auto-generated method stub
		
	}
	
}
