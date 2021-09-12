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

public class myFollowListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = (String)request.getSession().getAttribute("id"); 

		Vector<MakerBean> v = new MemberDAO().myFollowList(id); 
		
		request.setAttribute("v", v);
	
		ActionForward forward=new ActionForward();
		forward.setRedirect(false);
		forward.setPath("member/myFollowList.jsp");

		return forward;
	}
}
