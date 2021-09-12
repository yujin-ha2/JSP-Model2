package net.funding.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.RewardBean;

public class fundingDAO {

	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public fundingDAO() {
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
	
	//����Ŀ �� ������, ����Ŀ�� ������ ��� �ݵ��� ���� �޾ƿ��� - ������
	public Vector<AllFundingInfoBean> getInformation(String companyId) {
		Vector<AllFundingInfoBean> v = new Vector<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		
		try {
			String sql = "select f.fundingId, f.title, f.categoryId, f.mainImg, a.userId as 'makerId', a.startDate, a.endDate " 
					   + "from allproject a join fundinginfo f "
					   + "on a.fundingId = f.fundingId "
					   + "where a.userId = ? and a.status in ('start', 'end', 'success', 'fail')";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, companyId);
			rs=pstmt.executeQuery();
				
			while(rs.next()) {
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setTitle(rs.getString("title"));
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setMakerId(rs.getString("makerId"));
				bean.setStartDate(rs.getTimestamp("startDate"));
				bean.setEndDate(rs.getTimestamp("endDate"));
				
				v.add(bean);
			}
		}catch (Exception e) {
				System.out.println("getInformation error : " + e);
		}finally {
			ResouceClose();
		}
		
		return v;
	}

	//����Ŀ �� ������, ����Ŀ�� ������� �ȷο� ���� �޾ƿ��� - ������
	public int follow(String companyId, String id) {
	      try {
	    	  String sql = "select userId from companyFollow where companyId=? and userId=?"; 

 	          pstmt = con.prepareStatement(sql);
 	          pstmt.setString(1, companyId);
	          pstmt.setString(2, id);
	          rs=pstmt.executeQuery();

	          if(rs.next()) {
         	  	return 1;
         	  }
	      } catch (Exception e) {
	          System.out.println("follow error : " + e);
	      }finally {
			  ResouceClose();
		  }
	      return 0;
	   }

	//����Ŀ �� ������, ����Ŀ�� �ȷο� ���� �޾ƿ��� - ������
	public int countFollow(String companyId) {
		int followCount=0;
		try {
			String sql = "select count(*) from companyFollow where companyId=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, companyId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				followCount=rs.getInt(1);
			}
		}catch (Exception e) {
			System.out.println("countFollow error " + e);
		}finally {
			ResouceClose();
		}
		
