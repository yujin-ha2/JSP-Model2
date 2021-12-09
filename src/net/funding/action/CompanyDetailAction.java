package net.funding.action;

import java.util.Vector;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.FundingDAO;
import net.funding.open.db.MakerBean;

public class CompanyDetailAction extends HttpServlet implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		String userId = (String)request.getSession().getAttribute("id");
		String makerId = request.getParameter("makerId");
		
		FundingDAO dao = new FundingDAO();
		Vector<AllFundingInfoBean> fundings = dao.getInformation(makerId); 	//����Ŀ�� ������ ��� �ݵ� ����
		MakerBean maker = dao.getMaker(makerId);							//����Ŀ ����
		int check = dao.follow(makerId, userId); 	   						//����Ŀ�� ������� �ȷο� ����
		int followCount = dao.countFollow(makerId);	   						//����Ŀ�� �ȷο� ��
		
		request.setAttribute("fundings", fundings);
		request.setAttribute("maker", maker);
		request.setAttribute("check", check);
		request.setAttribute("followCount", followCount);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("funding/companyDetail.jsp");	

		return forward;
	}
}
