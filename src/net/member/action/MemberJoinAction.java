package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class MemberJoinAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		MemberBean mb=new MemberBean();
		mb.setId(request.getParameter("id"));		//회원 id
		mb.setPwd(request.getParameter("pwd")); 	//회원 pwd
		mb.setName(request.getParameter("name")); 	//회원 이름
		mb.setEmail(request.getParameter("email"));	//회원 이메일 
		mb.setPhone(request.getParameter("phone"));	//회원 전화번호
		
		boolean result = false;
		
		MemberDAO mdao = new MemberDAO();
		result = mdao.insertMember(mb);
	
		if(result == false){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('회원가입에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(true);
		forward.setPath("./MemberLogin.me");
		
		return forward;
	}

}
