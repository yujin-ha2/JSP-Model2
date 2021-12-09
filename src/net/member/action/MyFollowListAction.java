package net.member.action;

import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingInfoBean;
import net.funding.open.db.MakerBean;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MyFollowListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = (String)request.getSession().getAttribute("id"); 
		String type = request.getParameter("type");

		Vector<MakerBean> makerVector = new MemberDAO().myFollowList(id, type); 
		request.setAttribute("makers", makerVector);
		request.setAttribute("type", type);
	
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("member/myFollowList.jsp");

		return forward;
	}
}
