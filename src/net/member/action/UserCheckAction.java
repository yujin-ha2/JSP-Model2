package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class UserCheckAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String userId = request.getParameter("userId");
		String email= request.getParameter("email");
		String type = request.getParameter("type");
		
		MemberBean mb = new MemberBean();
		mb.setId(userId);
		mb.setEmail(email);

		int result = new MemberDAO().checkMember(mb);
		
		if(result != 2){ 
			String message = (result == 0) ? "일치하는 정보가 없습니다." : "이메일 정보가 다릅니다.";
			PrintWriter out = response.getWriter(); 
		    String str="";
		    str = "<script language='javascript'>";
		    str += "alert('"+ message +"');";  
		    str += "history.back();";
		    str += "</script>";
		    out.print(str);
		    return null;
		}
		
		String path = (type.equals("findPwd")) ? "member/find_id_pwd_form3.jsp" : "myInfoFindPwd.me"; 

		request.setAttribute("userId", userId);

		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath(path);
		
		return forward;
	}
}
