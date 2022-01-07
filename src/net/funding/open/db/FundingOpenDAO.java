package net.funding.open.db;

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

import jdk.management.resource.internal.TotalResourceContext;
import net.action.CategoryName;
import net.funding.db.PaymentBean;

public class FundingOpenDAO {
	
	DataSource ds;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public FundingOpenDAO() {
		try {
			Context init = new InitialContext();
			ds = (DataSource)init.lookup("java:comp/env/jdbc/funding");
		}catch(Exception e) {
			System.out.println("DB���� ����: " +e);
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
	

	//����Ŀ ���� ������� ����Ŀ ��� ó��
	public boolean insertEasyMaker(MakerBean maker) {
		
		try {
			String sql="insert into maker(userId, name, type) values(?,?,?)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, maker.getUserId());
			pstmt.setString(2, maker.getName());
			pstmt.setString(3, maker.getType());
			int result = pstmt.executeUpdate();
			
			if(result == 1 ) {
				sql = "update member set makerNo = (select makerNo from maker where userId = '"+maker.getUserId()+"'), authority='�Ǹ���' where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, maker.getUserId());
				pstmt.executeUpdate();
				return true;
			}
			
		}catch(Exception e) {
			System.out.println("insertEasyMaker Error " + e.toString());
		}finally {
			ResourceClose();
		}
		return false;
	}
	
	//����Ŀ ���� Ȯ�� - ������
	public boolean confirmUserStatus(String id) {
		boolean result = false;
		String sql="select makerNo from member where id = ?";
		try {
			con = ds.getConnection();
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
			ResourceClose();
		}
		return result;
	}

	//���ο� ������Ʈ ���� - ������
	public int insertNewProject(String id) {
		
		String sql="insert into allproject(userId, makerNo) (SELECT userId, makerNo from maker where userId = '"+id+"')";   //����ؾ� ��
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				//sql = "select fundingId from allproject where userId = ? order by regDate desc limit 1";
				sql = "select max(fundingId) as fundingId from allproject group by userId having userId=?";  
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next())
					return rs.getInt("fundingId");
			}
		}catch(Exception e) {
			System.out.println("insertNewProject error : " + e.toString());
		}finally {
			ResourceClose();
		}
		return 0;
	}

	//���� ���� ������Ʈ ȭ�鿡 �ʿ��� ������ �������� - ������
	public List<myProjectBean> getProjectList(String id) {
		//����Ŀ�̸�, ��ǥ�̹���, ������Ʈ ��, ����
		List<myProjectBean> list = new ArrayList<myProjectBean>();
		myProjectBean bean = null;
		String sql= "select a.fundingId, a.status, m.name, f.mainImg, f.title " + 
					"from allproject a " + 
					"join maker m " + 
					"on a.userId = m.userId " + 
					"join fundinginfo f " + 
					"on a.fundingId = f.fundingId " + 
					"where a.userId = ? " + 
					"union all " + 
					"select  a.fundingId, a.status, m.name, 'noImg.PNG', '������ �Է����ּ���.' " + 
					"from allproject a " + 
					"join maker m " + 
					"on a.userId = m.userId " + 
					"where not exists ( select fundingId " +
										"from fundinginfo " +
										"where fundingId = a.fundingId ) " +
					"and a.userId = ?";						
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new myProjectBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setStatus(rs.getString("status"));
				bean.setMakerName(rs.getString("name"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setTitle(rs.getString("title"));
				System.out.println("fundingId:" + bean.getFundingId());
				list.add(bean);
			}
		}catch(Exception e) {
			System.out.println("getProjectList error : " + e.toString());
		}finally {
			ResourceClose();
		}
		return list;
	}
	
	//����Ŀ ��Ʃ��� ���� ȭ��, �ܰ躰 ���� ��������
	public List<String> getProjectStatus(int fundingId) {
		List<String> statusList = new ArrayList<String>();
		String sql="select requirement, fundinginfo, reward, rewarddetail, maker, status from allproject where fundingId = ?";
		try {
			con = ds.getConnection();
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
			ResourceClose();
		}
		return statusList;
	}
	
	//����Ŀ ��Ʃ���, ���� �޾ƿ��� - ������
	public AllProject getStatus(int fundingId, String field) {
		AllProject project = null;
		System.out.println("field Length: " + field.length());
		String fieldName = "";
		if(field.length() > 1)
			fieldName = ", " + field;
		String sql = "select status" + fieldName + " from allproject where fundingId = ?";
		System.out.println("sql: " + sql);
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				project = new AllProject();
				project.setStatus(rs.getString(1));
				if(field.length() > 1)
					project.setIsReg(rs.getInt(2));
			}
		}catch(Exception e) {
			System.out.println("getStatus error : " + e.toString());
		}finally {
			ResourceClose();
		}
		
		return project;
	}

	//�ݵ� ������ ���� ��û(=�����)
	public int RequestForApproval(int fundingId) {
		int result = 0;
		String sql = "update allproject set status = 'submission', submitDate = ? where fundingId = ?"; 
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			Timestamp date = new Timestamp(System.currentTimeMillis());
			System.out.println("date: " + date); 
			pstmt.setTimestamp(1, date); 
			pstmt.setInt(2, fundingId);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("RequestForApproval : " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//�⺻ ��� ��� - ������
	public int insertRequirement(RequirementsBean bean) {
		int result = 0;
		String sql = "insert into requirement(q1, differ, reward, delivery, q4, fundingId) values (?, ?, ?, ?, ?, ?)";
		
		try {
			con = ds.getConnection();
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
			ResourceClose();
		}
		return result;
	}
	
	//�⺻ ��� �޾ƿ��� - ������
	public RequirementsBean getRequirement(int fundingId) {
		RequirementsBean bean = null;
		
		String sql = "select q1, differ, reward, delivery, q4, fundingId from requirement where fundingId = ?";
		try {
			con = ds.getConnection();
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
			ResourceClose();
		}
		return bean;
	}

	//�⺻ ��� ���� - ������
	public int updateRequirment(RequirementsBean bean) {
		int result = 0;
		String sql = "update requirement set q1=?, differ=?, reward=?, delivery=?, q4=? where fundingId = ?";
		
		try {
			con = ds.getConnection();
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
			ResourceClose();
		}
		return result;
	}
	
	//�⺻ ���� ���
	public int insertBasicInfo(FundingInfoBean bean) {
//		System.out.println("��Ͻ���");
//		System.out.println("mainImg: " + bean.getMainImg());
//		System.out.println("categoryId: " + bean.getCategoryId());
//		System.out.println("storyMainImg: " + bean.getStoryMainImg());
		
		int result = 0;
		String sql = "insert into fundingInfo(fundingId, title, salesTarget, mainImg, categoryId, storyMainImg, storySummary, storyContent, startdate, enddate) "
				   + "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getFundingId());
			pstmt.setString(2, bean.getTitle());
			pstmt.setInt(3, bean.getSalesTarget());
			pstmt.setString(4, bean.getMainImg());
			pstmt.setInt(5, bean.getCategoryId());
			pstmt.setString(6, bean.getStoryMainImg());
			pstmt.setString(7, bean.getStorySummary());
			pstmt.setString(8, bean.getStoryContent());
			pstmt.setTimestamp(9, bean.getStartdate());
			pstmt.setTimestamp(10, bean.getEnddate());
			
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
			ResourceClose();
		}
		return result;
	}

	//�⺻ ���� �������� - ������
	public FundingInfoBean getFundingInfo(int fundingId) {
		FundingInfoBean bean = null;
		
		String sql = "select title, salesTarget, mainImg, categoryId, storyMainImg, storySummary, storyContent, " +
					 "startdate, enddate, fundingId from fundinginfo where fundingId = ?";
		try {
			con = ds.getConnection();
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
				bean.setStartdate(rs.getTimestamp("startdate")); //
				bean.setEnddate(rs.getTimestamp("enddate")); 	 //
				bean.setFundingId(rs.getInt("fundingId"));
			}
		}catch(Exception e) {
			System.out.println("getFundingInfo error : " + e.toString());
		}finally {
			ResourceClose();
		}
		return bean;
	}

	//�⺻ ���� �����ϱ� - ������
	public int updateBasicInfo(FundingInfoBean bean) {
		int result = 0;
		String sql = "update fundinginfo set title=?, salesTarget=?, mainImg=?, categoryId=?, storyMainImg=?, storySummary=?, storyContent=?, startdate=?, enddate=? " 
				   + "where fundingId = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getTitle());
			pstmt.setInt(2, bean.getSalesTarget());
			pstmt.setString(3, bean.getMainImg());
			pstmt.setInt(4, bean.getCategoryId());
			pstmt.setString(5, bean.getStoryMainImg());
			pstmt.setString(6, bean.getStorySummary());
			pstmt.setString(7, bean.getStoryContent());
			pstmt.setTimestamp(8, bean.getStartdate()); 
			pstmt.setTimestamp(9, bean.getEnddate());	
			pstmt.setInt(10, bean.getFundingId());
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("updateBasicInfo : " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//������  ���� - ������
	public int deleteReward(int fundingId) {
	
		int result = 0;
		String sql = "delete from reward where fundingId=?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("deleteReward: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}

	//������ ��� - ������
	public int insertReward(int fundingId, List<RewardBean> list, String mode) {
		int result = 0;
		String sql = "insert into reward(fundingId, price, rewardOption, rewardDetail, deliveryFee, salesQuantity, remainingQuantity, deliveryDate) values(?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			
			if(mode.equals("update")) 
				deleteReward(fundingId);
				
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			for(RewardBean bean : list) {
				pstmt.setInt(1, fundingId);
				pstmt.setInt(2, bean.getPrice());
				pstmt.setString(3, bean.getRewardOption());
				pstmt.setString(4, bean.getRewardDetail());
				pstmt.setInt(5, bean.getDeliveryFee());
				pstmt.setInt(6, bean.getSalesQuantity());
				pstmt.setInt(7, bean.getSalesQuantity());
				pstmt.setString(8, bean.getDeliveryDate());
				result = pstmt.executeUpdate();
			}
			
			if(result == 1) {
				sql = "update allproject set reward = 1 where fundingId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				pstmt.executeUpdate();
			}
		
		}catch(Exception e) {
			result = 0;
			System.out.println("insertReward: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//������ ����Ʈ �޾ƿ��� (ajax) - ������
	public List<RewardBean> getRewards(int fundingId) {
		List<RewardBean> list = new ArrayList<RewardBean>();
		RewardBean bean = null;
		
		String sql= "select fundingId, price, rewardOption, rewardDetail, deliveryFee, salesQuantity, deliveryDate from reward where fundingId = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new RewardBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setPrice(rs.getInt("price"));
				bean.setRewardOption(rs.getString("rewardOption"));
				bean.setRewardDetail(rs.getString("rewardDetail"));
				bean.setDeliveryFee(rs.getInt("deliveryFee"));
				bean.setSalesQuantity(rs.getInt("salesQuantity"));
				bean.setDeliveryDate(rs.getString("deliveryDate"));
				list.add(bean);
			}
		}catch(Exception e) {
			System.out.println("getRewards error : " + e.toString());
		}finally {
			ResourceClose();
		}
	
		return list;
	}
	
	//������ ������ ���� - ������
	public int deleteRewardDetail(int fundingId) {
	
		int result = 0;
		String sql = "delete from rewarddetail_list where fundingId=?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("deleteRewardDetail: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}

	//������ ������ ����ϱ� - ������
	public int insertRewardDetail(int fundingId, List<rewardInfoBean> list, String mode) {
		
		int result = 0;
		String sql = "insert into rewarddetail_list(fundingId, categoryId, DetailId, DetailContent) values(?, ?, ?, ?)";
		
		try {
			System.out.println("insertRewardDetail"); 
			result = (mode.equals("update")) ? deleteRewardDetail(fundingId) : 0;  
				
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			for(rewardInfoBean bean : list) {
				pstmt.setInt(1, fundingId);
				pstmt.setInt(2, bean.getCategoryId());
				pstmt.setInt(3, bean.getDetailId());
				pstmt.setString(4, bean.getDetailContent());
				result = pstmt.executeUpdate();
			}
			
		}catch(Exception e) {
			result = 0;
			System.out.println("insertRewardDetail: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//������ ��å ����ϱ� - ������
	public int insertRewardPolicy(int fundingId, String policy) {

		int result = 0;
		String sql = "insert into rewardpolicy(fundingId, policy) values(?, ?)";
		try {
			System.out.println("insertRewardPolicy");
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			pstmt.setString(2, policy);
			result = pstmt.executeUpdate();
			
			if(result == 1) {
				sql = "update allproject set rewarddetail = 1 where fundingId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, fundingId);
				pstmt.executeUpdate();
			}
			
		}catch (Exception e) {
			System.out.println("insertRewardPolicy: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//������ ��å �����ϱ� - ������
	public int updateRewardPolicy(int fundingId, String policy) {

		int result = 0;
		String sql = "update rewardpolicy set policy=?, updateDate=? where fundingId=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			Timestamp time = new Timestamp(System.currentTimeMillis());

			pstmt.setString(1, policy);
			pstmt.setTimestamp(2, time);
			pstmt.setInt(3, fundingId);
			result = pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("updateRewardPolicy: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}
	
	//������  ī�װ� ���� �������� - ������
	public Vector<rewardInfoBean> getCategoryDetails(int categoryId) {
		Vector<rewardInfoBean> vector = new Vector<rewardInfoBean>();
		rewardInfoBean bean = null;
		
		String sql = "select * from rewarddetail where categoryId = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, categoryId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new rewardInfoBean();
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setDetailId(rs.getInt("DetailId"));
				bean.setDetailName(rs.getString("DetailName"));
				bean.setExample(rs.getString("Example"));
				vector.add(bean);
			}
		}catch(Exception e) {
			System.out.println("getCategoryDetails error : " + e.toString());
		}finally {
			ResourceClose();
		}
		
		return vector;
	}
	
	//��ϵ� ������ ������ ��� �������� - ������
	public List<rewardInfoBean> getRewardsInfoList(int fundingId){
		List<rewardInfoBean> list = new ArrayList<rewardInfoBean>();
		rewardInfoBean bean = null;
		
		String sql = "select list.fundingId, detail.categoryId, detail.DetailId, detail.DetailName, detail.Example, list.DetailContent "
				   + "from rewarddetail detail join rewarddetail_list list " 
				   + "on detail.DetailId = list.DetailId and list.fundingId=? "
				   + "order by categoryId desc";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new rewardInfoBean();
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setDetailId(rs.getInt("DetailId"));
				bean.setDetailName(rs.getString("DetailName"));
				bean.setExample(rs.getString("Example"));
				bean.setDetailContent(rs.getString("DetailContent"));
				list.add(bean);	
			}
		}catch(Exception e) {
			System.out.println("getRewardsInfoList error : " + e.toString());
		}finally {
			ResourceClose();
		}
		
		return list;
	}
	
	//������ ��å �������� - ������
	public String getRewardPolicy(int fundingId) {
		String policy = "";
		String sql = "select policy from rewardpolicy where fundingId = ?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				policy = rs.getString("policy");
			}
		}catch(Exception e) {
			System.out.println("getRewardPolicy error : " + e.toString());
		}finally {
			ResourceClose();
		}
		
		return policy;
	}
	
	//����Ŀ �⺻���� �������� - ������
	public MakerBean getMakerInfo(int fundingId) {
		MakerBean bean = null;
		
		String sql = "select name, type, userId from maker where userId = (select userId from allproject where fundingId = ?)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new MakerBean();
				bean.setName(rs.getString("name"));
				bean.setType(rs.getString("type"));
			}
		}catch(Exception e) {
			System.out.println("getMakerInfo error : " + e.toString());
		}finally {
			ResourceClose();
		}
		
		return bean;
	}
	
	//����Ŀ �� ���� �������� - ������
	public MakerBean getMakerDetail(int fundingId) {
		MakerBean bean = null;
		
		String sql = "select name, type, ceoName, ceoEmail, profile, makerEmail, makerTel, makerHomepage, bankName, accountNumber, accountHolder " 
				   + "from maker where userId = ( select userId from allproject where fundingId = ?)";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
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
			ResourceClose();
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
			con = ds.getConnection();
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
			ResourceClose();
		}
		return result;
	}
	

	//(����Ŀ ��Ʃ���, ����Ŀ) ������ �������� member ���̺��� �����ʷ� ����
	public void setProfile(String profile, String id) {
		String sql = "update member set profile = ? where id = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, profile);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("setProfile : " + e.toString());
		}finally {
			ResourceClose();
		}
	}
	
 	//(����Ŀ��Ʃ���, �ݵ���Ȳ) �⺻ ���� - ������, ������
	public FundingReport getFundingReportInfo(int fundingId) {
		FundingReport report = new FundingReport();
		try {
			String sql = "select f.fundingId, m.name, f.title, f.salesTarget, f.totalRevenue, (f.totalRevenue/f.salesTarget)*100 as achievement, " + 
						 "f.startdate, f.enddate, datediff(f.enddate, now()) as daydiff, m.bankName, m.accountNumber, accountHolder " + 
						 "from fundinginfo f join allproject a on f.fundingId = a.fundingId " + 
						 "join maker m on a.userId = m.userId where a.fundingId = ?";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				report.setFundingId(rs.getInt("fundingId"));
				report.setMakerName(rs.getString("name"));
				report.setFundingTitle(rs.getString("title"));
				report.setSalesTarget(rs.getInt("salesTarget"));
				report.setTotalRevenue(rs.getInt("totalRevenue"));
				report.setAchievement(rs.getInt("achievement"));
				report.setStartDate(rs.getTimestamp("startdate"));
				report.setEndDate(rs.getTimestamp("enddate"));
				int dayDiff = rs.getInt("daydiff");
				if(dayDiff < 0)
					report.setDayDiff(0);
				else
					report.setDayDiff(dayDiff);
				report.setBankName(rs.getString("bankName"));
				report.setAccountNumber(rs.getString("accountNumber"));
				report.setAccountHolder(rs.getString("accountHolder"));
			}	
		
		}catch(Exception e) {
			System.out.println("getFundingReportInfo: " + e.toString());
		}finally {
			ResourceClose();
		}
		
		return report;
	}

	//(����Ŀ��Ʃ���, �ݵ���Ȳ) ������ ���� �ݾ� - ������, ������
	public int getTodayRevenue(int fundingId) {
		int todayRevenue = 0;
		try {
			String sql = "select sum(finalAmount) as todayRevenue from fundingorder " + 
					 	 "where fundingId=? and date(orderDate) = date(now()) " + 
					 	 "group by fundingId";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				todayRevenue = rs.getInt("todayRevenue");
			}	
		
		}catch(Exception e) {
			System.out.println("getTodayRevenue: " + e.toString());
		}finally {
			ResourceClose();
		}
		return todayRevenue;
	}
	
	//(����Ŀ��Ʃ���, �ݵ���Ȳ) ��¥�� �����Ȳ - ������, ������
	public List<FundingStatistic> getQuantityByDate(int fundingId) {
		List<FundingStatistic> statisticList = new ArrayList<FundingStatistic>();
		FundingStatistic statistic = null;
		try {
			String sql = "select date_format(t.date, '%m-%d') as date, ifnull(o.actual, 0) as actual from temp_date t " + 
						 "left outer join ( " + 
						 	"select date_format(orderDate, '%Y-%m-%d') as orderDate, sum(finalAmount) as actual " + 
						 	"from fundingorder " + 
						 	"where fundingId=? and cancel=0 " + 
						 	"group by date_format(orderDate, '%Y-%m-%d') " + 
						 ") o " + 
						 "on t.date = o.orderDate " + 
						 "where t.date >= (select startdate from fundinginfo where fundingId=?) and t.date <= (select enddate from fundinginfo where fundingId=?) " + 
						 "order by t.date asc";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			pstmt.setInt(2, fundingId);
			pstmt.setInt(3, fundingId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				statistic = new FundingStatistic();
				statistic.setDate(rs.getString("date"));
				statistic.setActual(rs.getInt("actual"));
				statisticList.add(statistic);
			}	
		
		}catch(Exception e) {
			System.out.println("getQuantityByDate: " + e.toString());
		}finally {
			ResourceClose();
		}
		return statisticList;
	}

	//(����Ŀ��Ʃ���, �ݵ���Ȳ) �ɼǺ� �����Ȳ - ������, ������
	public List<FundingStatistic> getQuantityByOption(int fundingId) {
		List<FundingStatistic> statisticList = new ArrayList<FundingStatistic>();
		FundingStatistic statistic = null;
		try {
			String sql = "select r.rewardOption, ifnull(od.quantity, 0) as quantity " + 
						 "from reward r left outer join ( " + 
						 	"select rewardId, sum(quantity) as quantity from fundingorderdetails " + 
						 	"where orderId in (select orderId from fundingorder where fundingId=? and cancel=0) " + 
						 	"group by rewardId) as od " + 
						 "on r.rewardId = od.rewardId " + 
						 "where r.fundingId = ?";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			pstmt.setInt(2, fundingId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				statistic = new FundingStatistic();
				statistic.setRewardOption(rs.getString("rewardOption"));
				statistic.setQuantity(rs.getInt("quantity"));
				statisticList.add(statistic);
			}	
		
		}catch(Exception e) {
			System.out.println("getQuantityByOption: " + e.toString());
		}finally {
			ResourceClose();
		}
		return statisticList;
	}

	//(����Ŀ��Ʃ���, �ݵ���Ȳ) ������ �ɼǺ� �����Ȳ - ������, ������
	public List<FundingStatistic> getTodayQuantity(int fundingId) {
		List<FundingStatistic> statisticList = new ArrayList<FundingStatistic>();
		FundingStatistic statistic = null;
		
		try {
			String sql = "select r.rewardOption, ifnull(od.quantity, 0) as quantity " + 
					 	 "from reward r left outer join  " + 
					 	 	"(select rewardId, sum(quantity) as quantity from fundingorderdetails " + 
					 	 	"where orderId in (select orderId from fundingorder where date(orderDate) = date(now()) and cancel=0) " + 
					 	 	"group by rewardId ) as od  " + 
					 	 "on r.rewardId = od.rewardId " + 
					 	 "where r.fundingId = ?";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				statistic = new FundingStatistic();
				statistic.setRewardOption(rs.getString("rewardOption"));
				statistic.setQuantity(rs.getInt("quantity"));
				statisticList.add(statistic); 
			}	
			
		}catch(Exception e) {
			System.out.println("getTodayQuantity: " + e.toString());
		}finally {
			ResourceClose();
		}
		return statisticList;
		
	}

	//(����Ŀ��Ʃ���, �ݵ����) �ֹ� ���� - ������, ������
	public int getOrderCount(int fundingId) {
		int orderCount = 0;
		try {
			String sql = "select count(orderId) as orderCount from fundingorder where fundingId=?";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				orderCount = rs.getInt("orderCount");
			}	
		
		}catch(Exception e) {
			System.out.println("getOrderCount: " + e.toString());
		}finally {
			ResourceClose();
		}
		return orderCount;
	}
	
	//(����Ŀ��Ʃ���, �ݵ����) ��� �ֹ� ���� - ������, ������
	public int getCancelCount(int fundingId) {
		int cancelCount = 0;
		try {
			String sql = "select count(orderId) as cancelCount from fundingorder where cancel = 1 and fundingId=?";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cancelCount = rs.getInt("cancelCount");
			}	
		
		}catch(Exception e) {
			System.out.println("getCancelCount: " + e.toString());
		}finally {
			ResourceClose();
		}
		return cancelCount;
	}

	//(����Ŀ��Ʃ���, �ݵ����) �ݵ� ���� ���� - ������, ������
	public FundingResult getFundingResult(int fundingId) {
		FundingResult result = new FundingResult();
		try {
			String sql = "select sum(donation) as donation, sum(usedPoint) as usedPoint, sum(deliveryFee) as deliveryFee, " + 
						 "sum(finalAmount) as finalAmount, (sum(usedPoint)+sum(finalAmount))*0.07 as commission " + 
						 "from fundingorder where cancel = 0 and fundingId=?";
			
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result.setDonation(rs.getInt("donation"));
				result.setUsedPoint(rs.getInt("usedPoint"));
				result.setDeliveryFee(rs.getInt("deliveryFee"));
				result.setFinalAmount(rs.getInt("finalAmount"));
				result.setCommission(rs.getInt("commission"));
			}	
		
		}catch(Exception e) {
			System.out.println("getCancelCount: " + e.toString());
		}finally {
			ResourceClose();
		}
		return result;
	}

}
