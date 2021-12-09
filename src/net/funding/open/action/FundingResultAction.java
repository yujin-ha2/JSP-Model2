package net.funding.open.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.action.StatusName;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.FundingReport;
import net.funding.open.db.FundingResult;

public class FundingResultAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));

		FundingOpenDAO dao = new FundingOpenDAO();
		AllProject project = dao.getStatus(fundingId, "");
		String fundingStatus = project.getStatus();
		if(!fundingStatus.equals("success") && !fundingStatus.equals("fail")) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('�ݵ��� ����Ǿ�� ��밡���մϴ�.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		FundingReport report = dao.getFundingReportInfo(fundingId);		//�ݵ� ��Ȳ �⺻ ����
		int orderCount = dao.getOrderCount(fundingId);					//�ֹ� ����
		int cancelCount = dao.getCancelCount(fundingId);				//�ֹ� ��� ����
		FundingResult result = dao.getFundingResult(fundingId);			//�ݵ� ���� ����
		
		request.setAttribute("report", report);
		request.setAttribute("fundingStatus", StatusName.get(fundingStatus));
		request.setAttribute("orderCount", orderCount);
		request.setAttribute("cancelCount", cancelCount);
		request.setAttribute("result", result);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("fundingOpen/fundingpayment.jsp");
		return forward;
	}

}
