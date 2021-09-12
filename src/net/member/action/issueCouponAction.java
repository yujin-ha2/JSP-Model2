package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class issueCouponAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String id = (String)request.getSession().getAttribute("id");
		
		int result = new MemberDAO().issueCoupon(id);
	   
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('쿠폰 발급에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
	    ActionForward forward = new ActionForward(); 
	    forward.setRedirect(false);
	    forward.setPath("index.jsp");  //쿠폰 발급 페이지로 추후 변경
	    return forward;
	}

}
