package net.member.db;

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

import net.action.CategoryName;
import net.action.StatusName;
import net.funding.db.PaymentBean;
import net.funding.db.ReceiverBean;
import net.funding.open.db.MakerBean;
import net.funding.open.db.RewardBean;

public class MemberDAO {

	Connection con;
	DataSource ds;
	ResultSet rs;
	PreparedStatement pstmt;
	
	public MemberDAO() {
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
	
	//ȸ������ ó�� - ��ΰ�
	public boolean insertMember(MemberBean mb) {
	    int result = 0; //ȸ������ ��������
	    String sql = "insert into member (id,pwd,name,phone,email) values(?,?,?,?,?)";
		try {
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(pwd.equals(rs.getString("pwd"))) {
					return 1;
				}
			}
		} catch (Exception e) {
			System.out.println("LoginUserCheck error: " + e);
		}finally {
			ResouceClose();
		}
		return  0;
	}
	
	//�α��ν� ����� ���� �������� - ������ 
	public String getUserAuthority(String id) {
		String authority = "";
		String sql = "select authority from member where id = ?";
		try {
			con = ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				authority = rs.getString("authority");
			}
		} catch (Exception e) {
			System.out.println("getUserAuthority error: " + e);
		}finally {
			ResouceClose();
		}
		return authority;
	}
	
	//ȸ������ �� ���̵� ��ȿ�� üũ - ��ΰ�
	public int idCheck(String id) {
		String sql = "select id from member where id=?";
		try {
			con = ds.getConnection();
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
        	con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new MemberBean();
				bean.setEmail(rs.getString("email"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getString("phone"));
				bean.setPoint(rs.getInt("point"));
				//bean.setCoupon(rs.getInt("coupon_check"));
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
			con = ds.getConnection();
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
	public int profileImgUpdate(String file, String id, String type) {
		int result = 0;
		String sql = (type.equals("supporter")) ? "update member set profile = ? where id = ?" : "update maker set profile = ? where userId = ?";

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,file);
			pstmt.setString(2,id);
			result = pstmt.executeUpdate();
							
		} catch (Exception e) {
			System.out.println("profileImgUpdate error : " + e);
		}finally {
			ResouceClose();
		}
		return result;
	}

	//����������(������) ������, �ȷο��� ȸ�縮��Ʈ �޾ƿ��� - ������
	public Vector<MakerBean> myFollowList(String id, String type) {
		
		Vector<MakerBean> makerVector = new Vector<MakerBean>();
		MakerBean bean = null;

		String sql = (type.equals("supporter")) ? 
					"select userId, name, profile from maker where userId in (select makerId from companyfollow where userId = ?)" :
					"select id, name, profile from member where id in (select userId from companyfollow where makerId = ?)";
		String field = (type.equals("supporter")) ? "userId" : "id";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				do {
					bean = new MakerBean();
					bean.setUserId(rs.getString(field));
					bean.setName(rs.getString("name"));
					bean.setProfile(rs.getString("profile"));
					makerVector.add(bean);
				}while(rs.next());
			} 
		} catch (Exception e) {
			System.out.println("myFollowList error : " + e);
		} finally{
			ResouceClose();
		}
		
		return makerVector;
	}

	//����Ŀ ���������� - ������ ���� �������� ������
	public String getMakerProfile(String id) {
		String profile = "";
		String sql = "select profile from maker where userId=?";
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				profile = rs.getString("profile");
			}
		}catch (Exception e) {
			System.out.println("getMakerProfile error : " + e);
		}finally {
			ResouceClose();
		}
		return profile;
	}

	//(����������) ���� �ݵ� ��������Ʈ - ������
	public List<FundingHistoryBean> getHistoryList(String userId) {
		List<FundingHistoryBean> historyList = new ArrayList<FundingHistoryBean>();
		FundingHistoryBean history = null;
		String sql = "select o.orderId, o.receiverId, f.fundingId, f.categoryId, f.title, a.status, m.name as makerName, o.orderDate, o.cancel " + 
					 "from fundinginfo f join fundingorder o on f.fundingId= o.fundingId " + 
					 "join allproject a on f.fundingId = a.fundingId " + 
					 "join maker m on m.userId = a.userId where o.userId = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,userId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				history = new FundingHistoryBean();
				history.setOrderId(rs.getString("orderId"));
				history.setReceiverId(rs.getInt("receiverId"));
				history.setFundingId(rs.getInt("fundingId"));
				String categoryNm = new CategoryName().get(rs.getInt("categoryId"));
				history.setCategoryNm(categoryNm);
				history.setTitle(rs.getString("title"));
				String statusNm = (rs.getString("status").equals("start")) ? "������" : "����";
				history.setStatusNm(statusNm);
				history.setMakerName(rs.getString("makerName"));
				history.setOrderDate(rs.getTimestamp("orderDate"));
				history.setCancel(rs.getInt("cancel"));
				historyList.add(history);
			}
		}catch (Exception e) {
			System.out.println("getMakerProfile error : " + e);
		}finally {
			ResouceClose();
		}
		return historyList;
	}

	//(����������) ���� �ݵ� ���� ���� - ������
	public FundingHistoryBean getHistory(int fundingId) {
		FundingHistoryBean history = new FundingHistoryBean();
		String sql = "select f.fundingId, f.categoryId, f.title, m.name as makerName, f.enddate, a.status from fundinginfo f " + 
					 "join allproject a on f.fundingId = a.fundingId " + 
					 "join maker m on m.userId = a.userId where f.fundingId = ?";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fundingId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				history.setFundingId(rs.getInt("fundingId"));
				String categoryNm = new CategoryName().get(rs.getInt("categoryId"));
				history.setCategoryNm(categoryNm);
				history.setTitle(rs.getString("title"));
				String statusNm = (rs.getString("status").equals("start")) ? "������" : "����";
				history.setStatusNm(statusNm);
				history.setMakerName(rs.getString("makerName"));
				history.setEndDate(rs.getTimestamp("enddate"));
			}
		}catch (Exception e) {
			System.out.println("getHistory error : " + e);
		}finally {
			ResouceClose();
		}
		return history;
	}

	//(����������) ���� �ݵ� ���� ���� - ������
	public PaymentBean getPayment(String orderId) {
		PaymentBean payment = new PaymentBean();
		String sql = "select orderId, totalAmount-deliveryFee as rewardPrice, usedPoint, donation, deliveryFee, " +
					 "finalAmount, orderDate, cancel from fundingorder where orderId = ?"; 

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				payment.setOrderId(rs.getString("orderId"));
				payment.setTotalAmount(rs.getInt("rewardPrice"));
				payment.setUsedPoint(rs.getInt("usedPoint"));
				payment.setDonation(rs.getInt("donation"));
				payment.setDeliveryFee(rs.getInt("deliveryFee"));
				payment.setFinalAmount(rs.getInt("finalAmount"));
				payment.setOrderDate(rs.getTimestamp("orderDate"));
				payment.setCancel(rs.getInt("cancel"));
			}
		}catch (Exception e) {
			System.out.println("getPayment error : " + e);
		}finally {
			ResouceClose();
		}
		return payment;
	}

	//(����������) ���� �ݵ� ���� ���� - ������
	public ReceiverBean getReceiver(String orderId) {
		ReceiverBean receiver = new ReceiverBean();
		String sql = "select name, phone, postCode, address, detailAddress, cardNumber from receiver where orderId = ?;"; 

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				receiver.setName(rs.getString("name"));
				receiver.setPhone(rs.getString("phone"));
				receiver.setPostCode(rs.getString("postCode"));
				receiver.setAddress(rs.getString("address"));
				receiver.setDetailAddress(rs.getString("detailAddress"));
				receiver.setCardNumber(rs.getString("cardNumber"));
			}
		}catch (Exception e) {
			System.out.println("getReceiver error : " + e);
		}finally {
			ResouceClose();
		}
		return receiver;
	}

	//(����������) ���� �ݵ� ���� ���� - ������
	public List<RewardBean> getReward(String orderId) {
		List<RewardBean> rewardList = new ArrayList<RewardBean>();
		RewardBean reward = null;
		String sql = "select r.rewardOption, r.rewardDetail, r.price, d.quantity, r.deliveryDate from reward r " + 
					 "join fundingorderdetails d on r.rewardId = d.rewardId " + 
					 "where d.orderId = ?"; 

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orderId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				reward = new RewardBean();
				reward.setRewardOption(rs.getString("rewardOption"));
				reward.setRewardDetail(rs.getString("rewardDetail"));
				reward.setPrice(rs.getInt("price"));
				reward.setSalesQuantity(rs.getInt("quantity"));
				reward.setDeliveryDate(rs.getString("deliveryDate"));
				rewardList.add(reward);
			}
		}catch (Exception e) {
			System.out.println("getReward error : " + e);
		}finally {
			ResouceClose();
		}
		return rewardList;
	}

	//(����������) ���� �ݵ� ���
	public int setFundingCancel(String orderId) {
		System.out.println("setFundingCancel");
		int fundingId = 0;
		String sql = "update fundingorder set cancel=1, cancelDate=? where orderId=?"; 
	
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			Timestamp currentDate = new Timestamp(System.currentTimeMillis()); 
			pstmt.setTimestamp(1, currentDate);
			pstmt.setString(2, orderId);
			int result = pstmt.executeUpdate();
			
			if(result == 1) {
				sql = "select fundingId from fundingorder where orderId=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, orderId);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					fundingId = rs.getInt("fundingId");
				}
			}
		}catch (Exception e) {
			System.out.println("getReward error : " + e);
		}finally {
			ResouceClose();
		}
		return fundingId;
	}
	
	
}

