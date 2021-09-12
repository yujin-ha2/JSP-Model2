package net.funding.open.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.MakerBean;

public class MakerInfoUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String id = (String)request.getSession().getAttribute("id");
		
		MakerBean bean = new MakerBean();
		
		bean.setName(request.getParameter("name"));
		bean.setType(request.getParameter("type"));
		bean.setCeoName(request.getParameter("ceoName"));
		bean.setCeoEmail(request.getParameter("ceoEmail"));
		bean.setProfile(request.getParameter("profile"));
		bean.setMakerEmail(request.getParameter("makerEmail"));
		bean.setMakerTel(request.getParameter("makerTel"));
		bean.setMakerHomepage(request.getParameter("makerHomepage"));
		bean.setBankName(request.getParameter("bankName"));
		bean.setAccountNumber(request.getParameter("accountNumber"));
		bean.setAccountHolder(request.getParameter("accountHolder"));
		bean.setUserId(id);
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		
		request.setAttribute("bean", bean);
		request.setAttribute("cmd", "update");
		request.setAttribute("fundingId", fundingId);
			
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectMakerDetailUpdate.jsp"); 
		return forward;
	}

}
