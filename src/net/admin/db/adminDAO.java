package net.admin.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.funding.db.AllFundingInfoBean;
import net.funding.open.db.FundingInfoBean;
import net.member.db.MemberBean;

public class adminDAO {

	DataSource ds;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public adminDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/funding");
		}catch(Exception e) {
			System.out.println("DB���� ����: " +e);
			return;
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
	
	//���� ��û�� ������Ʈ ����Ʈ �޾ƿ��� - ������
	public List<ApprovalProjectBean> getApprovelist() {
		List<ApprovalProjectBean> approvalList = new ArrayList<ApprovalProjectBean>();
		ApprovalProjectBean bean = null;
		try {
			String sql = "select a.fundingId, m.name, f.title, a.submitDate " + 
						"from allproject a " + 
						"join maker m " + 
						"on a.userId = m.userId " + 
						"join fundinginfo f " + 
						"on a.fundingId = f.fundingId " + 
						"where a.status = 'submission';";  
			 
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new ApprovalProjectBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setMakerName(rs.getString("name"));
				bean.setProjectTitle(rs.getString("title"));
				bean.setSubmitDate(rs.getTimestamp("submitDate")); 
				
				approvalList.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		return approvalList;
	}

	//������Ʈ (����/�ݷ�) �亯 ó��
	public int ApproveChangeApproveState(int fundingId, String comment, String projectStatus) {
		int result = 0;
		String dateName = (projectStatus.equals("approve")) ? "approveDate" : "rejectDate";
		String sql = "update allproject set status=?, comment=?, "+dateName+"=? where fundingId=?";
	
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, projectStatus);
			pstmt.setString(2, comment);
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(3, currentTime);
			pstmt.setInt(4, fundingId);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("ApproveChangeState �޼ҵ� ���� " + e);
		} finally {
			ResouceClose();
		}
		return result;
	}

	//�Ϲ� ȸ������Ʈ �������� - ������
	public Vector<MemberBean> getGeneralMemberList() {
		Vector<MemberBean> generalMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select * from member where status = 0 and makerNo = 0 and authority = '�����'";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				
				generalMembers.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		
		return generalMembers;
	}

	//����Ŀ ����Ʈ �������� - ������
	public Vector<MemberBean> getSellerMemberList() {
		Vector<MemberBean> sellerMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select name, id, email from member where makerNo > 0 and status = 0 and authority = '�Ǹ���'";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				
				sellerMembers.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return sellerMembers;
		
	}

	//���������� ȸ�� ����Ʈ �������� - ������
	public Vector<MemberBean> getSuspendMemberList() {
		Vector<MemberBean> suspendedMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select name, id, email, authority from member where status = 1";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				bean.setAuthority(rs.getString("authority"));
				
				suspendedMembers.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		
		return suspendedMembers;
	}

	//������ ������ ���� ȸ�� ����Ʈ �������� - ������
	public Vector<MemberBean> getAdminMemberList() {
		Vector<MemberBean> adminMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select * from member where status = 0 and makerNo = 0 and authority = '������'";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setEmail(rs.getString("email"));
				
				adminMembers.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		
		return adminMembers;
	}
	
	//���� �������� ���� - ������
	public int changeStateToSuspend(String id) {
		int result = 0;
		String sql ="update member set status=1 where id=?";
		
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeStateToSuspend �޼ҵ� ���� : "+e);
		} finally {
			ResouceClose();
		}
		
		return result;
	}

	//���� ������ ��� - ������
	public int changeStateReturn(String id) {
		int result = 0;
		String sql = "update member set status=0 where id=?";
		
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeStateReturn �޼ҵ� ���� : "+e);
		} finally {
			ResouceClose();
		}
		return result;
	}
	
	//������ �������� ���� - ������
	public int ChangeToAdminAuthority(String id) {
		int result = 0;
		String sql ="update member set authority = '������' where id=?";
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("ChangeToAdminAuthority �޼ҵ� ���� : "+e);
		} finally {
			ResouceClose();
		}
		
		return result;
	}

	//������ ������ �Ϲ� ������ ���� - ������
	public int changeToUserAuthority(String id) {
		int result = 0;
		String sql = "update member set authority = '�����' where id=?";
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeToUserAuthority �޼ҵ� ���� : "+e);
		} finally {
			ResouceClose();
		}
		return result;
	}
		
	
	
	//��� ����Ʈ
	public Vector<BannerBean> getBannerList() {
		Vector<BannerBean> banners = new Vector<BannerBean>();
		BannerBean bean = null;

		String sql = "select * from banner order by bannerId";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new BannerBean();
				bean.setBannerId(rs.getInt("bannerId"));
				bean.setSavedFileName(rs.getString("savedName"));
				bean.setOriginalFileName(rs.getString("originalName"));
				bean.setLink(rs.getString("link"));
				
				banners.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		return banners;
	}

	//��� �̹��� ����
	public int bannerImgUpdate(Vector<BannerBean> list) {
		int result = 0;
		String sql = "";
		try {
			con = ds.getConnection();
			sql = "delete from banner";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
			sql = "insert into banner(originalName, savedName, link) values(?, ?, ?)";
			for(BannerBean bean : list) {
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getOriginalFileName());
				pstmt.setString(2, bean.getSavedFileName());
				pstmt.setString(3, bean.getLink());
				result = pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			System.out.println("bannerImgUpdate �޼ҵ� ���� "+e);
		} finally {
			ResouceClose();
		}
		return result;		
	}
	
	//�������� �Խñ� ���� ��������
	public int getNoticeTotalCount(String keyField, String keyword) {
		int totalCount = 0;
		String sql = "select count(*) as totalCount from noticeboard where " + keyField + " like '%" + keyword +"%' order by registerDate";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				totalCount = rs.getInt("totalCount");
			}
		} catch (Exception e) {
			System.out.println("getNoticeTotalCount �޼ҵ� ���� " + e);
		} finally {
			ResouceClose();
		}
		
		return totalCount;
	}

	//�������� ����Ʈ ��������
	public Vector<NoticeBean> getNoticeList(String keyField, String keyword, int page) {
		Vector<NoticeBean> noticeVector = new Vector<NoticeBean>();
		NoticeBean bean = null;
		String sql = "select n.noticeId, n.title, n.content, n.writerId, m.name, n.hit, n.registerDate from noticeboard n " + 
					 "join member m on n.writerId = m.id where " + keyField + " like '%" + keyword +"%' order by registerDate asc limit ?, 5";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, (page-1)*5);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new NoticeBean();
				bean.setNoticeId(rs.getInt("noticeId"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setWriterId(rs.getString("writerId"));
				bean.setWriterName(rs.getString("name"));
				bean.setRegdate(rs.getTimestamp("registerDate"));
				bean.setHit(rs.getInt("hit"));

				noticeVector.add(bean);
			}
		} catch (Exception e) {
			System.out.println("getNoticelist �޼ҵ� ���� " + e);
		} finally {
			ResouceClose();
		}
		
		return noticeVector;
	}

	//�������� �Խñ� ��� - ������
	public int insertNotice(String id, String title, String content) {
		int result = 0;
		
		String sql="insert into noticeboard(title, content, writerId) values(?, ?, ?);";
		try {
			System.out.println("��ŸƮ");
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setString(3, id);
			result = pstmt.executeUpdate();
			System.out.println("insertNotice result : " + result);
			
			if(result == 1) {
				sql = "select noticeId from noticeboard where title=? and content=? and writerId=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setString(3, id);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt("noticeId");
					System.out.println("insertNotice noticeId : " + result);
				}
			}
			
		}catch(Exception e) {
			System.out.println("insertNotice Error " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}

	//�������� �Խñ� ���� - ������
	public NoticeBean getNotice(int noticeId, String cmd) {
		NoticeBean bean = null;
		String sql = "";
		
		try {
			con = ds.getConnection();
			
			if(cmd.equals("view")) {
				sql = "update noticeBoard set hit = hit+1 where noticeId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, noticeId);
				pstmt.executeUpdate();
			}
			
			sql = "select n.noticeId, n.title, n.content, n.writerId, m.name, n.hit, n.registerDate from noticeboard n " + 
				  "join member m on n.writerId = m.id where n.noticeId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, noticeId);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new NoticeBean();
				bean.setNoticeId(rs.getInt("noticeId"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setWriterId(rs.getString("writerId"));
				bean.setWriterName(rs.getString("name"));
				bean.setHit(rs.getInt("hit"));
				bean.setRegdate(rs.getTimestamp("registerDate"));
			}
		}catch (Exception e) {
			System.out.println("getNotice Error " + e.toString());
		}finally {
			ResouceClose();
		}
		return bean;
	}

	//�������� �Խñ� ����
	public int updateNotice(int noticeId, String title, String content) {
		int result = 0;
		String sql = "update noticeBoard set title=?, content=?, updateDate=? where noticeId = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
			pstmt.setTimestamp(3, currentTime);
			pstmt.setInt(4, noticeId);
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("updateNotice Error " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}

	//�������� �Խñ� ����
	public int deleteNotice(int noticeId) {
		int result = 0;
		String sql = "delete from noticeBoard where noticeId=?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, noticeId);
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("deleteNotice Error: " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}
	
}
