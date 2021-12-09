package net.funding.open.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.rewardInfoBean;

public class RewardDetailUpdateFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		System.out.println("updateformaction");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		List<rewardInfoBean> rewardList = new FundingOpenDAO().getRewardsInfoList(fundingId);
		String policy = request.getParameter("policy");
		
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("rewardList", rewardList);
		request.setAttribute("policy", policy);
		request.setAttribute("cmd", "update");
		
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectRewardDetailUpdate.jsp"); 
		return forward;
	}

}
