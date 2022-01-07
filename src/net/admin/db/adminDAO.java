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
			System.out.println("DB연결 실패: " +e);
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
	
	//승인 요청한 프로젝트 리스트 받아오기 - 정수연
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

	//프로젝트 (승인/반려) 답변 처리
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
			System.out.println("ApproveChangeState 메소드 오류 " + e);
		} finally {
			ResouceClose();
		}
		return result;
	}

	//일반 회원리스트 가져오기 - 정수연
	public Vector<MemberBean> getGeneralMemberList() {
		Vector<MemberBean> generalMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select * from member where status = 0 and makerNo = 0 and authority = '사용자'";
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

	//메이커 리스트 가져오기 - 정수연
	public Vector<MemberBean> getSellerMemberList() {
		Vector<MemberBean> sellerMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select name, id, email from member where makerNo > 0 and status = 0 and authority = '판매자'";
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

	//정지계정인 회원 리스트 가져오기 - 정수연
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

	//관리자 권한을 가진 회원 리스트 가져오기 - 하유진
	public Vector<MemberBean> getAdminMemberList() {
		Vector<MemberBean> adminMembers = new Vector<MemberBean>();
		MemberBean bean = null;
		
		String sql = "select * from member where status = 0 and makerNo = 0 and authority = '관리자'";
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
	
	//정지 계정으로 변경 - 정수연
	public int changeStateToSuspend(String id) {
		int result = 0;
		String sql ="update member set status=1 where id=?";
		
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeStateToSuspend 메소드 오류 : "+e);
		} finally {
			ResouceClose();
		}
		
		return result;
	}

	//정지 계정을 취소 - 정수연
	public int changeStateReturn(String id) {
		int result = 0;
		String sql = "update member set status=0 where id=?";
		
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeStateReturn 메소드 오류 : "+e);
		} finally {
			ResouceClose();
		}
		return result;
	}
	
	//관리자 권한으로 변경 - 하유진
	public int ChangeToAdminAuthority(String id) {
		int result = 0;
		String sql ="update member set authority = '관리자' where id=?";
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("ChangeToAdminAuthority 메소드 오류 : "+e);
		} finally {
			ResouceClose();
		}
		
		return result;
	}

	//관리자 권한을 일반 유저로 변경 - 하유진
	public int changeToUserAuthority(String id) {
		int result = 0;
		String sql = "update member set authority = '사용자' where id=?";
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeToUserAuthority 메소드 오류 : "+e);
		} finally {
			ResouceClose();
		}
		return result;
	}
		
	
	
	//배너 리스트
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

	//배너 이미지 설정
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
			System.out.println("bannerImgUpdate 메소드 오류 "+e);
		} finally {
			ResouceClose();
		}
		return result;		
	}
	
	//공지사항 게시글 개수 가져오기
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
			System.out.println("getNoticeTotalCount 메소드 오류 " + e);
		} finally {
			ResouceClose();
		}
		
		return totalCount;
	}

	//공지사항 리스트 가져오기
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
			System.out.println("getNoticelist 메소드 오류 " + e);
		} finally {
			ResouceClose();
		}
		
		return noticeVector;
	}

	//공지사항 게시글 등록 - 하유진
	public int insertNotice(String id, String title, String content) {
		int result = 0;
		
		String sql="insert into noticeboard(title, content, writerId) values(?, ?, ?);";
		try {
			System.out.println("스타트");
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

	//공지사항 게시글 보기 - 하유진
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

	//공지사항 게시글 수정
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

	//공지사항 게시글 삭제
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
