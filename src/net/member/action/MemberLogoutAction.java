package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;

public class MemberLogoutAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//세션값 초기화
		HttpSession session=request.getSession();
		session.invalidate();
		
		ActionForward forward=new ActionForward();	
		forward.setRedirect(true);
		forward.setPath("main.do"); 
		return forward;	
	}

}
