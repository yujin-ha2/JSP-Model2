package net.funding.open.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.fundingOpenDAO;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class makerEasyRegFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		
		String id = (String)request.getSession().getAttribute("id");
		
		if(id == null) {
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('먼저 로그인을 해주세요.');");
			out.println("location.href='MemberLogin.me';");
			out.println("</script>");
			out.close();
			return null;
		
		}
		
		boolean result = new fundingOpenDAO().confirmUserStatus(id);
		if(result == true) {
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('이미 메이커 계정으로 전환되었습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}else {
			MemberBean member = new MemberDAO().InfoMember(id);
			request.setAttribute("member", member);

			ActionForward forward = new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/makerEasyRegForm.jsp");
			return forward;
		}
	}
	
}
