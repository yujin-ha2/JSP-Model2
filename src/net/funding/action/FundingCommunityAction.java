package net.funding.action;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.FundingDAO;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.MakerBean;
import net.funding.open.db.RewardBean;
import net.member.db.MemberBean;

public class FundingCommunityAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		 /*
		(�⺻)
		�޼���, ��������� �� �ݵ��ݾ�, ������ �� (��)
		����Ŀ �̸�, ����Ŀ �̸���/������ȭ/Ȩ������ (��)
		����Ŀ���� �ȷο� ���� (��)
		������ ���� �� ajax (��)
		(new)
		(�θ�)��� ��ü ����
		��ۺ� �ۼ���ID, ����, �ۼ���¥ 
		ajax�� �θ��� �亯 ��ư ���ý� �ڽĴ�� ����Ʈ 
		*/
		 request.setCharacterEncoding("UTF-8");
		 
		 FundingDAO dao = new FundingDAO();
		 int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		 
		 FundingInfoBean fundingInfo = dao.getfundingStory(fundingId);
		 MakerBean maker = dao.getMaker(fundingId);
		 List<RewardBean> rewardList = dao.getRewardList(fundingId);
		 AllFundingInfoBean report = dao.getFundingReport(fundingId);	//�ݵ� ���� ����
		
		 Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		 Timestamp endDate = fundingInfo.getEnddate();
		 long calDate = endDate.getTime() - currentDate.getTime(); 
         long calDayDiff = calDate / ( 24*60*60*1000); 
         
         if(request.getSession().getAttribute("id") != null) {
        	 String userId = (String)request.getSession().getAttribute("id");
			 int check = dao.follow(maker.getUserId(), userId); 	   		//����Ŀ�� ������� �ȷο� ����
			 MemberBean member = dao.getMemberTypeInfo(userId);				//���� �α����� ����� ���� ������
			 request.setAttribute("check", check);
			 request.setAttribute("member", member);
		 }
         
         List<CommunityBean> commentList = dao.getComment(fundingId);	//��۸���Ʈ ��������
       
         request.setAttribute("fundingInfo", fundingInfo);
		 request.setAttribute("maker", maker);
		 request.setAttribute("rewardList", rewardList);
		 request.setAttribute("calDayDiff", calDayDiff+1);
		 request.setAttribute("report", report);
		 request.setAttribute("commentList", commentList);
		 
	     ActionForward forward = new ActionForward();
	     forward.setRedirect(false);
	     forward.setPath("funding/fundingCommunity.jsp");
	  
	     return forward;
	}

}
