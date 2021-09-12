package net.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MyInfoUpdateFormAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
	    //세션에 저장된 id 가져오기
		String id = (String)request.getSession().getAttribute("id");
	      
	    MemberBean mb = new MemberDAO().InfoMember(id); 
	    request.setAttribute("mb", mb);
	       
	    ActionForward forward = new ActionForward(); 
	    forward.setRedirect(false);
	    forward.setPath("member/myInfoUpdateForm.jsp");
	    return forward;
	}
}
