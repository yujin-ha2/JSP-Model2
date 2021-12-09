package net.funding.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.FundingDAO;

public class FundingListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String keyword = "";
		if(request.getParameter("keyword") != null) 
			keyword = request.getParameter("keyword");
		
		List<AllFundingInfoBean> fundingList = new FundingDAO().getAllFundinglist(0, keyword, "YN", "recent");
		
		request.setAttribute("fundingList", fundingList);
		
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(false);
		forward.setPath("funding/funding.jsp");
		
		return forward;	
	}

}
