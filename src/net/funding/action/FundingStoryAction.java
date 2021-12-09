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
import net.funding.open.db.FundingOpenDAO;

public class FundingStoryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		String userId = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));

		/*
		ī�װ��̸�, �ݵ��̸�, �ݵ� ����, ��༳��, ���丮����, ��ǥ�ݾ�, �ݵ��Ⱓ (��)
		�޼���, ��������� �� �ݵ��ݾ�, ������ �� (��)
		����Ŀ �̸�, ����Ŀ �̸���/������ȭ/Ȩ������ (��)
		����Ŀ���� �ȷο� ���� (��)
		������ ���� (��)
		*/
		
		FundingDAO dao = new FundingDAO();
		FundingInfoBean fundingInfo = dao.getfundingStory(fundingId);	//�ݵ� ���丮 ����
		MakerBean maker = dao.getMaker(fundingId);						//����Ŀ ����
		List<RewardBean> rewardList = dao.getRewardList(fundingId);		//������ �ɼ�
		int check = dao.follow(maker.getUserId(), userId); 	   			//����Ŀ�� ������� �ȷο� ����
		AllFundingInfoBean report = dao.getFundingReport(fundingId);	//�ݵ� ���� ����
		
		Timestamp currentDate = new Timestamp(System.currentTimeMillis());
		Timestamp endDate = fundingInfo.getEnddate();
		long calDate = endDate.getTime() - currentDate.getTime(); 
        long calDayDiff = calDate / ( 24*60*60*1000); 
        
        request.setAttribute("fundingInfo", fundingInfo);
		request.setAttribute("maker", maker);
		request.setAttribute("rewardList", rewardList);
		request.setAttribute("calDayDiff", calDayDiff+1);
		request.setAttribute("check", check);
		request.setAttribute("report", report);
				 
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("funding/fundingStory.jsp");
	  
	    return forward;
	    
	}

}
