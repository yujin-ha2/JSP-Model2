package net.funding.open.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.open.db.RewardBean;
import net.funding.open.db.FundingOpenDAO;

public class RewardRegAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));

		List<RewardBean> rewardList = new ArrayList<RewardBean>();
		RewardBean bean = null;
		
		String[] arrayParam = request.getParameterValues("option");
		System.out.println("option 개수 : " + arrayParam.length);
		for (int i = 0; i < arrayParam.length; i++) {
			bean = new RewardBean();
			bean.setRewardOption(request.getParameterValues("option")[i]);
			System.out.println("시작!!"+request.getParameterValues("optionDetail")[i]);
			bean.setRewardDetail(request.getParameterValues("optionDetail")[i]);
			String price = request.getParameterValues("price")[i];
			price = price.replace(",", "");
			bean.setPrice(Integer.parseInt(price));
			String quantity = request.getParameterValues("quantity")[i];
			quantity = quantity.replace(",", "");
			bean.setSalesQuantity(Integer.parseInt(quantity));
			bean.setDeliveryDate(request.getParameterValues("deliveryDate")[i]);
			String fee = request.getParameterValues("deliveryFee")[i];
			fee = fee.replace(",", "");
			bean.setDeliveryFee(Integer.parseInt(fee));
			
			rewardList.add(bean);
		}

		for (RewardBean b : rewardList) {
			System.out.println("option: " + b.getRewardOption() + "optionDetail: " + b.getRewardDetail() + ", price: " + b.getPrice() + ", quantity: " + b.getSalesQuantity() + ", date: " + b.getDeliveryDate() + ", fee: " + b.getDeliveryFee());
		}
			
		String cmd = request.getParameter("cmd");
		int result = new FundingOpenDAO().insertReward(fundingId, rewardList, cmd);
		String Message = (cmd.equals("register")) ? "등록" : "수정";
		
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
		
		request.setAttribute("mode", "update");	
		request.setAttribute("fundingId", fundingId);
		request.setAttribute("rewardList", rewardList);	

		ActionForward forward = new ActionForward();	
		forward.setRedirect(false);
		forward.setPath("fundingOpen/projectRewardView.jsp");		
	
		return forward;
	}
}
