package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.RequirementsBean;

public class BasicRequireUpdateFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		RequirementsBean require = new RequirementsBean();

		String Q1_radio = request.getParameter("Q1_radio");
		require.setQ1(Q1_radio);
		String differ = "";
		if(Q1_radio.equals("yes")) 
			differ = request.getParameter("q1_differ");
		require.setDiffer(differ);
		require.setReward(request.getParameter("reward"));
		require.setDelivery(request.getParameter("delivery"));
		require.setQ4(request.getParameter("Q4_radio"));
		String fundingId = request.getParameter("fundingId");
		require.setFundingId(Integer.parseInt(fundingId));
		
		request.setAttribute("bean", require);
		
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicRequireUpdate.jsp"); 
		return forward;
	}

}
