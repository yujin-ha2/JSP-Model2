package net.funding.open.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.FundingDAO;
import net.funding.open.db.RequirementsBean;
import net.funding.open.db.FundingOpenDAO;

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
		int result = 0; 
		String Message = "";
		
		if(cmd.equals("register")) {
			result = new FundingOpenDAO().insertRequirement(require);
			Message = "등록";
		}else if(cmd.equals("update")){
			result = new FundingOpenDAO().updateRequirment(require);
			Message = "수정";
		}
		
		if(result == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('기본 요건 "+Message+"에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		request.setAttribute("bean", require);
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("mode", "update");
		
		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectBasicRequireView.jsp"); 

		return forward;
	}

}
