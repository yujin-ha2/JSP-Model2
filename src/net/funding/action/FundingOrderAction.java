package net.funding.action;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.FundingDAO;
import net.funding.db.FundingOrderBean;
import net.member.db.MemberBean;

public class FundingOrderAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		
		String userId = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		String[] ids = request.getParameterValues("rewardId");
		String[] numbers = request.getParameterValues("productNumber");
		String rewardIdList = "";
		
		int[] rewardIds = Arrays.stream(ids).mapToInt(Integer::parseInt).toArray();
		int[] rewardNumbers = Arrays.stream(numbers).mapToInt(Integer::parseInt).toArray();
		Map<Integer, Integer> rewardMap = new HashMap<Integer, Integer>();
		for(int i=0; i<rewardIds.length; i++) {
			rewardMap.put(rewardIds[i], rewardNumbers[i]);
			if(i == (rewardIds.length-1))
				rewardIdList += rewardIds[i];
			else
				rewardIdList += (rewardIds[i] + ", ");
		}
		//System.out.println("rewardIdList: " + rewardIdList);
		
		FundingDAO dao = new FundingDAO();
		MemberBean member = dao.getMember(userId);
		List<FundingOrderBean> orderList = dao.getOrder(fundingId, rewardIdList, rewardMap);
		
		int totalPrice = 0;
		int deliveryFee = orderList.get(0).getDeliveryFee();
		
		for(FundingOrderBean order : orderList) {
			totalPrice += order.getRewardPrice();
			if(order.getDeliveryFee() == 0)
				deliveryFee = 0;
		}
		
		request.setAttribute("member", member);
		request.setAttribute("orderList", orderList);
		request.setAttribute("deliveryFee", deliveryFee);
		request.setAttribute("totalPrice", totalPrice);
		 
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("funding/payment.jsp");
	  
	    return forward;
	}
}
