package com.doctoravailable.model;

import java.sql.*;
import java.sql.Date;
import java.util.*;

public class DravailableJDBCDAO implements DravailableDAO_interface{
	final String driver = "oracle.jdbc.driver.OracleDriver";
	final String url = "jdbc:oracle:thin:@localhost:1521:XE";
	final String user = "CA105G3";
	final String password = "123456";
	
//	private static final String INSERT_STMT = "INSERT INTO DOCTORAVAILABLE VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),?,?,?)";
	private static final String INSERT_STMT = "INSERT INTO DOCTORAVAILABLE VALUES (to_char(current_date, 'YYYYMMDD')||'-'||lpad(to_char(doctoravailable_seq.NEXTVAL), 4, '0'),?,TO_DATE(?, 'YYYY-MM'),?)";
//	private static final String UPDATE_STMT = "UPDATE DOCTORAVAILABLE SET DRAYM = ?, DRAVA = ? WHERE DRNO = ?";  //實際修改預約時間時，where後面用什麼欄位?
//	private static final String UPDATE_STMT = "UPDATE DOCTORAVAILABLE SET DRAYM = TO_DATE(?, 'YYYY-MM'), DRAVA = ? WHERE DRAVANO = ?";  //實際修改預約時間時，where後面用什麼欄位?
	private static final String UPDATE_STMT = "UPDATE DOCTORAVAILABLE SET DRAVA = ? WHERE DRAVANO = ?";  //實際修改預約時間時，where後面用什麼欄位?
	private static final String DELETE_STMT = "DELETE FROM DOCTORAVAILABLE WHERE DRNO = ?";
	private static final String FIND_BY_PK = "SELECT * FROM DOCTORAVAILABLE WHERE DRAVANO = ? AND ";
//	private static final String FIND_BY_DRNO = "SELECT * FROM DOCTORAVAILABLE WHERE DRNO = ? AND TO_CHAR(?, 'YYMM') >= TO_CHAR(SYSDATE, 'YYMM')";
	private static final String FIND_BY_DRNO = "SELECT * FROM DOCTORAVAILABLE WHERE DRNO = ?";
	private static final String GET_ALL = "SELECT * FROM DOCTORAVAILABLE";
	private static final String Get_DRAYM_BY_DRNO = "SELECT TO_CHAR(DRAYM, 'YYYY-MM') FROM DOCTORAVAILABLE WHERE DRNO = ?";
	@Override
	public void insert(DravailableVO dravailableVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, dravailableVO.getDrno());
			pstmt.setString(2, dravailableVO.getDraym().toString().substring(0, 7));
			pstmt.setString(3, dravailableVO.getDrava());
			
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
	public void update(DravailableVO dravailableVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STMT);
			
//			pstmt.setString(1, dravailableVO.getDraym().toString().substring(0, 7));
			pstmt.setString(1, dravailableVO.getDrava());
			pstmt.setString(2, dravailableVO.getDravano());
			
			pstmt.executeUpdate();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch(SQLException e) {
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
	public void delete(String dravano) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE_STMT);
			pstmt.setString(1, dravano);
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
	public DravailableVO findByPK(String dravano) {
		DravailableVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_BY_PK);
			pstmt.setString(1, dravano);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dvo = new DravailableVO();
				dvo.setDravano(rs.getString(1));
				dvo.setDrno(rs.getString(2));
				dvo.setDraym(rs.getDate(3));
				dvo.setDrava(rs.getString(4));
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
	@Override
	public List<DravailableVO> findByDrno(String drno) {
		List<DravailableVO> list = new ArrayList<DravailableVO>();
		DravailableVO dvo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_BY_DRNO);
			pstmt.setString(1, drno);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dvo = new DravailableVO();
				dvo.setDravano(rs.getString(1));
				dvo.setDrno(rs.getString(2));
				dvo.setDraym(rs.getDate(3));
				dvo.setDrava(rs.getString(4));
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
	public List<DravailableVO> getAll() {
		List<DravailableVO> list = new ArrayList<DravailableVO>(); 
		DravailableVO dao = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				dao = new DravailableVO();
				dao.setDravano(rs.getString(1));
				dao.setDrno(rs.getString(2));
				dao.setDraym(rs.getDate(3));
				dao.setDrava(rs.getString(4));
				list.add(dao);
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

	public static void main(String[] args) {
		DravailableJDBCDAO dao = new DravailableJDBCDAO();
		
		
		//新增
//		DravailableVO dvo1 = new DravailableVO();
//		dvo1.setDrno("D0011");
//		dvo1.setDraym(Date.valueOf("2018-12-22"));
//		dvo1.setDrava("010001101111000101001001011000100001011010001101101010100011000000100111101111001110111110110");
//		dao.insert(dvo1);
		//修改
		DravailableVO dvo2 = new DravailableVO();
		dvo2.setDravano("20181222-0018");
//		dvo2.setDraym(Date.valueOf("2018-12-9"));
		dvo2.setDrava("111111000010011110000110100000011010101100110000001001011001100001011010001101111000011111100");
		dao.update(dvo2);
//		//刪除
//		dao.delete("D0005");
		//findByPK
//		DravailableVO dvo3 = dao.findByPK("20181211-0016");
//		System.out.println(dvo3.getDravano());
//		System.out.println(dvo3.getDrno());
//		System.out.println(dvo3.getDraym());
//		System.out.println(dvo3.getDrava());
		//findByDrno
//		List<DravailableVO> list1 = dao.findByDrno("D0004");
//		for(DravailableVO dvo : list1) {
//			System.out.println(dvo.getDravano());
//			System.out.println(dvo.getDrno());
//			System.out.println(dvo.getDraym());
//			System.out.println(dvo.getDrava());
//			System.out.println("--------------------------------------");
//		}
		//getAll
//		List<DravailableVO> list2 = dao.getAll();
//		for(DravailableVO dvo : list2) {
//			System.out.println(dvo.getDravano());
//			System.out.println(dvo.getDrno());
//			System.out.println(dvo.getDraym());
//			System.out.println(dvo.getDrava());
//			System.out.println("--------------------------------------");
//		}
	}
	
	
}
