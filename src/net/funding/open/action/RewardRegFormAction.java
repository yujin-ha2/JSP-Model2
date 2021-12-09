package net.funding.open.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.RewardBean;
import net.funding.open.db.FundingOpenDAO;

public class RewardRegFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		System.out.println("리워드 설계 : " + fundingId);
		
		String path = "";
		
		AllProject project = new FundingOpenDAO().getStatus(fundingId, "reward");
		String status = project.getStatus();
		int isReg = project.getIsReg();
		
		if(isReg == 0) {
			path = "fundingOpen/projectRewardReg.jsp";
			
		}else if(status.equals("prepare") || status.equals("reject")){
			path = "fundingOpen/projectRewardView.jsp";
			List<RewardBean> rewardList = new FundingOpenDAO().getRewards(fundingId);
			request.setAttribute("rewardList", rewardList);	
			request.setAttribute("mode", "update");
			
		}else {
			path = "fundingOpen/projectRewardView.jsp";
			List<RewardBean> rewardList = new FundingOpenDAO().getRewards(fundingId);
			request.setAttribute("rewardList", rewardList);
			request.setAttribute("mode", "view");
		}
		
		request.setAttribute("fundingId", fundingId);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		return forward;
	}

}
