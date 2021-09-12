package net.funding.open.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.AllProject;
import net.funding.open.db.MakerBean;
import net.funding.open.db.fundingOpenDAO;

public class makerEasyRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String id = (String)request.getSession().getAttribute("id");
		String name = request.getParameter("makerName");
		String type = request.getParameter("makerType");
		
		MakerBean maker = new MakerBean();
		maker.setUserId(id);
		maker.setName(name);
		maker.setType(type);
		
		fundingOpenDAO openDao = new fundingOpenDAO();
		boolean result = openDao.insertEasyMaker(maker);
	
		if(result == false) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('메이커 등록에 실패하였습니다');");
			out.println("location.href='fundingOpenMain.on';");
			out.println("</script>");
			out.close();
			return null;
		}
		
		ActionForward forward=new ActionForward();
		forward.setRedirect(true);
		forward.setPath("myprojectList.on");
		
		return forward;
	}
}
