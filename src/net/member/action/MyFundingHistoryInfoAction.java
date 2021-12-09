package net.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.PaymentBean;
import net.funding.db.ReceiverBean;
import net.funding.open.db.RewardBean;
import net.member.db.FundingHistoryBean;
import net.member.db.MemberDAO;

public class MyFundingHistoryInfoAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		String orderId = request.getParameter("orderId");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		
		MemberDAO dao = new MemberDAO();
		FundingHistoryBean history = dao.getHistory(fundingId);
		PaymentBean payment = dao.getPayment(orderId);
		ReceiverBean receiver = dao.getReceiver(orderId);
		List<RewardBean> rewardList = dao.getReward(orderId);
		
		request.setAttribute("history", history);
		request.setAttribute("payment", payment);
		request.setAttribute("receiver", receiver);
		request.setAttribute("rewardList", rewardList);

		ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("member/myFundingDetail.jsp");
	  
	    return forward;
	}

}
