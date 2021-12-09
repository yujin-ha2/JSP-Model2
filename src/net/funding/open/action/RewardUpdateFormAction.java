package net.funding.open.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.RewardBean;
import net.funding.open.db.FundingOpenDAO;

public class RewardUpdateFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		List<RewardBean> rewardList = new FundingOpenDAO().getRewards(fundingId);
		
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("rewardList", rewardList);
		request.setAttribute("cmd", "update");
			
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectRewardUpdate.jsp"); 
		return forward;
	}

}
