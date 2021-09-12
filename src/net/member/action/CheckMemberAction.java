package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberBean;
import net.member.db.MemberDAO;

public class CheckMemberAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ActionForward forward = new ActionForward();
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String id =(String)request.getParameter("id");
		String email=(String)request.getParameter("email");
		
		MemberBean mb = new MemberBean();
		mb.setId(id);
		mb.setEmail(email);
		
		int result = new MemberDAO().checkMember(mb);
		
		if(result == 2){ //�����ϴ� �����
			request.setAttribute("id", id);
			forward.setRedirect(false);
			forward.setPath("member/passwordUpdate.jsp");
			return forward;
			
		}else if(result == 1){
		    PrintWriter out = response.getWriter(); 
		    String str="";
		    str = "<script language='javascript'>";
		    str += "alert('�̸����� ��ġ���� �ʽ��ϴ�.');";  
		    str += "history.back();";
		    str += "</script>";
		    out.print(str);
		    return null;
		    
		}else{
			PrintWriter out = response.getWriter(); 
		    String str="";
		    str = "<script language='javascript'>";
		    str += "alert('��ġ�ϴ� ������ �����ϴ�.');";  
		    str += "history.back();";
		    str += "</script>";
		    out.print(str);
		    return null;
		}
	}
}
