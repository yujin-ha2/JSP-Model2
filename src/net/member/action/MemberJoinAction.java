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
		mb.setId(request.getParameter("id"));		//ȸ�� id
		mb.setPwd(request.getParameter("pwd")); 	//ȸ�� pwd
		mb.setName(request.getParameter("name")); 	//ȸ�� �̸�
		mb.setEmail(request.getParameter("email"));	//ȸ�� �̸��� 
		mb.setPhone(request.getParameter("phone"));	//ȸ�� ��ȭ��ȣ
		
		boolean result = false;
		
		MemberDAO mdao = new MemberDAO();
		result = mdao.insertMember(mb);
	
		if(result == false){
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('ȸ�����Կ� �����Ͽ����ϴ�.');");
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
