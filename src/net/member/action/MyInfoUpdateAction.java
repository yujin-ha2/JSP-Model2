package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MyInfoUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String id = request.getParameter("myId");
		String phone = request.getParameter("myPhone");
		String email = request.getParameter("myEmail");
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		mb.setPhone(phone);
		mb.setEmail(email);
		
		int result = new MemberDAO().updateMember(mb);
		if(result == 0){
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('정보 변경에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("myInfo.me");
		
		return forward;
	}

}