		return followCount;
	}

	//����Ŀ�� ������ ��� �ݵ� ���� �޾ƿ��� - ������
	public int countFunding(String companyId) {
		int fundingCount=0;
		try {
			String sql = "select count(*) from allproject where userId=? and status in ('start', 'end', 'success', 'fail')";
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
	
	//�ȷο�, �ȷο� ��� ó�� - ������
	public int followCompany(String id, String companyId, int followbtn) {
		int followCount = 0;
		String sql = null;

		if(followbtn==0) 
			sql = "insert into companyFollow (userId, companyId) values(?,?)";
		else
			sql = "delete from companyFollow where userId=? and companyId=?";
			
		try{
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, companyId);
						
			int rst = pstmt.executeUpdate();
			
			if(rst == 1) {
			    sql = "select count(*) from companyFollow where companyId=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, companyId);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					followCount=rs.getInt(1);
				}
			}
			
		}catch (Exception e) {
			System.out.println("followCompany error " + e);
		}finally {
			ResouceClose();
		}
		
		return followCount;
	}

	
	//
	public Vector<AllFundingInfoBean> getAllFundinglist(int category, int statusVal, int sortVal){
		Vector<AllFundingInfoBean> v = new Vector<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		String sql=null;
		try {
			
			if(category==0) {
				if(statusVal==0) {//�Ǹ���
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' order by f.title desc"; //���ƿ� ������ ���� �ʿ�
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' order by f.salesTarget desc"; //��ǥ�ݾ� ���� ��ݵȰ� ���� �ʿ�
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' order by a.endDate desc";
					}
				}else{//������
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' order by a.endDate desc";
					}
				}
				pstmt = con.prepareStatement(sql);
			}else{
				if(statusVal==0) {//�Ǹ���
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' and f.categoryId=? order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' and f.categoryId=? order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' and f.categoryId=? order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='start' and f.categoryId=? order by a.endDate desc";
					}
				}else{//������
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' and f.categoryId=? order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' and f.categoryId=? order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' and f.categoryId=? order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundingId = f.fundingId where a.status='end' and f.categoryId=? order by a.endDate desc";
					}
				}
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, category);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId")); //fundinginfo
				bean.setTitle(rs.getString("title"));		//fundinginfo
				bean.setCategoryId(rs.getInt("categoryId"));	//fundinginfo
				bean.setMainImg(rs.getString("mainImg"));	//fundinginfo
				bean.setMakerId(rs.getString("userId"));	//allproject userId
				bean.setEndDate(rs.getTimestamp("endDate"));	//allproject
				bean.setStartDate(rs.getTimestamp("startDate"));	//allproject
				
				v.add(bean);
			}
		}catch (Exception e) {
			System.out.println("getAllFundinglist���� : "+e);
		}finally {
			ResouceClose();
		}
		return v;
	}


	//
	public Vector<AllFundingInfoBean> FundingTextListAction(int category, int statusVal, int sortVal, String text) {
		Vector<AllFundingInfoBean> v = new Vector<AllFundingInfoBean>();
		AllFundingInfoBean bean = null;
		String sql = null;
		try {
			
			if(category==0) {
				if(statusVal==0) {//�Ǹ���
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.title LIKE '%"+text+"%' order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.title LIKE '%"+text+"%' order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.title LIKE '%"+text+"%' order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.title LIKE '%"+text+"%' order by a.endDate desc";
					}
				}else{//������
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.title LIKE '%"+text+"%' order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.title LIKE '%"+text+"%' order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.title LIKE '%"+text+"%' order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.title LIKE '%"+text+"%' order by a.endDate desc";
					}
				}
				pstmt = con.prepareStatement(sql);
			}else{
				if(statusVal==0) {//�Ǹ���
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.categoryId=? and f.title LIKE '%"+text+"%' order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.categoryId=? and f.title LIKE '%"+text+"%' order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.categoryId=? and f.title LIKE '%"+text+"%' order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='start' and f.categoryId=? and f.title LIKE '%"+text+"%' order by a.endDate desc";
					}
				}else{//������
					if(sortVal==0) { //�ֽż�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.categoryId=? and f.title LIKE '%"+text+"%' order by a.startDate desc";
					}else if(sortVal==1) {//�α��
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.categoryId=? and f.title LIKE '%"+text+"%' order by f.title desc";
					}else if(sortVal==2) {//�ݵ��׼�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.categoryId=? and f.title LIKE '%"+text+"%' order by f.salesTarget desc";
					}else if(sortVal==3) {//�����ӹڼ�
						sql = "select * from allproject a join fundinginfo f on a.fundinginfo = f.fundingId where a.status='end' and f.categoryId=? and f.title LIKE '%"+text+"%' order by a.endDate desc";
					}
				}
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, category);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				bean = new AllFundingInfoBean();
				bean.setFundingId(rs.getInt("fundingId"));
				bean.setTitle(rs.getString("title"));
				bean.setCategoryId(rs.getInt("categoryId"));
				bean.setMainImg(rs.getString("mainImg"));
				bean.setMakerId(rs.getString("userId"));
				bean.setEndDate(rs.getTimestamp("endDate"));
				bean.setStartDate(rs.getTimestamp("startDate"));
				
				v.add(bean);
			}
		}catch (Exception e) {
			System.out.println("FundingTextListAction ���� : "+e);
		}finally {
			ResouceClose();
		}
		return v;
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
			System.out.println("getAllFundingRank ���� : "+e);
		}finally {
			ResouceClose();
		}
		return v;
	}

	public int fundingDetailSupportCount(int fundingId) {
		String sql = "select count(*) from fundingorder where fundingId=? and cancel=0";
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,fundingId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1);
			}else {
				return 0;
			}
		} catch (Exception e) {
			System.out.println("fundingDetailSupportCount ���� : "+e);
		} finally {
			ResouceClose();
		}
		return 0;
	}
	
	// �ݵ� ������ , ������ - ������
	public Vector<fundingOrderBean> fundingDetailSupportList(int fundingId) {
		Vector<fundingOrderBean> v = new Vector<fundingOrderBean>();
		fundingOrderBean bean = null;
		try {
			String sql = "select * from fundingorder f join member m on f.userId = m.id where f.fundingId=? and f.cancel=0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,fundingId);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bean = new fundingOrderBean();
				bean.setUserId(rs.getString("userId"));
				bean.setAmount(rs.getInt("amount"));
				bean.setReceiver(rs.getString("profile")); //��� ������
				v.add(bean);
			}
		}catch (Exception e) {
			System.out.println("fundingDetailSupportList error : "+e);
		}finally {
			ResouceClose();
		}
		return v;
	}

	//������ ���ý� ajax - ������
	public RewardBean getdetail(int fundingId, String num) {
		
		RewardBean bean = new RewardBean();
		String sql = "select rewardOption, name from reward where fundingId = ? and rewardId = ?";
		
		try {
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
			ResouceClose();
		}
		return bean;
	}
	
	
}
