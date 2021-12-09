package net.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.FundingHistoryBean;
import net.member.db.MemberDAO;

public class MyFundingHistoryAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String userId = (String)request.getSession().getAttribute("id");
		List<FundingHistoryBean> historyList = new MemberDAO().getHistoryList(userId);
		
		request.setAttribute("historyList", historyList);
		 
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("member/myFundingList.jsp");
	  
	    return forward;
	}

}
