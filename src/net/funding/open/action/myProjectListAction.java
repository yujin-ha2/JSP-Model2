package net.funding.open.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.action.StatusName;
import net.funding.open.db.AllProject;
import net.funding.open.db.fundingOpenDAO;
import net.funding.open.db.myProjectBean;

public class myProjectListAction implements Action {

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
		
		//확인하기
		List<myProjectBean> list = new ArrayList<myProjectBean>();
		list = new fundingOpenDAO().getProjectList(id);
		
		for(int i=0; i<list.size(); i++) {
			String name = list.get(i).getStatus();
			list.get(i).setStatus(StatusName.get(name));
		}
		
		request.setAttribute("projectList", list);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("fundingOpen/myprojectList.jsp");
		
		return forward;
	}

}
