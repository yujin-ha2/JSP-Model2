package net.funding.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.action.CategoryName;
import net.action.StatusName;
import net.admin.db.BannerBean;
import net.funding.action.CommunityBean;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.MakerBean;
import net.funding.open.db.RewardBean;
import net.funding.open.db.rewardDetailBean;
import net.member.db.MemberBean;

public class FundingDAO {

	Connection con;
	DataSource ds;
	PreparedStatement pstmt;
	ResultSet rs;

	public FundingDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/funding");
			
		}catch(Exception e) {
			System.out.println("DB연결 실패: " +e);
			return;
		}
	}
	
	public void ResourceClose(){	
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
	
	//(메이커  페이지) 메이커가 진행한 펀딩 리스트 가져오기 - 정수연
	public Vector<AllFundingInfoBean> getInformation(String makerId) {
		Vector<AllFundingInfoBean> fundingVector = new Vector<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		StatusName status = new StatusName();
		CategoryName category = new CategoryName();
		Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		
		try {
			String sql = "select f.fundingId, f.title, f.categoryId, f.mainImg, a.status, datediff(f.enddate, now()) as daydiff " 
					   + "from allproject a join fundinginfo f "
					   + "on a.fundingId = f.fundingId "
					   + "where a.userId = ? and a.status in ('start', 'success', 'fail')";
			
			con = ds.getConnection();	
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, makerId);
			rs=pstmt.executeQuery();
				
			while(rs.next()) {
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setFundingTitle(rs.getString("title"));
				bean.setCategoryName(category.get(rs.getInt("categoryId")));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setStatusName(status.get(rs.getString("status")));
				bean.setDayDiff(rs.getInt("daydiff"));
				fundingVector.add(bean);
			}
		}catch (Exception e) {
				System.out.println("getInformation error : " + e);
		}finally {
			ResourceClose();
		}
		
		return fundingVector;
	}
	
	//(메이커페이지) 메이커 정보 가져오기 - 하유진
	public MakerBean getMaker(String makerId) {
		MakerBean bean = new MakerBean();
		String sql = "select userId, name, profile from maker where userId = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, makerId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setUserId(rs.getString("userId"));
				bean.setName(rs.getString("name"));
				bean.setProfile(rs.getString("profile"));
			}
			
		}catch (Exception e) {
			System.out.println("getMaker error: " + e);
		}finally {
			ResourceClose();
		}
		return bean;
	}

	//메이커 상세 페이지, 메이커와 사용자의 팔로우 관계 받아오기 - 정수연
	public int follow(String makerId, String id) {
		try {
	    	  String sql = "select * from companyFollow where makerId=? and userId=?"; 

	    	  con = ds.getConnection();
 	          pstmt = con.prepareStatement(sql);
 	          pstmt.setString(1, makerId);
	          pstmt.setString(2, id);
	          rs=pstmt.executeQuery();

	          if(rs.next()) {
         	  	return 1;
         	  }
	      } catch (Exception e) {
	          System.out.println("follow error : " + e);
	      }finally {
			  ResourceClose();
		  }
	      return 0;
	   }

	//메이커 상세 페이지, 메이커의 팔로워 개수 받아오기 - 정수연
	public int countFollow(String makerId) {
		int followCount = 0;
		String sql = "select count(*) from companyFollow where makerId=?";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, makerId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				followCount = rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("countFollow error " + e);
		}finally {
			ResourceClose();
		}
		
		return followCount;
	}

	//메이커가 진행한 모든 펀딩 개수 받아오기 - 정수연
	public int countFunding(String companyId) {
		int fundingCount=0;
		String sql = "select count(*) from allproject where userId=? and status in ('start', 'success', 'fail')";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, companyId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				fundingCount=rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println("countFunding error " + e);
		}
		
		return fundingCount;
	}
	
	//팔로우, 팔로우 취소 처리(ajax) - 정수연
	public int followCompany(String userId, String makerId, int followbtn) {
		int followCount = 0;
		String sql = (followbtn==0) ? "insert into companyFollow (userId, makerId) values(?,?)" : "delete from companyFollow where userId=? and makerId=?";
		System.out.println("sql: " + sql);
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, makerId);
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
			    sql = "select count(*) from companyFollow where makerId=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, makerId);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					followCount = rs.getInt(1);
				}
			}
			
		}catch (Exception e) {
			System.out.println("followCompany error " + e);
		}finally {
			ResourceClose();
		}
		
		return followCount;
	}

	
	//(펀딩하기) 검색 , 카테고리 선택 등  펀딩 정보 가져오기 - 하유진, 정수연
	public List<AllFundingInfoBean> getAllFundinglist(int category, String keyword, String endYN, String order){
		List<AllFundingInfoBean> fundingList = new ArrayList<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("recent", "startDate");
		map.put("amount", "totalRevenue");
		map.put("closing", "endDate");

		//최신순, 펀딩액순, 마감임박순(order:recent/amount/closing) startDate desc / totalRevenue desc / endDate desc;
		String sql = "select * from searchFunding where title like '%" + keyword + "%'";
		if(category !=0)
			sql += " and categoryId = " + category;
		if(!endYN.equals("YN"))
			sql += (endYN.equals("N")) ? " and status = 'start' " : " and status in ('success', 'fail') ";
		sql += " order by " + map.get(order) + " desc";
		System.out.println("sql: " + sql);
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId")); 		
				bean.setFundingTitle(rs.getString("title"));	
				bean.setMakerName(rs.getString("makerName"));
				bean.setCategoryId(rs.getInt("categoryId"));	
				bean.setCategoryName(CategoryName.get(rs.getInt("categoryId")));	
				bean.setMainImg(rs.getString("mainImg"));	
				bean.setTotalRevenue(rs.getInt("totalRevenue"));
				bean.setAchievement(rs.getInt("achievement"));
				bean.setStatus(rs.getString("status"));
				bean.setStatusName(StatusName.get(rs.getString("status")));
				bean.setDayDiff(rs.getInt("daydiff"));
				
				fundingList.add(bean);
			}
		}catch (Exception e) {
			System.out.println("getAllFundinglist error : "+e);
		}finally {
			ResourceClose();
		}
		return fundingList;
	}

	public Vector<FundingInfoBean> getAllFundingRank() {
		Vector<FundingInfoBean> v = new Vector<FundingInfoBean>();
		FundingInfoBean bean = null;
		try {
			String sql = "select *, count(f.fundingId) 'count', a.userId 'allUserId' "
						+ "from fundingorder f join fundinginfo fu on f.fundingId = fu.fundingId "
						+ "join allproject a on a.fundingId = f.fundingId "
						+ "where status='start' "
						+ "group by f.fundingId order by count desc";
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new FundingInfoBean();
				bean.setTitle(rs.getString("title"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setStorySummary(rs.getString("allUserId"));
				v.add(bean);
			}
		}catch (Exception e) {
			System.out.println("getAllFundingRank 에러 : "+e);
		}finally {
			ResourceClose();
		}
		return v;
	}
	
	//(펀딩 상세 페이지 공통) 
 	public AllFundingInfoBean getFundingReport(int fundingId) {
 		AllFundingInfoBean bean = new AllFundingInfoBean();
 		String sql = "select f.fundingId, f.totalRevenue, (f.totalRevenue/f.salesTarget)*100 as achievement, " + 
 					 "datediff(f.enddate, now()) as daydiff, a.status, count(distinct o.userId) as supporterCount " + 
 					 "from fundinginfo f join allproject a on f.fundingId = a.fundingId " + 
 					 "join fundingorder o on a.fundingId = o.fundingId where a.fundingId=? and o.cancel=0";
 		
 		try {
 			con = ds.getConnection();
 			pstmt=con.prepareStatement(sql);
 			pstmt.setInt(1, fundingId);
 			rs = pstmt.executeQuery();
 			if(rs.next()) {
 				bean.setFundingId(rs.getInt("fundingId"));
 				bean.setTotalRevenue(rs.getInt("totalRevenue"));
 				bean.setAchievement(rs.getInt("achievement"));
 				bean.setDayDiff(rs.getInt("daydiff"));
 				bean.setStatus(rs.getString("status"));
 				bean.setStatusName(StatusName.get(rs.getString("status")));
 				bean.setSupporterCount(rs.getInt("supporterCount"));
 			}
 			
 		}catch(Exception e) {
 			System.out.println("getFundingReport: " + e.toString());
 		}finally{    
 			ResourceClose();
 		}
 		return bean;
 	}

	//(펀딩 스토리 페이지) 스토리내용 가져오기  - 정지운, 하유진
 	public FundingInfoBean getfundingStory(int fundingId) {
 		FundingInfoBean bean = new FundingInfoBean();
 		CategoryName category = new CategoryName(); 
 		String sql = "select * from fundinginfo where fundingId = ?";
 		
 		try {
 			con = ds.getConnection();
 			pstmt=con.prepareStatement(sql);
 			pstmt.setInt(1, fundingId);
 			rs = pstmt.executeQuery();
 			if(rs.next()) {
 				bean.setFundingId(rs.getInt("fundingId"));
 				bean.setTitle(rs.getString("title"));
 				bean.setStoryMainImg(rs.getString("storyMainImg"));
 				bean.setStoryContent(rs.getString("storyContent"));
 				bean.setStorySummary(rs.getString("storySummary"));
 				bean.setSalesTarget(rs.getInt("salesTarget"));
 				bean.setCategoryId(rs.getInt("categoryId"));
 				bean.setCategoryNm(category.get(rs.getInt("categoryId")));
 				bean.setStartdate(rs.getTimestamp("startdate"));
 				bean.setEnddate(rs.getTimestamp("enddate"));
 				System.out.println("startdate: " + rs.getTimestamp("startdate") + "bean: " + bean.getStartdate());
 				System.out.println("enddate: " + rs.getTimestamp("enddate") + "bean: " + bean.getEnddate());
 			}
 			
 		}catch(Exception e) {
 			System.out.println("EndDate:" + e.toString());
 		}finally{    
 			ResourceClose();
 		}
 		return bean;
 	}
 	
 	//(펀딩 페이지에 보여질 공통정보) 메이커 정보 가져오기 - 하유진
 	public MakerBean getMaker(int fundingId){
  		 MakerBean bean = null;
 		 String sql = "select userId, name, ifnull(profile, 'noImage.png') as profile, makerEmail, makerHomepage, makerTel " +
 		 		 	  "from maker where userId=(select userId from allproject where fundingId = ?)";
 	     try {
 	    	 con = ds.getConnection();
 	    	 pstmt = con.prepareStatement(sql);
	 	 	 pstmt.setInt(1, fundingId);
	 	 	 rs = pstmt.executeQuery(); 
	 	 
	 	 	 if (rs.next()) {
		 	 	 bean = new MakerBean();
		 	 	 bean.setUserId(rs.getString("userId"));
		 	 	 bean.setName(rs.getString("name"));
		 	 	 bean.setProfile(rs.getString("profile"));
		 	 	 bean.setMakerEmail(rs.getString("makerEmail"));
		 	 	 bean.setMakerHomepage(rs.getString("makerHomepage"));
		 	 	 bean.setMakerTel(rs.getString("makerTel"));
	 	 	 }
 	     } catch (Exception e) {
 	       System.out.println("getMaker:" + e.toString());
 	     } finally {
 	       ResourceClose();
 	     }
 	 
 	     return bean;
 	   }
 	
 	/*
	public int fundingDetailSupportCount(int fundingId) {
		String sql = "select count(*) from fundingorder where fundingId=? and cancel=0";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,fundingId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}else {
				return 0;
			}
		} catch (Exception e) {
			System.out.println("fundingDetailSupportCount 에러 : "+e);
		} finally {
			ResourceClose();
		}
		return 0;
	}
	
 	
	//펀딩 페이지 , 서포터 - 정수연
	public Vector<PaymentBean> fundingDetailSupportList(int fundingId) {
		Vector<PaymentBean> v = new Vector<PaymentBean>();
		PaymentBean bean = null;
		String sql = "select * from fundingorder f join member m on f.userId = m.id where f.fundingId=? and f.cancel=0";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,fundingId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new PaymentBean();
				bean.setUserId(rs.getString("userId"));
				//bean.setAmount(rs.getInt("amount")); 수정
				//bean.setReceiver(rs.getString("profile")); 수정
				v.add(bean);
			}
		}catch (Exception e) {
			System.out.println("fundingDetailSupportList error : "+e);
		}finally {
			ResourceClose();
		}
		return v;
	}
	*/
 	
	//사용안함
	//리워드 선택시 ajax - 정지운    =>  getRewards()로 변경함
	public RewardBean getdetail(int fundingId, String num) {
		
		RewardBean bean = new RewardBean();
		String sql = "select rewardOption, name from reward where fundingId = ? and rewardId = ?";
		
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			pstmt.setString(2, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setRewardDetail(rs.getString("rewardOption"));
				bean.setName(rs.getString("name"));
			}
		}catch(Exception e) {
			System.out.println("getdetail error :" + e.toString());
		}finally{
			ResourceClose();
		}
		return bean;
	}
	
	 //(펀딩 페이지에 보여질 공통정보) 펀딩 리워드 옵션 가져오기 - 하유진
	 public List<RewardBean> getRewardList(int fundingId) {
		 List<RewardBean> rewardList = new ArrayList<RewardBean>();
		 RewardBean bean = null;
		 String sql="select rewardId, rewardOption from reward where fundingId=?";

		 try {
				con = ds.getConnection();
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					bean = new RewardBean();
					bean.setRewardId(rs.getInt("rewardId"));
					bean.setRewardOption(rs.getString("rewardOption"));
					rewardList.add(bean);
			    }
				
		} catch (Exception e) {
			System.out.println("getRewardList:" + e.toString());
		} finally {
			 ResourceClose();
		}
		return rewardList;
	}
	 
	//(펀딩 페이지에 보여질 공통정보) - 리워드 옵션 선택시 정보 가져오기 (ajax) - 정지운, 하유진
	public RewardBean getRewards(int rewardId) {
		RewardBean bean = new RewardBean();
		String sql = "select * from reward where rewardId = ?";
		
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rewardId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean.setRewardId(rs.getInt("rewardId"));
				bean.setRewardOption(rs.getString("rewardOption"));
				bean.setRewardDetail(rs.getString("rewardDetail"));
				bean.setPrice(rs.getInt("price"));
				bean.setDeliveryFee(rs.getInt("deliveryFee"));
				bean.setSalesQuantity(rs.getInt("salesQuantity"));
				bean.setRemainingQuantity(rs.getInt("remainingQuantity"));
				bean.setDeliveryDate(rs.getString("deliveryDate"));
			}
		}catch(Exception e) {
			System.out.println("getRewards error :" + e.toString());
		}finally{
			ResourceClose();
		}
		return bean;
	}
	
 	//(반환,정책 페이지) 리워드 상세 정보 가져오기  - 하유진, 정지운
	public List<rewardDetailBean> getRewardDetailList(int fundingId) {
		List<rewardDetailBean> rewardDetailList = new ArrayList<rewardDetailBean>();
		rewardDetailBean bean = null;
		CategoryName category = new CategoryName();
		String sql = "select l.fundingId, d.categoryId, d.DetailName, l.DetailContent, p.policy from rewarddetail d " + 
					 "join rewarddetail_list l on d.DetailId = l.DetailId " +
					 "join rewardpolicy p on l.fundingId = p.fundingId " +
					 "where l.fundingId = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new rewardDetailBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setCategoryNm(category.get(rs.getInt("categoryId")));
				bean.setDetailName(rs.getString("DetailName"));
				bean.setDetailContent(rs.getString("DetailContent"));
				bean.setPolicy(rs.getString("policy"));
				rewardDetailList.add(bean);
			}
		}catch (Exception e) {
			System.out.println("getRewardDetailList error: " + e.toString());
		}finally {
			ResourceClose();
		}
		return rewardDetailList;
	}

	//(결제페이지) 서포터 정보 가져오기 - 하유진, 정수연
	public MemberBean getMember(String userId) {
		MemberBean member = new MemberBean();
		String sql = "select id, name, phone, email, profile, point from member where id = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setId(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setProfile(rs.getString("profile"));
				member.setPoint(rs.getInt("point"));
			}
					
		}catch (Exception e) {
			System.out.println("getMember error: " + e);
		}finally {
			ResourceClose();
		}
		return member;
	}

	//(결제페이지) 주문 정보 가져오기 - 하유진
	public List<FundingOrderBean> getOrder(int fundingId, String rewardIdList, Map<Integer, Integer> rewardMap) {
		List<FundingOrderBean> orderList = new ArrayList<FundingOrderBean>();
		FundingOrderBean orderBean = null;
		String sql = "select f.fundingId, r.rewardId, f.title, r.rewardOption, r.rewardDetail, r.price, r.deliveryFee " + 
					 "from fundinginfo f join reward r on f.fundingId = r.fundingId " + 
					 "where f.fundingId = ? and rewardId in (" + rewardIdList + ")";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				orderBean = new FundingOrderBean();
				orderBean.setFundingId(rs.getInt("fundingId"));
				orderBean.setRewardId(rs.getInt("rewardId"));
				orderBean.setTitle(rs.getString("title"));
				orderBean.setRewardOption(rs.getString("rewardOption"));
				orderBean.setRewardDetail(rs.getString("rewardDetail"));
				orderBean.setRewardNumber(rewardMap.get(rs.getInt("rewardId")));
				int rewardPrice = rs.getInt("price") * rewardMap.get(rs.getInt("rewardId"));
				orderBean.setRewardPrice(rewardPrice);
				orderBean.setDeliveryFee(rs.getInt("deliveryFee"));
				
				orderList.add(orderBean);
			}
					
		}catch (Exception e) {
			System.out.println("getOrder error: " + e);
		}finally {
			ResourceClose();
		}
		return orderList;
	}
	
	//(결제페이지) receiver 정보 등록 - 하유진
	public int setReceiver(String orderId, ReceiverBean receiver) {
		int receiverId = 0;
		String sql = "insert into receiver(orderId, name, phone, postCode, address, detailAddress, request, cardNumber, " + 
					 "expirationDate, password, birth) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderId);
			pstmt.setString(2, receiver.getName());
			pstmt.setString(3, receiver.getPhone());
			pstmt.setString(4, receiver.getPostCode());
			pstmt.setString(5, receiver.getAddress());
			pstmt.setString(6, receiver.getDetailAddress());
			pstmt.setString(7, receiver.getRequest());
			pstmt.setString(8, receiver.getCardNumber());
			pstmt.setString(9, receiver.getExpirationDate());
			pstmt.setString(10, receiver.getPassword());
			pstmt.setString(11, receiver.getBirth());
			receiverId = pstmt.executeUpdate();
			
			if(receiverId == 1) {
			    sql = "select receiverId from receiver where orderId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, orderId);
				rs = pstmt.executeQuery();
				if(rs.next())
					receiverId = rs.getInt("receiverId");
			}
			
		}catch (Exception e) {
			System.out.println("setReceiver error " + e);
		}finally {
			ResourceClose();
		}
		return receiverId;
	}

	//(결제페이지) 결제 처리 - 하유진
	public void setPayment(String orderId, int receiverId, PaymentBean payment, int[] rewardIds, int[] rewardNumbers) {
		String sql = "insert into fundingorder(orderId, userId, fundingId, receiverId, donation, usedPoint, deliveryFee, " +
					 "totalAmount, finalAmount) values(?, ?, ?, ?, ?, ?, ?, ?, ?);";
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderId);
			pstmt.setString(2, payment.getUserId());
			pstmt.setInt(3, payment.getFundingId());
			pstmt.setInt(4, receiverId);
			pstmt.setInt(5, payment.getDonation());
			pstmt.setInt(6, payment.getUsedPoint());
			pstmt.setInt(7, payment.getDeliveryFee());
			pstmt.setInt(8, payment.getTotalAmount());
			pstmt.setInt(9, payment.getFinalAmount());
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				for(int i=0; i<rewardIds.length; i++) {
					sql = "insert into fundingorderdetails(orderId, rewardId, quantity) values(?, ?, ?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, orderId);
					pstmt.setInt(2, rewardIds[i]);
					pstmt.setInt(3, rewardNumbers[i]);
					pstmt.executeUpdate();
				}
			}
			
		}catch (Exception e) {
			System.out.println("setPayment error " + e);
		}finally {
			ResourceClose();
		}
	}

	//(결제 승인 페이지) 펀딩 정보 가져오기 - 하유진
	public FundingInfoBean getPaymentApproveInfo(int fundingId) {
		FundingInfoBean funding = new FundingInfoBean();
		String sql = "select f.title, r.deliveryDate, f.enddate from fundinginfo f " +
				     "join reward r on f.fundingId = r.fundingId " +
				     "where f.fundingId = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				funding.setTitle(rs.getString("title"));
				funding.setDeliveryDate(rs.getString("deliveryDate"));
				funding.setEnddate(rs.getTimestamp("enddate"));
			}
					
		}catch (Exception e) {
			System.out.println("getMember error: " + e);
		}finally {
			ResourceClose();
		}
		return funding;
	}

	//(결제 페이지) 결제된 리워드의 옵션, 옵션개수 DB에 등록 - 하유진 
	public void checkOrderdOption(int fundingId, int[] rewardIds, int[] rewardNumbers) {
		try {
			con = ds.getConnection();
			for(int i=0; i<rewardIds.length; i++) {
				String sql = "update reward, (select remainingQuantity from reward where rewardId = ?) as remaining " + 
					     "set reward.remainingQuantity = remaining.remainingQuantity-" + rewardNumbers[i] +
					     " where rewardId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rewardIds[i]);
				pstmt.setInt(2, rewardIds[i]);
				pstmt.executeUpdate();
			}
		}catch (Exception e) {
			System.out.println("checkOrderdOption error: " + e);
		}finally {
			ResourceClose();
		}
	}

	//(결제 페이지) 판매금액 등록 - 하유진
	public void addRevenue(int fundingId, int totalAmount) {
		String sql = "update fundinginfo, (select totalRevenue from fundinginfo where fundingId=?) as prev " + 
				     "set fundinginfo.totalRevenue = prev.totalRevenue + ? where fundingId=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			pstmt.setInt(2, totalAmount);
			pstmt.setInt(3, fundingId);
			pstmt.executeUpdate();

		}catch (Exception e) {
			System.out.println("addRevenue error: " + e);
		}finally {
			ResourceClose();
		}
	}
	
	//(결제 페이지) 결제시 사용한 포인트 금액 차감 - 하유진
	public void usePoint(String userId, int point) {
		String sql = "update member set point=? where id=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, point);
			pstmt.setString(2, userId);
			pstmt.executeUpdate();

		}catch (Exception e) {
			System.out.println("usePoint error: " + e);
		}finally {
			ResourceClose();
		}
		
	}
	
	//(서포터페이지) 서포터 리스트 정보 가졍괴 - 정수연, 하유진
	public List<PaymentBean> getSupportList(int fundingId) {
		List<PaymentBean> paymentList = new ArrayList<PaymentBean>();
		PaymentBean payment = null;
		String sql = "select m.name, m.profile, o.totalAmount, o.orderDate from fundingorder o " +
					 "join member m on o.userId = m.id where o.fundingId = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				payment = new PaymentBean();
				payment.setUserId(rs.getString("name"));
				payment.setProfile(rs.getString("profile"));
				payment.setTotalAmount(rs.getInt("totalAmount"));
				payment.setOrderDate(rs.getTimestamp("orderDate"));
				paymentList.add(payment);
			}
	
		}catch (Exception e) {
			System.out.println("getSupportList error: " + e);
		}finally {
			ResourceClose();
		}
		return paymentList;
	}

	//(메인페이지) 설정한 배너 정보 가져오기 - 하유진
	public List<BannerBean> getBanners() {
		List<BannerBean> banners = new ArrayList<BannerBean>();
		BannerBean bean = null;
		String sql = "select * from banner";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bean = new BannerBean();
				bean.setImg(rs.getString("img"));
				bean.setLink(rs.getString("link"));
				banners.add(bean);
			}
	
		}catch (Exception e) {
			System.out.println("getBanners error: " + e);
		}finally {
			ResourceClose();
		}
		return banners;
	}
	
	//(메인페이지) 펀딩금액 순으로 펀딩리스트 가져오기 - 하유진
	public List<AllFundingInfoBean> getLankingList() {
		List<AllFundingInfoBean> lankingList = new ArrayList<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		String sql = "select fundingId, title, categoryId, mainImg, achievement from searchFunding " +
					 "where status = 'start' order by totalRevenue desc limit 0,5";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setFundingTitle(rs.getString("title"));
				bean.setCategoryName(CategoryName.get(rs.getInt("categoryId")));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setAchievement(rs.getInt("achievement"));
				lankingList.add(bean);
			}
	
		}catch (Exception e) {
			System.out.println("getLankingList error: " + e);
		}finally {
			ResourceClose();
		}
		return lankingList;
	}
	
	//(메인페이지) 최신순으로 펀딩리스트 가져오기 - 하유진
	public List<AllFundingInfoBean> getRecentFundingList() {
		List<AllFundingInfoBean> recentFundingList = new ArrayList<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		String sql = "select fundingId, title, categoryId, mainImg, achievement from searchFunding " +
					 "where status = 'start' order by startDate desc limit 0,6";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setFundingTitle(rs.getString("title"));
				bean.setCategoryName(CategoryName.get(rs.getInt("categoryId")));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setAchievement(rs.getInt("achievement"));
				recentFundingList.add(bean);
			}
	
		}catch (Exception e) {
			System.out.println("getRecentFundingList error: " + e);
		}finally {
			ResourceClose();
		}
		return recentFundingList;
	}
	
	//(커뮤니티) 사용자 타입에 따른 정보 가져오기
	public MemberBean getMemberTypeInfo(String userId) {
		MemberBean bean = new MemberBean();
		String sql = "select * from whatTypeOfMember where id = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setProfile(rs.getString("profile"));
			}
	
		}catch (Exception e) {
			System.out.println("getComment error: " + e);
		}finally {
			ResourceClose();
		}
		return bean;
	}
	
	//(커뮤니티) 댓글리스트 가져오기
	public List<CommunityBean> getComment(int fundingId) {
		List<CommunityBean> commentList = new ArrayList<CommunityBean>();
		CommunityBean bean = null;
		String sql = "select w.name, w.profile, c.replyId, c.writerId, c.content, c.registerDate, ifnull(p.count, 0) as replyCount " + 
					 "from community c join whatTypeOfMember w " + 
					 "on w.id = c.writerId " + 
					 "left outer join (select parentId, count(replyId) as count from community where parentId>0 group by parentId) p " + 
					 "on c.replyId = p.parentId " + 
					 "where c.fundingId = ? and c.parentId = 0";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bean = new CommunityBean();
				bean.setName(rs.getString("name"));
				bean.setProfile(rs.getString("profile"));
				bean.setReplyId(rs.getInt("replyId"));
				bean.setWriterId(rs.getString("writerId"));
				bean.setContent(rs.getString("content"));
				bean.setRegisterDate(rs.getTimestamp("registerDate"));
				bean.setReplyCount(rs.getInt("replyCount"));
				commentList.add(bean);
			}
	
		}catch (Exception e) {
			System.out.println("getComment error: " + e);
		}finally {
			ResourceClose();
		}
		return commentList;
	}

	//(커뮤니티) 댓글 등록
	public int insertComment(int fundingId, CommunityBean bean) {
		int result = 0;
		String sql = "insert into community(fundingId, writerId, content, parentId) values(?, ?, ?, ?);";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			pstmt.setString(2, bean.getWriterId());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getParentId());
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("insertComment error: " + e);
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//(커뮤니티) 댓글 삭제
	public int deleteComment(int replyId) {
		int result = 0;
		String sql = "delete from community where replyId=?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, replyId);
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("deleteComment error: " + e);
		}finally {
			ResourceClose();
		}
		return result;
	}

	//(커뮤니티) 댓글 수정
	public int updateComment(int replyId, String content) {
		int result = 0;
		String sql = "update community set content = ? where replyId = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, replyId);
			result = pstmt.executeUpdate();
	
		}catch (Exception e) {
			System.out.println("updateComment error: " + e);
		}finally {
			ResourceClose();
		}
		return result;
	}

	//(커뮤니티) 대댓글 리스트 가져오기
	public List<CommunityBean> replyList(int parentId) {
		List<CommunityBean> replies = new ArrayList<CommunityBean>();
		CommunityBean bean = null;
		
		String sql = "select w.name, w.profile, c.replyId, c.writerId, c.content, c.registerDate " + 
					 "from community c join whatTypeOfMember w on w.id = c.writerId where c.parentId=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, parentId);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				bean = new CommunityBean();
				bean.setName(rs.getString("name"));
				bean.setProfile(rs.getString("profile"));
				bean.setReplyId(rs.getInt("replyId"));
				bean.setWriterId(rs.getString("writerId"));
				bean.setContent(rs.getString("content"));
				bean.setRegisterDate(rs.getTimestamp("registerDate"));
				replies.add(bean);
			}
	
		}catch (Exception e) {
			System.out.println("replyList error: " + e);
		}finally {
			ResourceClose();
		}
		return replies;
	}

}
