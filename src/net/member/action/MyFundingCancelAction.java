package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberDAO;

public class MyFundingCancelAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");

		System.out.println("MyFundingCancelAction");
		String orderId = request.getParameter("orderId");
		System.out.println("orderId: " + orderId);
		int fundingId = new MemberDAO().setFundingCancel(orderId);
		System.out.println("fundingId: " + fundingId);
		
		ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("MyFundingHistoryInfo.me?orderId="+orderId+"&fundingId="+fundingId);
	  
	    return forward;
	}

}
