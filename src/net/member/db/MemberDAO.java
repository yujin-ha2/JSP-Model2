package net.member.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.funding.open.db.MakerBean;

public class MemberDAO {

	Connection con;
	ResultSet rs;
	PreparedStatement pstmt;
	DataSource ds;
	
	public MemberDAO() {
		try{         
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/funding");		
			con = ds.getConnection();
			
		}catch(Exception e){
			System.out.println("DB_Connect : " + e.toString());
		}	
	}
	
	public void ResouceClose(){	
		try {
			if(pstmt != null){
				pstmt.close();
			}
			if(rs!= null){
				rs.close();
			}
			if(con != null){ 
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//ȸ������ ó�� - ��ΰ�
	public boolean insertMember(MemberBean mb) {
	    int result = 0; //ȸ������ ��������
	    String sql = "insert into member (id,pwd,name,phone,email) values(?,?,?,?,?)";
		try {
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPwd());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getPhone());
			pstmt.setString(5, mb.getEmail());
			
			result = pstmt.executeUpdate();
			
			if(result != 0){
                return true;
            }
			
		} catch (Exception e) {
			System.out.println("insertMember:"+e.toString());
		}finally {
			ResouceClose();
		}
        return false;
	}
	
	//�α��ν� ����� Ȯ�� - ��ΰ�
	public int LoginUserCheck(String id,String pwd) {
		String sql = "select pwd from member where id=?";
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pwd.equals(rs.getString("pwd"))) {
					return 1;
				}
			}
		} catch (Exception e) {
			System.out.println("userCheck" + e);
		}finally {
			ResouceClose();
		}
		return  0;
	}
	
	//ȸ������ �� ���̵� ��ȿ�� üũ - ��ΰ�
	public int idCheck(String id) {
		String sql = "select id from member where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 1;
			}
		} catch (Exception e) {
			System.out.println("idCheck"+e.toString());
		}finally {
			ResouceClose();
		}
		return 0;
	}
	

	//ȸ�� ���� Ȯ�� - ��ΰ�
	public MemberBean InfoMember (String id){
        MemberBean mb = null;
        String sql ="select * from member where id=?";
        try {
			pstmt = con.prepareStatement(sql);
        	pstmt.setString(1, id);
        	rs = pstmt.executeQuery();
        	
        	if(rs.next()){
        		mb = new MemberBean();
        		mb.setId(rs.getString("id"));
        		mb.setPwd(rs.getString("pwd"));
        		mb.setName(rs.getString("name"));
        		mb.setPhone(rs.getString("phone"));
        		mb.setEmail(rs.getString("email"));
        		mb.setProfile(rs.getString("profile"));
        		mb.setCoupon(rs.getInt("coupon"));
        		mb.setPoint(rs.getInt("point"));
        	}
		} catch (Exception e) {
			System.out.println("InfoMember : "+e);
		}finally{
			ResouceClose();	
		}
        return mb;
	}
	
	//ȸ�� ���� ���� - ��ΰ�
	public int updateMember(MemberBean mb){
		int result = 0;
		String sql = "update member set email=?, phone=? where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getEmail());
			pstmt.setString(2, mb.getPhone());
			pstmt.setString(3, mb.getId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ResouceClose();
		}
		return result;
	}

	//����� ���̵� ã�� - ��ΰ�
	public String findId(String email){
		String sql ="select id from member where email=?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ResouceClose();
		}
		return null;
	}
	
	//����� ��й�ȣ ã�� ���� ����� Ȯ��  - ��ΰ�
	public int checkMember(MemberBean mb){
		String sql = "select email from member where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getString("email").equals(mb.getEmail())){
					return 2;  //���
				}else{
					return 1;  //�̸����� ��ġ���� �ʽ��ϴ�.
				}
        	}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally{
			ResouceClose();
		}
		return 0;  //��ġ�ϴ� ȸ�� ������ �����ϴ�.
	}
	
	//��й�ȣ ���� - ��ΰ�
	public int updatePwd(MemberBean mb) {
		int result = 0;
		String sql = "update member set pwd=? where id=?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getPwd());
			pstmt.setString(2, mb.getId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			ResouceClose();
		}
		return result;
	}
	
	//����� Ż�� ó�� - ��ΰ�
	public int deleteMember(MemberBean mb){
		String sql = "delete from member where id=? and pwd=?";
		
		try {
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPwd());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			ResouceClose();
		}
		return 0;
		
	}

	//���������� - ��â��
	public MemberBean getOneMember(String id) {
		MemberBean bean = null;
		String sql = "select email, name, phone, point, coupon_check, maker_name from member where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new MemberBean();
				bean.setEmail(rs.getString("email"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getString("phone"));
				bean.setPoint(rs.getInt("point"));
				bean.setCoupon(rs.getInt("coupon_check"));
				bean.setMakerNo(rs.getInt("makerNo"));
			}

		} catch (Exception e) {
			System.out.println("getOneMember error: "+ e);
		}finally {
			ResouceClose();
		}
		return bean;
	}

	//����� Ÿ�� üũ - ��â��
	public int UserTypeCheck(String id) {
		String sql = "select makerNo from member where id=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getInt(1) != 0)
					return 1;
			}

		} catch (Exception e) {
			System.out.println("UserTypeCheck error: "+ e);
		}finally {
			ResouceClose();
		}
		return 0;
	}
 
	// ���� �߱� ó�� - ��â��
	public int issueCoupon(String id) {
		
		try {
			String sql = "update member set coupon = 1 where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			return pstmt.executeUpdate();
							
		} catch (Exception e) {
			System.out.println("issueCoupon error : "+ e);
		}finally {
			ResouceClose();
		}
		return 0;
	}

	//����������(������)������, ���� �ݵ��ϱ� ���� �޾ƿ��� - ������
	public int myFundingCount(String id) { 
		String sql = "select count(userId) from fundingorder where userId=?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}else {
				return 0;
			}
		} catch (Exception e) {
			System.out.println("myFundingCount ���� : " + e);
		} finally{
			ResouceClose();
		}
		return 0;
	}

	//������������ ������ �̹��� ������Ʈ - ������
	public void profileImgUpdate(String file, String id) {
		try {
			String sql = "update member set profile = ? where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,file);
			pstmt.setString(2,id);
			pstmt.executeUpdate();
							
		} catch (Exception e) {
			System.out.println("getMakerFundingCnt error : " + e);
		}finally {
			ResouceClose();
		}
	}

	//����������(������) ������, �ȷο��� ȸ�縮��Ʈ �޾ƿ��� - ������
	public Vector<MakerBean> myFollowList(String id) {
		
		Vector<MakerBean> v = new Vector<MakerBean>();
		MakerBean bean = null;

		String sql = "select profile, userId, name from maker where userId in (select companyId from companyfollow where userId = ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					bean = new MakerBean();
					bean.setProfile(rs.getString("profile"));
					bean.setUserId(rs.getString("userId"));
					bean.setName(rs.getString("name"));
					v.add(bean);
				}while(rs.next());
			} 
		} catch (Exception e) {
			System.out.println("myFollowList error : " + e);
		} finally{
			ResouceClose();
		}
		
		return v;
	}

	
}
