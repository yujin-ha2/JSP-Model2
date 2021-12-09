package net.funding.open.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.rewardInfoBean;

public class RewardDetailRegFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		
		String path = "";
		
		AllProject project = new FundingOpenDAO().getStatus(fundingId, "rewarddetail");
		String status = project.getStatus();
		int isReg = project.getIsReg();
		
		if(status.equals("prepare") && isReg == 0) {
			path = "fundingOpen/projectRewardDetailReg.jsp";
			
		}else if(status.equals("prepare") || status.equals("reject")) {
			path = "fundingOpen/projectRewardDetailView.jsp";
			FundingOpenDAO dao = new FundingOpenDAO();
			List<rewardInfoBean> rewardList = dao.getRewardsInfoList(fundingId);
			
		/*	for(rewardInfoBean bean : rewardList) {
				System.out.println("categoryId: "+bean.getCategoryId());
				System.out.println("detailId: "+bean.getDetailId());
				System.out.println("detailName: "+bean.getDetailName());
				System.out.println("example: "+bean.getExample());
				System.out.println("content: "+bean.getDetailContent());
			}
		*/
			String policy = dao.getRewardPolicy(fundingId);
			request.setAttribute("rewardList", rewardList);
			request.setAttribute("policy", policy);
			request.setAttribute("mode", "update");
			
		}else {
			path = "fundingOpen/projectRewardDetailView.jsp";
			FundingOpenDAO dao = new FundingOpenDAO();
			List<rewardInfoBean> rewardList = dao.getRewardsInfoList(fundingId);
			String policy = dao.getRewardPolicy(fundingId);
			request.setAttribute("rewardList", rewardList);
			request.setAttribute("policy", policy);
			request.setAttribute("mode", "view");
		}
		
		request.setAttribute("fundingId", fundingId);
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		return forward;
	}

}
