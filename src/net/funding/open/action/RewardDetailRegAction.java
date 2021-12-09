package net.funding.open.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.rewardInfoBean;

public class RewardDetailRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		int categoryId = Integer.parseInt(request.getParameter("category"));
		System.out.println("categoryId : " + categoryId);
		
		List<rewardInfoBean> list = new ArrayList<rewardInfoBean>();
		rewardInfoBean bean = null;
		int index = categoryId;
		System.out.println("categoryId: " + categoryId);
		
		while(request.getParameter("answer"+index) != null) {
			bean = new rewardInfoBean();
			bean.setCategoryId(categoryId);
			bean.setDetailId(index);
			bean.setDetailContent(request.getParameter("answer"+index));
			list.add(bean);
			index += 5;
			System.out.println("다음 카테고리아이디 : " + index);
		}
		String policy = request.getParameter("policy");
		System.out.println("policy: " + policy);
		
		System.out.println("list size: " + list.size()); 
		
		//확인
		for(rewardInfoBean b : list)
			System.out.println(b.getDetailId() + " : " + b.getDetailContent());

		int result = 0; 
		int policyResult = 0;
		String Message = "";
		String cmd = request.getParameter("cmd");
		System.out.println("cmd: " + cmd);
		if(cmd.equals("register")) {
			System.out.println("register 시작");
			FundingOpenDAO dao = new FundingOpenDAO();
			result = dao.insertRewardDetail(fundingId, list, cmd);
			policyResult = dao.insertRewardPolicy(fundingId, policy);
			Message = "등록";
			
		}else if(cmd.equals("update")){
			System.out.println("update 시작");
			FundingOpenDAO dao = new FundingOpenDAO();
			result = dao.insertRewardDetail(fundingId, list, cmd);
			policyResult = dao.updateRewardPolicy(fundingId, policy);
			Message = "수정";
		}
		
		if(result == 0 || policyResult == 0) {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			out.println("<script>");
			out.println("alert('기본 요건 "+Message+"에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			return null;
		}
		
		List<rewardInfoBean> rewardList = new FundingOpenDAO().getRewardsInfoList(fundingId);
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("rewardList", rewardList);
		request.setAttribute("policy", policy);
		request.setAttribute("mode", "update");

		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectRewardDetailView.jsp");		
	
		return forward;
	}

}
