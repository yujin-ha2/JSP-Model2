package net.funding.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.fundingDAO;

public class FundingListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward(); 
		
		String id = (String)request.getSession().getAttribute("id");
		String companyName = request.getParameter("companyName");
		int category = Integer.parseInt(request.getParameter("category"));
		int statusVal = Integer.parseInt(request.getParameter("statusVal"));
		int sortVal = Integer.parseInt(request.getParameter("sortVal"));
		//String text = request.getParameter(request.getParameter("input"));
		
		fundingDAO dao = new fundingDAO(); 
		 Vector<AllFundingInfoBean> v = dao.getAllFundinglist(category, statusVal, sortVal);
		 
		 request.setAttribute("v", v); //"v"는 변수 명 v는 FundingBean에서 리턴한 Vector가 담긴 v
		 
		 
		 forward.setRedirect(false);
		 forward.setPath("funding/funding.jsp");
		
		return forward;	
	}

}
