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
	

	//����Ŀ ���� ������� ����Ŀ ��� ó��
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
	
	//����Ŀ ���� Ȯ�� - ������
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

	//���ο� ������Ʈ ���� - ������
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

	//���� ���� ������Ʈ ȭ�鿡 �ʿ��� ������ �������� - ������
	public List<myProjectBean> getProjectList(String id) {
		//����Ŀ�̸�, ��ǥ�̹���, ������Ʈ ��, ����
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
	
	//����Ŀ ��Ʃ��� ���� ȭ��, �ܰ躰 ���� ��������
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
	
	//����Ŀ ��Ʃ���, ���� �޾ƿ��� - ������
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

	//�⺻ ��� ��� - ������
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
	
	//�⺻ ��� �޾ƿ��� - ������
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

	//�⺻ ��� ���� - ������
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
	
	//�⺻ ���� ���
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

	//�⺻ ���� �������� - ������
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

	//�⺻ ���� �����ϱ� - ������
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

	//����Ŀ �⺻���� �������� - ������
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
	
	//����Ŀ �� ���� �������� - ������
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

	//����Ŀ �� ���� ���� - ������
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
			
			if(result == 1 && fundingId != 0) { //���� allproject�� maker �ʵ� ���� 0�� ���
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
	
	//�ݵ���Ȳ �������� �� �� ���� - ������ ���� ���⼭ ��
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
	
	 //�ݵ���Ȳ ������ ������ �ݾ� * �Ǹŵ� ���� �������� - ������
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
	 
	 //�ݵ���Ȳ ������ �ֱ��Ϸ� �Ǹűݾ�,����  �ݾ��� ��ۺ� ����Ʈ ���ܵ� ���������ݾ� - ������
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
	 
	 //�ݵ���Ȳ ������ �ֱ������� �Ǹűݾ�,����  �ݾ��� ��ۺ� ����Ʈ ���ܵ� ���������ݾ� - ������
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

	 //�ݵ���Ȳ �׷����� �� ���� ������ ������������ - ������
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
	 
	 //�ݵ��ϱ� �׷����� �� ���� - ������
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
	 
	 //������������ �� �ݵ������� ������ ������������ - ������
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

	 //�������������� �Է��� ���� ��� �ֱ� - ������
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
	 
	 //����Ȯ�� �������� ������ ������������ - ������
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
	 //������ ������ �������� - ������
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
	 //������ �ݵ����������� ���̺� ������ �־��ֱ� - ������
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
	 
	 	//�ݵ��ϱ� �������� ������ �ش��ݵ� ���ᳯ¥  - ������
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
	 	
	 	//�ݵ��ϱ� ������ ���������� ������ �޾�Ű�� �Է°� ��������.
	 	//rewarddetail2���̺��� ����Ŀ�� ������ �������� �Է½� �� ���̺��, ���̺��̸��� ��ø�Ǽ� 2�� ����. ����������...?
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
	 
	 	//�ݵ��ϱ� �������� ������ ����Ŀ ������ - ������
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
	 	
	 	//�ݵ��ϱ� ���丮 �������� ������ ���丮���� �������� - ������
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
