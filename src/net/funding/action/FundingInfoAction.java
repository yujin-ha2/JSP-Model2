package net.funding.action;

import java.sql.Date;
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
import net.funding.open.db.rewardDetailBean;

public class FundingInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 /*
		 (�⺻)
		 �޼���, ��������� �� �ݵ��ݾ�, ������ �� (��)
		 ����Ŀ �̸�, ����Ŀ �̸���/������ȭ/Ȩ������ (��)
		 ����Ŀ���� �ȷο� ���� (��)
		 ������ ���� �� ajax (��)
		 (new)
		 �ݵ� ������ ��¥ (��)
		 ī�װ� �̸�, ������ �������� ����, ���� ����, ��å (��)
		*/
		
		 request.setCharacterEncoding("UTF-8");
		
		 String userId = (String)request.getSession().getAttribute("id");
		 int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		 
		 FundingDAO dao = new FundingDAO();
 		 FundingInfoBean fundingInfo = dao.getfundingStory(fundingId);
		 MakerBean maker = dao.getMaker(fundingId);
		 List<RewardBean> rewardList = dao.getRewardList(fundingId);
		 List<rewardDetailBean> rewardDetailList = dao.getRewardDetailList(fundingId); 
		 int check = dao.follow(maker.getUserId(), userId); 	   						//����Ŀ�� ������� �ȷο� ����
		 AllFundingInfoBean report = dao.getFundingReport(fundingId);					//�ݵ� ���� ����
		
		 Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		 Timestamp endDate = fundingInfo.getEnddate();
		 long calDate = endDate.getTime() - currentDate.getTime(); 
         long calDayDiff = calDate / ( 24*60*60*1000); 
         
         Date nextDate = new Date(endDate.getTime()+(1000*60*60*24*+1));
        
         request.setAttribute("fundingInfo", fundingInfo);
 		 request.setAttribute("maker", maker);
		 request.setAttribute("rewardList", rewardList);
 		 request.setAttribute("calDayDiff", calDayDiff+1);
 		 request.setAttribute("nextDate", nextDate);
 		 request.setAttribute("rewardDetailList", rewardDetailList);
		 request.setAttribute("check", check);
		 request.setAttribute("report", report);
		 
	     ActionForward forward = new ActionForward();
	     forward.setRedirect(false);
	     forward.setPath("funding/fundingInfo.jsp");
	  
	     return forward;
	}
}
