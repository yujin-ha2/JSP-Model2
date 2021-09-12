package net.funding.open.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.fundingDAO;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.fundingOpenDAO;

public class BasicRequireRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		RequirementsBean require = new RequirementsBean();
		String Q1_radio = request.getParameter("Q1_radio");
		require.setQ1(Q1_radio);
		String differ = "";
		if(Q1_radio.equals("yes")) 
			differ = request.getParameter("q1_differ");
		require.setDiffer(differ);
		require.setReward(request.getParameter("reward"));
		require.setDelivery(request.getParameter("delivery"));
		require.setQ4(request.getParameter("Q4_radio"));
		String fundingId = request.getParameter("fundingId");
		require.setFundingId(Integer.parseInt(fundingId));
		
		String cmd = request.getParameter("cmd");
		System.out.println("cmd: " + cmd);
		if(cmd.equals("register")) {
			
			int result = new fundingOpenDAO().insertRequirement(require);
			if(result == 0) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('기본 요건 등록에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return null;
			}
			
			request.setAttribute("bean", require);
			request.setAttribute("mode", "update");
			
		}else if(cmd.equals("update")){
			System.out.println();
			int result = new fundingOpenDAO().updateRequirment(require);
			if(result == 0) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('기본 요건 수정에 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
				out.close();
				return null;
			}
			
			request.setAttribute("bean", require);
			request.setAttribute("mode", "view");
		}

		
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicRequireView.jsp"); 

		return forward;
	}

}
