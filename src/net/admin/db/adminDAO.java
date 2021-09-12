package net.admin.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.funding.db.AllFundingInfoBean;
import net.funding.open.db.FundingInfoBean;
import net.member.db.MemberBean;

public class adminDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public adminDAO() {
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/funding");
			con = ds.getConnection();	
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
	public Vector<AllFundingInfoBean> getApprovelist() {
		Vector<AllFundingInfoBean> v = new Vector<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		try {
			String sql = "select f.fundingId, f.title, f.categoryId, f.mainImg, a.userId as 'makerId' "  
					   + "from allproject a join fundinginfo f on a.fundingId = f.fundingId "  
					   + "where a.status = 'submission'";
			
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setTitle(rs.getString("title"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setStatus(rs.getInt("status"));
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setMakerId(rs.getString("makerId"));
				
				v.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		return v;
	}

	//프로젝트 (승인/반려) 답변 처리
	public void ApproveChangeApproveState(String num, String comment, int btnValue) {
		FundingInfoBean bean = new FundingInfoBean();
		String sql = null;
		try {
			if(btnValue == 1) {
				sql = "update fundingInfo set status='approve', comment=? where fundingId=" + num;
			}else if(btnValue == 2){
				sql = "update fundingInfo set status='reject', comment=? where fundingId=" + num;
			}
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, comment);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("ApproveChangeState 메소드 오류"+e);
		} finally {
			ResouceClose();
		}
	}

	//공지사항 가져오기
	public Vector<NoticeBean> getNoticelist() {
		Vector<NoticeBean> v = new Vector<NoticeBean>();
		NoticeBean bean = null;
		
		try {
			String sql = "select * from notice";
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new NoticeBean();
				bean.setNoticeId(rs.getInt("noticeId"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setRegdate(rs.getTimestamp("regdate"));
				bean.setWriterId(rs.getString("writerId"));
				
				v.add(bean);
			}
		} catch (Exception e) {
			System.out.println("getNoticelist 메소드 오류"+e);
		} finally {
			ResouceClose();
		}
		
		return v;
	}

	//일반 회원리스트 가져오기 - 정수연
	public Vector<MemberBean> getGeneralMemberList() {
		Vector<MemberBean> g = new Vector<MemberBean>();
		MemberBean bean = null;
		
		try {
			String sql = "select * from member where status = 0 and makerNo is null and id != 'admin'";
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("id"));
				bean.setEmail(rs.getString("email"));
				
				g.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		
		return g;
	}

	//메이커 리스트 가져오기 - 정수연
	public Vector<MemberBean> getSellerMemberList() {
		Vector<MemberBean> se = new Vector<MemberBean>();
		MemberBean bean = null;
		
		try {
			String sql = "select name, id, email from member where makerNo != 0 and status = 0";
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("id"));
				bean.setEmail(rs.getString("email"));
				
				se.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return se;
		
	}

	//정지계정인 회원 리스트 가져오기 - 정수연
	public Vector<MemberBean> getSuspendMemberList() {
		Vector<MemberBean> se = new Vector<MemberBean>();
		MemberBean bean = null;
		
		try {
			String sql = "select name, id, email, makerNo from member where status = 1";
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new MemberBean();
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("id"));
				bean.setEmail(rs.getString("email"));
				bean.setMakerNo(rs.getInt("makerNo"));
				
				se.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		
		return se;
	}

	//정지 계정으로 변경
	public MemberBean changeStateToSuspend(String id) {
			MemberBean bean = new MemberBean();
			try {
				String sql ="update member set status=1 where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				System.out.println("changeStateToSuspend메소드 오류 : "+e);
			} finally {
				ResouceClose();
			}
			
			return null;
		}

	public MemberBean changeStateReturn(String id) {
		MemberBean bean = new MemberBean();
		String sql = null;
		try {
			sql ="update member set status=0 where id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("changeStateToSuspend메소드 오류 : "+e);
		} finally {
			ResouceClose();
		}
		return null;
	}

	//배너 리스트
	public Vector<BannerBean> getBannerList() {
		Vector<BannerBean> v = new Vector<BannerBean>();
		BannerBean bean = null;
		try {
			String sql = "select * from banner order by bannerId";
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new BannerBean();
				bean.setBannerId(rs.getInt("bannerId"));
				bean.setImg(rs.getString("img"));
				bean.setLink(rs.getString("link"));
				
				v.add(bean);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResouceClose();
		}
		return v;
	}

	//배너 이미지 설정
	public void bannerImgUpdate(String file1, String file2, String file3, String file4, String link1, String link2, String link3, String link4) {
		BannerBean bean = new BannerBean();
		String sql = null;
		try {
			
			sql="update banner set link=? where bannerId=1";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, link1);
			pstmt.executeUpdate();
			
			sql="update banner set link=? where bannerId=2";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, link2);
			pstmt.executeUpdate();
			
			sql="update banner set link=? where bannerId=3";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, link3);
			pstmt.executeUpdate();
			
			sql="update banner set link=? where bannerId=4";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, link4);
			pstmt.executeUpdate();
			
			if(file1 != null) {
				sql = "update banner set img=? where bannerId=1";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, file1);
				pstmt.executeUpdate();
			}
			if(file2 != null) {
				sql = "update banner set img=? where bannerId=2";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, file2);
				pstmt.executeUpdate();
			}
			if(file3 != null) {
				sql = "update banner set img=? where bannerId=3";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, file3);
				pstmt.executeUpdate();
			}
			if(file4 != null) {
				sql = "update banner set img=? where bannerId=4";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, file4);
				pstmt.executeUpdate();
			}
			
		} catch (Exception e) {
			System.out.println("bannerImgUpdate 메소드 오류"+e);
		} finally {
			ResouceClose();
		}		
	}
	
}
