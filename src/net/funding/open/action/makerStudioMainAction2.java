package net.funding.open.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.fundingOpenDAO;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class makerStudioMainAction2 implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType("text/html; charset=UTF-8");
		
		String id = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("no"));
		
		if(id == null) {
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('먼저 로그인을 해주세요.');");
			out.println("location.href='MemberLogin.me';");
			out.println("</script>");
			out.close();
			return null;
		}
		
		//내 펀딩 리스트 내역을 가져와야 함
		//request.setAttribute("list", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("fundingOpen/myfundingList.jsp");
		
		return forward;
	}

}
