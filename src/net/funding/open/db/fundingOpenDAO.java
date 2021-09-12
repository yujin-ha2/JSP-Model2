package net.funding.open.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class fundingOpenDAO {
	
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public fundingOpenDAO() {
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
	

	//메이커 간편 등록으로 메이커 등록 처리
	public boolean insertEasyMaker(MakerBean maker) {
		
		
		try {
			String sql="insert into maker(userId, name, type) values(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, maker.getUserId());
			pstmt.setString(2, maker.getName());
			pstmt.setString(3, maker.getType());
			int result = pstmt.executeUpdate();
			
			if(result == 1 ) {
				sql = "update member set makerNo = (select makerNo from maker where id = ?) where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, maker.getUserId());
				pstmt.setString(2, maker.getUserId());
				pstmt.executeUpdate();
				return true;
			}
			
		}catch(Exception e) {
			System.out.println("insertEasyMaker Error" + e.toString());
		}finally {
			ResouceClose();
		}
		return false;
	}
	
	//메이커 여부 확인 - 하유진
	public boolean confirmUserStatus(String id) {
		boolean result = false;
		String sql="select makerNo from member where id = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("makerNo") > 0) {
					result= true;
				}
			}
		}catch(Exception e) {
			System.out.println("confirmUserStatus error :" + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}

	//새로운 프로젝트 시작 - 하유진
	public int insertNewProject(String id) {
		
		String sql="insert into allproject(userId, makerNo) SELECT id, makerNo from member where id = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				sql = "select fundingId from allproject where userId = ? order by regDate desc limit 1";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next())
					return rs.getInt("fundingId");
			}
		}catch(Exception e) {
			System.out.println("insertNewProject error : " + e.toString());
		}finally {
			ResouceClose();
		}
		return 0;
	}

	//내가 만든 프로젝트 화면에 필요한 데이터 가져오기 - 하유진
	public List<myProjectBean> getProjectList(String id) {
		//메이커이름, 대표이미지, 프로젝트 명, 상태
		List<myProjectBean> list = new ArrayList<myProjectBean>();
		myProjectBean bean = null;
		String sql= "select a.fundingId, a.status, m.name, f.mainImg, f.title " + 
					"from allproject a join maker m on a.makerNo = m.makerNo " + 
					"join fundinginfo f on a.fundingId = f.fundingId " +
					"where a.userId = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new myProjectBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setStatus(rs.getString("status"));
				bean.setMakerName(rs.getString("name"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setTitle(rs.getString("title"));
				list.add(bean);
			}
		}catch(Exception e) {
			System.out.println("getProjectList error : " + e.toString());
		}finally {
			ResouceClose();
		}
		return list;
	}
	
	//메이커 스튜디오 메인 화면, 단계별 상태 가져오기
	public List<String> getProjectStatus(int fundingId) {
		List<String> statusList = new ArrayList<String>();
		String sql="select requirement, fundinginfo, reward, rewarddetail, maker, status from allproject where fundingId = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				statusList = new ArrayList<String>();
				statusList.add(Integer.toString(rs.getInt("requirement")));
				statusList.add(Integer.toString(rs.getInt("fundinginfo")));
				statusList.add(Integer.toString(rs.getInt("reward")));
				statusList.add(Integer.toString(rs.getInt("rewarddetail")));
				statusList.add(Integer.toString(rs.getInt("maker")));
				statusList.add(rs.getString("status"));
			}
		}catch(Exception e) {
			System.out.println("getProjectStatus error : " + e.toString());
		}finally {
			ResouceClose();
		}
		return statusList;
	}
	
	//메이커 스튜디오, 상태 받아오기 - 하유진
	public AllProject getStatus(int fundingId, String field) {
		AllProject project = null;
		String sql = "select status, " + field + " from allproject where fundingId = ?";
		System.out.println("sql: " + sql);
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				project = new AllProject();
				project.setStatus(rs.getString(1));
				project.setIsReg(rs.getInt(2));
			}
		}catch(Exception e) {
			System.out.println("getStatus error : " + e.toString());
		}finally {
			ResouceClose();
		}
		
		return project;
	}

	//기본 요건 등록 - 하유진
	public int insertRequirement(RequirementsBean bean) {
		int result = 0;
		String sql = "insert into requirement(q1, differ, reward, delivery, q4, fundingId) values (?, ?, ?, ?, ?, ?)";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getQ1());
			pstmt.setString(2, bean.getDiffer());
			pstmt.setString(3, bean.getReward());
			pstmt.setString(4, bean.getDelivery());
			pstmt.setString(5, bean.getQ4());
			pstmt.setInt(6, bean.getFundingId());
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				sql = "update allproject set requirement = 1 where fundingId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bean.getFundingId());
				pstmt.executeUpdate();
			}
			
		}catch(Exception e) {
			System.out.println("insertRequirement : " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}
	
	//기본 요건 받아오기 - 하유진
	public RequirementsBean getRequirement(int fundingId) {
		RequirementsBean bean = null;
		
		String sql = "select q1, differ, reward, delivery, q4, fundingId from requirement where fundingId = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new RequirementsBean();
				bean.setQ1(rs.getString("q1"));
				bean.setDiffer(rs.getString("differ"));
				bean.setReward(rs.getString("reward"));
				bean.setDelivery(rs.getString("delivery"));
				bean.setQ4(rs.getString("q4"));
				bean.setFundingId(rs.getInt("fundingId"));
			}
		}catch(Exception e) {
			System.out.println("getRequirement error : " + e.toString());
		}finally {
			ResouceClose();
		}
		return bean;
	}

	//기본 요건 수정 - 하유진
	public int updateRequirment(RequirementsBean bean) {
		int result = 0;
		String sql = "update requirement set q1=?, differ=?, reward=?, delivery=?, q4=? where fundingId = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getQ1());
			pstmt.setString(2, bean.getDiffer());
			pstmt.setString(3, bean.getReward());
			pstmt.setString(4, bean.getDelivery());
			pstmt.setString(5, bean.getQ4());
			pstmt.setInt(6, bean.getFundingId());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("updateRequirment : " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}
	
	//기본 정보 등록
	public int insertBasicInfo(FundingInfoBean bean) {
		int result = 0;
		String sql = "insert into fundingInfo(fundingId, title, salesTarget, mainImg, categoryId, storyMainImg, storySummary, storyContent) "
				   + "values(?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getFundingId());
			pstmt.setString(2, bean.getTitle());
			pstmt.setInt(3, bean.getSalesTarget());
			pstmt.setString(4, bean.getMainImg());
			pstmt.setInt(5, bean.getCategoryId());
			pstmt.setString(6, bean.getStoryMainImg());
			pstmt.setString(7, bean.getStorySummary());
			pstmt.setString(8, bean.getStoryContent());
			
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				sql = "update allproject set fundinginfo = 1 where fundingId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bean.getFundingId());
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			System.out.println("insertBasicInfo: " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}

	//기본 정보 가져오기 - 하유진
	public FundingInfoBean getFundingInfo(int fundingId) {
		FundingInfoBean bean = null;
		
		String sql = "select title, salesTarget, mainImg, categoryId, storyMainImg, storySummary, storyContent, fundingId from fundinginfo where fundingId = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new FundingInfoBean();
				bean.setTitle(rs.getString("title"));
				bean.setSalesTarget(rs.getInt("salesTarget"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setStoryMainImg(rs.getString("storyMainImg"));
				bean.setStorySummary(rs.getString("storySummary"));
				bean.setStoryContent(rs.getString("storyContent"));
				bean.setFundingId(rs.getInt("fundingId"));
			}
		}catch(Exception e) {
			System.out.println("getFundingInfo error : " + e.toString());
		}finally {
			ResouceClose();
		}
		return bean;
	}

	//기본 정보 수정하기 - 하유진
	public int updateBasicInfo(FundingInfoBean bean) {
		int result = 0;
		String sql = "update fundinginfo set title=?, salesTarget=?, mainImg=?, categoryId=?, storyMainImg=?, storySummary=?, storyContent=? " 
				   + "where fundingId = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getTitle());
			pstmt.setInt(2, bean.getSalesTarget());
			pstmt.setString(3, bean.getMainImg());
			pstmt.setInt(4, bean.getCategoryId());
			pstmt.setString(5, bean.getStoryMainImg());
			pstmt.setString(6, bean.getStorySummary());
			pstmt.setString(7, bean.getStoryContent());
			pstmt.setInt(8, bean.getFundingId());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("updateBasicInfo : " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}

	//메이커 기본정보 가져오기 - 하유진
	public MakerBean getMakerInfo(String userId) {
		MakerBean bean = null;
		
		String sql = "select name, type from maker where userId = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new MakerBean();
				bean.setName(rs.getString("name"));
				bean.setType(rs.getString("type"));
			}
		}catch(Exception e) {
			System.out.println("getMakerInfo error : " + e.toString());
		}finally {
			ResouceClose();
		}
		
		return bean;
	}
	
	//메이커 상세 정부 가져오기 - 하유진
	public MakerBean getMakerDetail(String userId) {
		MakerBean bean = null;
		
		String sql = "select name, type, ceoName, ceoEmail, profile, makerEmail, makerTel, makerHomepage, bankName, accountNumber, accountHolder " 
				   + "from maker where userId = ?";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new MakerBean();
				bean.setName(rs.getString("name"));
				bean.setType(rs.getString("type"));
				bean.setCeoName(rs.getString("ceoName"));
				bean.setCeoEmail(rs.getString("ceoEmail"));
				bean.setProfile(rs.getString("profile"));
				bean.setMakerEmail(rs.getString("makerEmail"));
				bean.setMakerTel(rs.getString("makerTel"));
				bean.setMakerHomepage(rs.getString("makerHomepage"));
				bean.setBankName(rs.getString("bankName"));
				bean.setAccountNumber(rs.getString("accountNumber"));
				bean.setAccountHolder(rs.getString("accountHolder"));
			}
		}catch(Exception e) {
			System.out.println("getMakerDetail error : " + e.toString());
		}finally {
			ResouceClose();
		}
		
		return bean;
	}

	//메이커 상세 정보 수정 - 하유진
	public int updateMakerInfo(MakerBean bean, int fundingId) {
		int result = 0;
		String sql = "update maker set name=?, type=?, profile=?, ceoName=?, ceoEmail=?, makerHomepage=?, " 
				   + "makerEmail=?, makerTel=?, bankName=?, accountNumber=?, accountHolder=? "
				   + "where userId = ?";
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  bean.getName());
			pstmt.setString(2, bean.getType());
			pstmt.setString(3, bean.getProfile());
			pstmt.setString(4, bean.getCeoName());
			pstmt.setString(5, bean.getCeoEmail());
			pstmt.setString(6, bean.getMakerHomepage());
			pstmt.setString(7, bean.getMakerEmail());
			pstmt.setString(8, bean.getMakerTel());
			pstmt.setString(9, bean.getBankName());
			pstmt.setString(10, bean.getAccountNumber());
			pstmt.setString(11, bean.getAccountHolder());
			pstmt.setString(12, bean.getUserId());
			
			result = pstmt.executeUpdate();
			
			if(result == 1 && fundingId != 0) { //아직 allproject에 maker 필드 값이 0인 경우
				sql = "update allproject set maker=1 where fundingId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				pstmt.executeUpdate();
				
			}
			
		}catch(Exception e) {
			System.out.println("updateMakerInfo : " + e.toString());
		}finally {
			ResouceClose();
		}
		return result;
	}
	
	//펀딩현황 페이지에 들어갈 각 정보 - 정지운 오류 여기서 남
	public ReportJoin Report(int fundingId) {
		ReportJoin r = new ReportJoin();
		try {
			String sql = "select r.price, r.salesQuantity, a.startDate, "
					   + "a.endDate, a.userId, a.fundingId, "
					   + "a.regDate, f.title, f.salesTarget, f.categoryId, a.comment, f.storySummary "
					   + "from allproject a join fundinginfo f "
					   + "on a.fundingId = f.fundingId "
					   + "join reward r on f.fundingId = r.fundingId "
					   + "where f.fundingId = ?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				r.setCategoryId(rs.getInt("categoryId"));
				r.setComment(rs.getString("comment"));
				r.setUserId(rs.getString("userId"));
				r.setFundingId(rs.getInt("fundingId"));
				r.setRedDate(rs.getString("regDate"));
				r.setTitle(rs.getString("title"));
				r.setSalesTarget(rs.getInt("salesTarget"));
				r.setStorySummary(rs.getString("storySummary"));
				r.setStartDate(rs.getString("startDate"));
				r.setEndDate(rs.getString("endDate"));
				r.setPrice(rs.getInt("price"));
				r.setSalesQuantity(rs.getInt("salesQuantity"));
			}
			return r;
			
		} catch (Exception e) {
		System.out.println("Report error:" + e.toString());
		 } finally {
		 ResouceClose();
		}
		return null;
	}
	
	 //펀딩현황 페이지 리워드 금액 * 판매된 개수 가져오기 - 정지운
	 public List<ReportJoin> ListReport(int fundingId) {
		 
		 List<ReportJoin> abc = new ArrayList<ReportJoin>();
			ReportJoin r = null;
			try {
				
				String sql="select price, salesQuantity from reward where fundingId = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					r = new ReportJoin();
					r.setPrice(rs.getInt("price"));
					r.setSalesQuantity(rs.getInt("salesQuantity"));
					abc.add(r);
			    }
				
			} catch (Exception e) {
			System.out.println("ListReport:" + e.toString());
			 } finally {
			 ResouceClose();
			}
			return abc;
		}
	 
	 //펀딩현황 페이지 최근하루 판매금액,개수  금액은 배송비 포인트 제외된 최종결제금액 - 정지운
	 public List<fundingorderBean> reportDate(int fundingId) {
			
		 List<fundingorderBean> repo = new ArrayList<fundingorderBean>();
		 fundingorderBean r = null;
			try {
				
				String sql="select a.amount, b.quantity from fundingorder a join fundingorderdetails b on a.orderId = b.orderId "
						+ "where a.orderDate between date_add(now(), interval -1 day) and now() and fundingId = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					r = new fundingorderBean();
					r.setAmount(rs.getInt("amount"));
					r.setQuantity(rs.getInt("quantity"));
					repo.add(r);
			    }
				
			} catch (Exception e) {
			System.out.println("ListReport:" + e.toString());
			 } finally {
			 ResouceClose();
			}
			return repo;
		}
	 
	 //펀딩현황 페이지 최근일주일 판매금액,개수  금액은 배송비 포인트 제외된 최종결제금액 - 정지운
	 public List<fundingorderBean> report7Date(int fundingId) {
			
		 List<fundingorderBean> repo = new ArrayList<fundingorderBean>();
		 fundingorderBean r = null;
			try {
				
				String sql="select a.amount, b.quantity from fundingorder a join fundingorderdetails b on a.orderId = b.orderId "
						+ "where a.orderDate between date_add(now(), interval -7 day) and now() and fundingId = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					r = new fundingorderBean();
					r.setAmount(rs.getInt("amount"));
					r.setQuantity(rs.getInt("quantity"));
					repo.add(r);
			    }
				
			} catch (Exception e) {
			System.out.println("ListReport:" + e.toString());
			 } finally {
			 ResouceClose();
			}
			return repo;
		}

	 //펀딩현황 그래프에 쓸 각종 리워드 정보가져오기 - 정지운
	 public List<RewardBean> rewardList(int fundingId) {
		 
		 List<RewardBean> reward = new ArrayList<RewardBean>();
		 RewardBean r = null;
			try {
				
				String sql="select * from reward where fundingId = ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					r = new RewardBean();
					r.setName(rs.getString("name"));
					r.setRewardDetail(rs.getString("rewardDetail"));
					r.setSalesQuantity(rs.getInt("salesQuantity"));
					reward.add(r);
			    }
				
			} catch (Exception e) {
			System.out.println("ListReport:" + e.toString());
			 } finally {
			 ResouceClose();
			}
			return reward;
		}
	 
	 //펀딩하기 그래프에 쓸 내용 - 정지운
	 public List<fundingorderBean> chartDate(int fundingId) {
			
		 List<fundingorderBean> chartDate = new ArrayList<fundingorderBean>();
		 fundingorderBean r = null;
			try {
				
				String sql="SELECT DATE(b.orderDate) AS date, "
						+ "       sum(a.quantity)as sum "
						+ "  FROM fundingorderdetails a join fundingorder b on a.orderId = b.orderId "
						+ " where fundingId = ? GROUP BY date order by date ";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					r = new fundingorderBean();
					r.setOrderDate(rs.getString("date"));
					r.setQuantity(rs.getInt("sum"));
					chartDate.add(r);
			    }
				
			} catch (Exception e) {
			System.out.println("ListReport:" + e.toString());
			 } finally {
			 ResouceClose();
			}
			return chartDate;
		}
	 
	 //결제페이지에 들어갈 펀딩정보와 리워드 정보가져오기 - 정지운
	 public JoinFunding fundinginfo(int fundingId,int rewardId){
	     JoinFunding mb = null;
	     try {
	       pstmt = con.prepareStatement("select f.title, r.price, r.rewardId, r.rewardOption, r.rewardDetail, r.deliveryFee,f.regDate from fundinginfo f join reward r on f.fundingId = r.fundingId where f.fundingId = ? and r.rewardId = ?");
	 
	       pstmt.setInt(1, fundingId);
		   pstmt.setInt(2, rewardId);
	       rs = pstmt.executeQuery();
	       if (rs.next()) {
		         mb = new JoinFunding();
		         mb.setDeliveryFee(rs.getInt("deliveryFee"));
		         mb.setPrice(rs.getInt("price"));
		         mb.setRegDate(rs.getString("regDate"));
		         mb.setRewardDetail(rs.getString("rewardDetail"));
		         mb.setRewardOption(rs.getString("rewardOption"));
		         mb.setTitle(rs.getString("title"));
	       }
	       return mb;
	     } catch (Exception e) {
	       System.out.println("fundinginfo:" + e.toString());
	     } finally {
	       ResouceClose();
	     }
	 
	     return null;
	   }

	 //결제페이지에서 입력한 정보 디비에 넣기 - 정지운
	 public int fundingOrder(fundingorderBean b, int fundingId) {
	     int result = 0;
	     String sql = "insert into fundingorder(userId, receiver, receiverPhone, receiverEmail, zipCode,addr1, addr2, Requests, cardNumber, ExpirationDate, birth, amount, orderId, usePoint, fundingId) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	     try
	     {
	       pstmt = con.prepareStatement(sql);
	       pstmt.setString(1, b.getUserId());
	       pstmt.setString(2, b.getReceiver());
	       pstmt.setString(3, b.getReceiverPhone());
	       pstmt.setString(4, b.getReceiverEmail());
	       pstmt.setString(5, b.getZipCode());
	       pstmt.setString(6, b.getAddr1());
	       pstmt.setString(7, b.getAddr2());
	       pstmt.setString(8, b.getRequests());
	       pstmt.setString(9, b.getCardNumber());
	       pstmt.setString(10, b.getExpirationDate());
	       pstmt.setString(11, b.getBirth());
	       pstmt.setInt(12, b.getAmount());
	       pstmt.setString(13, b.getOrderId());
		   pstmt.setInt(14, b.getUsePoint());
		   pstmt.setInt(15, b.getFundingId());


	       result = pstmt.executeUpdate();
	 

	       RewardBean mb = new RewardBean();
	       if (result != 0) {
	         pstmt = con.prepareStatement("select * from reward where fundingId = ?");
				pstmt.setInt(1, fundingId);
	         rs = pstmt.executeQuery();
	         if (rs.next()) {
	           mb.setDeliveryDate(rs.getTimestamp("deliveryDate"));
	           mb.setName(rs.getString("name"));
	           mb.setPrice(Integer.parseInt(rs.getString("price")));
	           mb.setRewardDetail(rs.getString("rewardDetail"));
	           mb.setRewardOption(rs.getString("rewardOption"));
	         }
	       }
	 
	     }
	     catch (Exception e)
	     {
	       System.out.println("fundingOrder:" + e.toString());
	     } finally {
	       ResouceClose();
	     }
	     return result;
	   }
	 
	 //결제확인 페이지에 보여질 정보가져오기 - 정지운
	 public JoinFunding joinReward(int fundingId, int rewardId){
	     JoinFunding mb = null;
	     try {
					
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/goodfunding");
			con = ds.getConnection();
	        pstmt = con.prepareStatement("select r.name, r.price, r.deliveryDate, f.title, r.price, r.rewardOption, f.categoryId, a.endDate, r.rewardDetail, r.deliveryFee,f.regDate from fundinginfo f join reward r on "
														+ "	f.fundingId = r.fundingId join allproject a on f.fundingId = a.fundingId where f.fundingId = ? and r.rewardId = ?");
	       this.pstmt.setInt(1, fundingId);
					pstmt.setInt(2, rewardId);
	       this.rs = this.pstmt.executeQuery();
	       if (this.rs.next()) {
	         mb = new JoinFunding();
	         mb.setDeliveryFee(this.rs.getInt("deliveryFee"));
			 mb.setName(rs.getString("name"));
			 mb.setPrice(rs.getInt("price"));
			 mb.setEndDate(rs.getString("endDate"));
			 mb.setCategoryId(rs.getInt("categoryId"));
			 mb.setDeliveryDate(rs.getString("deliveryDate"));
	         mb.setPrice(this.rs.getInt("price"));
	         mb.setRegDate(this.rs.getString("regDate"));
	         mb.setRewardDetail(this.rs.getString("rewardDetail"));
	         mb.setRewardOption(this.rs.getString("rewardOption"));
	         mb.setTitle(this.rs.getString("title"));
	       }
					con.close();
	       return mb;

	     } catch (Exception e) {
	       System.out.println("joinReward:" + e.toString());
	     } finally {
	       ResouceClose();
	     }
	 
	     return null;
	}
	 //결제후 리워드 개수증가 - 정지운
	 public int salesQuantity(int salesQuantity, int fundingId, int rewardId){
		 
		    int result = 0;
		    
		    try{
		    	Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/goodfunding");
				con = ds.getConnection();
				String sql = "update reward set salesQuantity = salesQuantity +? where fundingId = ? and rewardId = ?";
		     
			     pstmt = con.prepareStatement(sql);
			     pstmt.setInt(1, salesQuantity);
			     pstmt.setInt(2, fundingId);
			     pstmt.setInt(3, rewardId);
			     result = pstmt.executeUpdate();
			     con.close();
			    
		   }
		    		
		   catch (Exception e) {
			      System.out.println("salesQuantity:" + e.toString());
			    } finally {
			      ResouceClose();
		   }
			
			    return result;
		   }
	 //결제후 펀딩오더디테일 테이블에 데이터 넣어주기 - 정지운
	 public int fundingorderdetails(fundingOrderDetailBean f) {
			int result = 0;
				try {
				String sql = "insert into fundingorderdetails (orderId,optionId,quantity) values (?,?,?)";
				
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, f.getOrderId());
				pstmt.setInt(2, f.getOptionId());
				System.out.println(f.getOrderId());
				pstmt.setInt(3,f.getQuantity());
				
				result = pstmt.executeUpdate();
				
			}catch(Exception e) {
				System.out.println("allproject:" + e.toString());
			}finally{
				ResouceClose();
			}
			return 0;
		}
	 
	 	//펀딩하기 페이지에 보여질 해당펀딩 종료날짜  - 정지운
	 	public JoinFunding EndDate(int fundingId) {
			JoinFunding j = new JoinFunding();
			String sql = "select endDate from allproject where fundingId = ?";
			
				try {
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					j.setEndDate(rs.getString("endDate"));
				}
				
			}catch(Exception e) {
				System.out.println("EndDate:" + e.toString());
			}finally{
				ResouceClose();
			}
			return j;
			}
	 	
	 	//펀딩하기 리워드 제공정보에 보여질 메어키의 입력값 가져오기.
	 	//rewarddetail2테이블은 메이커가 리워드 제공정보 입력시 들어갈 테이블로, 테이블이름이 중첩되서 2로 지음. 무슨말이죠...?
	 	public List<fundingDetail_returnBean> Detail_return(int fundingId) {
			List<fundingDetail_returnBean> detail = new ArrayList<>();
			fundingDetail_returnBean f = null;
			
			try {
				String sql = "select d.DetailId, d.categoryId, d.DetailName, r.DetailContent, r.regDate "
							+ "from rewarddetail d join rewarddetailreg r "  
							+ "on (d.categoryId = r.categoryId and d.DetailId = r.DetailId) " 
							+ "where r.fundingId = ?";
						
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				rs=pstmt.executeQuery();
				while(rs.next()) {
					f = new fundingDetail_returnBean();
					f.setCategoryId(rs.getInt("categoryId"));
					f.setDetailContent(rs.getString("DetailContent"));
					f.setDetailId(rs.getInt("DetailId"));
					f.setDetailName(rs.getString("DetailName"));
					f.setRegDate(rs.getString("regDate"));
					detail.add(f);
				}	
			
			}catch(Exception e) {
				System.out.println("Detail_return: " + e.toString());
			}finally {
				ResouceClose();
			}
		
			return detail;
		}
	 
	 	//펀딩하기 페이지에 보여질 메이커 정보들 - 정지운
	 	public MakerBean getMaker(String id)
	 	   {
	 	     MakerBean mb = null;
	 	     try {
	 	       pstmt = this.con.prepareStatement("select * from maker where userId = ? ");
	 	 	   pstmt.setString(1, id);
	 	       rs = pstmt.executeQuery();
	 	 
	 	       if (rs.next()) {
	 	         mb = new MakerBean();
	 	         mb.setProfile(this.rs.getString("profile"));
	 	         mb.setCeoEmail(this.rs.getString("ceoEmail"));
	 	         mb.setCeoName(this.rs.getString("ceoName"));
	 	         mb.setMakerEmail(this.rs.getString("makerEmail"));
	 	         mb.setMakerHomepage(this.rs.getString("makerHomepage"));
	 	         mb.setMakerTel(this.rs.getString("makerTel"));
	 	         mb.setBankName(this.rs.getString("bankName"));
	 	         mb.setAccountHolder(this.rs.getString("accountHolder"));
	 	         mb.setAccountNumber(this.rs.getString("accountNumber"));
	 	       }
	 	       return mb;
	 	     } catch (Exception e) {
	 	       System.out.println("getMaker:" + e.toString());
	 	     } finally {
	 	       ResouceClose();
	 	     }
	 	 
	 	     return null;
	 	   }
	 	
	 	//펀딩하기 스토리 페이지에 보여질 스토리내용 가져오기 - 정지운
	 	public FundingInfoBean fundingStory(int fundingId) {
	 		FundingInfoBean p = new FundingInfoBean();
	 		String sql = "select title, storyMainImg, storySummary, storyContent from fundinginfo where fundingId = ?";
	 		
	 			try {
	 			pstmt=con.prepareStatement(sql);
	 			pstmt.setInt(1, fundingId);
	 			rs = pstmt.executeQuery();
	 			if(rs.next()) {
	 				p.setTitle(rs.getString("title"));
	 				p.setStoryContent(rs.getString("storyContent"));
	 				p.setStoryMainImg(rs.getString("storyMainImg"));
	 				p.setStorySummary(rs.getString("storySummary"));
	 			}
	 			
	 		}catch(Exception e) {
	 			System.out.println("EndDate:" + e.toString());
	 		}finally{    
	 			ResouceClose();
	 		}
	 		return p;
	 		}
	
}
