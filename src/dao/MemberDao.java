package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.MemberDto;
//singleton
public class MemberDao {
	private static MemberDao dao = null;
	
	private MemberDao() {
		// TODO Auto-generated constructor stub
		DBConnection.initConnection();
	}
	
	public static MemberDao getInstance() {
		if(dao==null) {
			dao=new MemberDao();
		}
		return dao;
	}
	
	public boolean addMember(MemberDto dto) {
		String sql=" INSERT INTO MEMBER(ID,PWD,NAME,EMAIL,AUTH) "
				+" VALUES(?,?,?,?,3) ";
		Connection conn = null;
		PreparedStatement psmt=null;
		
		int count=0;
		
		try {
		conn=DBConnection.getConnection();
		System.out.println("1/3 addMember success");
		
		psmt=conn.prepareStatement(sql);
		psmt.setString(1, dto.getId());
		psmt.setString(2, dto.getPwd());
		psmt.setString(3, dto.getName());
		psmt.setString(4, dto.getEmail());
		System.out.println("2/3 addMember success");
		
		count=psmt.executeUpdate();
		System.out.println("3/3 addMember success");
		
		}catch(SQLException e) {
			System.out.println("addMember fail");
			e.printStackTrace();
		}finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0?true:false;
			
	}
	public boolean getId(String id) {
		String sql=" SELECT ID FROM MEMBER WHERE ID=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs=null;
		
		boolean findId=false;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 checkID success");
			psmt=conn.prepareStatement(sql);
			System.out.println(id);
			psmt.setString(1,id);
			System.out.println("2/3 checkID success");
			rs=psmt.executeQuery();
			System.out.println("3/3 checkID success");
			if(rs.next()) {
				System.out.println(rs.next());
				findId=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("checkID fail");
			e.printStackTrace();
		}finally {
			   if(conn != null) {
		            try {
		               if(conn!= null) {
		                  conn.close();
		               }
		               if(psmt != null) {
		            	   psmt.close();
		               }
		               if(rs!=null) {
		            	   rs.close();
		               }
		            } catch (SQLException e) {
		               // TODO Auto-generated catch block
		               e.printStackTrace();
		            }
		         }
				}
		return findId;
	}
	public MemberDto login(MemberDto dto) {
		String sql=" SELECT ID,NAME,EMAIL,AUTH FROM MEMBER WHERE ID=? AND PWD=? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs=null;
		
		MemberDto mem = null;
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 login success");
			psmt=conn.prepareStatement(sql);
			psmt.setString(1,dto.getId());
			psmt.setString(2, dto.getPwd());
			System.out.println("2/3 login success");
			rs=psmt.executeQuery();
			System.out.println("3/3 login success");
			if(rs.next()) {
				String id=rs.getString(1);
				String name=rs.getString(2);
				String email=rs.getString(3);
				int auth=rs.getInt(4);
				
				mem=new MemberDto(id,null,name,email,auth);
			}
			System.out.println("login success");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("login fail");
			e.printStackTrace();
		}finally {
			  DBClose.close(conn, psmt, rs);
				}
		return mem;
	}
}
