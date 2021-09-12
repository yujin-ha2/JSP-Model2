package net.funding.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.fundingDAO;
import net.funding.db.fundingOrderBean;

public class FundingDetailSupportAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward(); 
		
		HttpSession session=request.getSession();
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		
		fundingDAO dao = new fundingDAO(); 
		int count = dao.fundingDetailSupportCount(fundingId);
		Vector<fundingOrderBean> v = dao.fundingDetailSupportList(fundingId); 
		 
		 request.setAttribute("count", count); 
		 request.setAttribute("v", v); 
		 request.setAttribute("fundingId", fundingId); 
		
		 forward.setRedirect(false);
		 forward.setPath("funding/fundingDetail4_support.jsp");
		
		return forward;	
	}

}
