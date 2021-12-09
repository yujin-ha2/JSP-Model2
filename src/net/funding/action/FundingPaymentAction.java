package net.funding.action;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.FundingDAO;
import net.funding.db.PaymentBean;
import net.funding.db.ReceiverBean;
import net.funding.open.db.FundingInfoBean;
import net.member.db.MemberBean;

public class FundingPaymentAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("UTF-8");
		
		//fundingId, rewardId X rewardNumber, 추가후원금, 배송비, 사용포인트, 최종결제금액
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		String[] ids = request.getParameterValues("rewardId");
		String[] numbers = request.getParameterValues("rewardNumber");
		
		int[] rewardIds = Arrays.stream(ids).mapToInt(Integer::parseInt).toArray();
		int[] rewardNumbers = Arrays.stream(numbers).mapToInt(Integer::parseInt).toArray();
		
		PaymentBean payment = new PaymentBean();
		payment.setFundingId(Integer.parseInt(request.getParameter("fundingId")));
		String userId = request.getParameter("userId");
		payment.setUserId(userId);
		String donation = (!request.getParameter("donation").equals("")) ? request.getParameter("donation") : "0";
		payment.setDonation(Integer.parseInt(donation));
		payment.setDeliveryFee(Integer.parseInt(request.getParameter("deliveryFee")));
		String point = (!request.getParameter("point").equals("")) ? request.getParameter("point") : "0";
		payment.setUsedPoint(Integer.parseInt(point));
		payment.setTotalAmount(Integer.parseInt(request.getParameter("originalPayment")));
		payment.setFinalAmount(Integer.parseInt(request.getParameter("finalPayment")));
		
		
		ReceiverBean receiver = new ReceiverBean();
		receiver.setName(request.getParameter("receiverName"));
		receiver.setPhone(request.getParameter("receiverPhone"));
		receiver.setPostCode(request.getParameter("postcode"));
		receiver.setAddress(request.getParameter("address"));
		receiver.setDetailAddress(request.getParameter("detailAddress"));
		if(request.getParameter("deliveryRequest") != null)
			receiver.setRequest(request.getParameter("deliveryRequest"));
		String[] cardNumber = request.getParameterValues("card_number");
		String card = cardNumber[0] + cardNumber[1] + cardNumber[2] + cardNumber[3]; 
		receiver.setCardNumber(card);
		receiver.setExpirationDate(request.getParameter("card_validity"));
		receiver.setPassword(request.getParameter("card_password"));
		receiver.setBirth(request.getParameter("birthday"));
		
		String orderId = "";
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		orderId = sdf.format(now);
		orderId += fundingId;
		orderId += userId.charAt((int)(Math.random()*userId.length()-1));
		orderId += (char)((int)(Math.random()*26)+97);
		System.out.println("orderId: " + userId);
				
		FundingDAO dao = new FundingDAO();
		//결제 정보 등록
		int receiverId = dao.setReceiver(orderId, receiver);
		dao.setPayment(orderId, receiverId, payment, rewardIds, rewardNumbers);
		
		//판매한 옵션 개수  & 판매 금액 등록
		dao.checkOrderdOption(fundingId, rewardIds, rewardNumbers);
		dao.addRevenue(fundingId, payment.getTotalAmount());
		
		//사용한 포인트 금액만큼 포인트 차감
		int remainingPoints = Integer.parseInt(point) - Integer.parseInt(request.getParameter("myPoint"));
		dao.usePoint(userId, remainingPoints);
		
		//사용자 이름, 펀딩제목, 리워드배송일, 펀딩 진행 마지막날+1day
		MemberBean member = dao.getMember(userId);
		FundingInfoBean funding = dao.getPaymentApproveInfo(fundingId);
		
		Timestamp endDate = funding.getEnddate();
        Date nextDate = new Date(endDate.getTime()+(1000*60*60*24*+1));
        
		request.setAttribute("userName", member.getName());
		request.setAttribute("funding", funding);
		request.setAttribute("nextDate", nextDate);
		 
	    ActionForward forward = new ActionForward();
	    forward.setRedirect(false);
	    forward.setPath("funding/paymentCompletion.jsp");
	  
	    return forward;
	}

}
