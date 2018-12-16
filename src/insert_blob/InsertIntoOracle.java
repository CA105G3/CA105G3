package insert_blob;
/*
		1.在WebContent底下創建oracle_imgs資料夾
		2.在oracle_imgs裡創建需要匯入BLOB的Table同名資料夾的
		3.CA105G3目前是Doctor、Impression、License、MedicalOrder、MemberChef、Menu有Blob欄位，故創建以上Table的同名資料夾
		4.將Doctor Table需要用的圖檔丟入Doctor資料夾，名稱不限，數量需超過或等同要匯入的資料筆數 
		5.圖片將按照資料夾內的排序被匯入資料庫
		6.會蓋掉原檔案
		7.Table欄位未記錄副檔名
*/
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class InsertIntoOracle {
	
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String USER = "CA105G3";
	private static final String PASSWORD = "123456";
	private static final String picDirPath = "WebContent/oracle_imgs";
	
	
	
	public static void main(String[] args) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ResultSetMetaData rsmd = null;
		PreparedStatement pstmtForUpdate = null;
		
		File dir = new File(picDirPath);
		File[] files = dir.listFiles();		
		String[] dirNames = new String[files.length];
		for(int i=0;i<dirNames.length;i++) {
			dirNames[i] = files[i].getName();	
		}
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
			for(int k=0;k<dirNames.length;k++) {
				
				StringBuilder sb = new StringBuilder();
				sb.append("SELECT * FROM ").append(dirNames[k]);
				
				pstmt = con.prepareStatement(sb.toString(),ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs = pstmt.executeQuery();
				rsmd = rs.getMetaData();
				
				if(rs.last());
				int dataNumbers = rs.getRow();
				
				rs.beforeFirst();
				
				int numberOfColumns = rsmd.getColumnCount();
				
				for (int i = 1; i <= numberOfColumns; i++) {
					
					rs.beforeFirst();
					
					if(rsmd.getColumnTypeName(i) == "BLOB") {
						
						StringBuilder picLocation = new StringBuilder();
						picLocation.append(picDirPath).append("/").append(dirNames[k]);
						
						for(int j=0;j<dataNumbers;j++) {
						
							File file = new File(picLocation.toString());
							File[] pics = file.listFiles();		
							byte[] picIn = getPictureByteArray(pics[j]);
							rs.next();
							StringBuilder UPDATE_STMT = new StringBuilder();
							
							UPDATE_STMT.append("UPDATE ").append(dirNames[k]).append(" SET ").append(rsmd.getColumnName(i))
														 .append(" = ? where ").append(rsmd.getColumnName(1)).append(" = '")
														 .append(rs.getString(1)).append("'");
							System.out.println("下一筆輸入進當前PreparedStatement  表格名稱: "+ dirNames[k] + "  欄位名稱: "+rsmd.getColumnName(i) +"  主鍵值:"+rs.getString(1));
							
							pstmtForUpdate  = con.prepareStatement(UPDATE_STMT.toString());
							
							pstmtForUpdate.setBytes(1, picIn);
							pstmtForUpdate.executeUpdate();
						}
					}
				
				}
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally{
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static byte[] getPictureByteArray(File file) throws IOException {
		
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
	
}
