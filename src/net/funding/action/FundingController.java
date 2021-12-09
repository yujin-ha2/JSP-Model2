package net.funding.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import net.action.Action;
import net.action.ActionForward;
import net.funding.db.AllFundingInfoBean;
import net.funding.db.FundingDAO;
import net.funding.open.db.RewardBean;

public class FundingController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String RequestURI=request.getRequestURI();
		
		String contextPath=request.getContextPath();
		//System.out.println("contextPath:" + contextPath.length());
		System.out.println("me_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("me_command:" + command);
		
		ActionForward forward = null;
		Action action = null;

		//메인페이지
		if(command.equals("/main.do")) {	
			action = new MainAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//공지사항 페이지로 이동 
		else if(command.equals("/noticeList.do")) {	
			action = new NoticeListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//공지사항 페이지로 이동 
		else if(command.equals("/notice.do")) {	
			action = new NoticeAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//[펀딩하기] 페이지로 이동 - 정수연
		else if(command.equals("/fundingList.do")) {	
			action = new FundingListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		} 
		
		//
		else if(command.equals("/fundingSearch.do")) {
			request.setCharacterEncoding("utf-8");
						
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");

				//category:category, keyword:'', endYn:'N', order:'recent'
			     int category = data.get("category").getAsInt(); 		//카테고리
			     String keyword = data.get("keyword").getAsString();	//검색어
			     String endYn = data.get("endYn").getAsString();		//진행중or종료된
			     String order = data.get("order").getAsString();		//최신순or펀딩액순or마감임박순
			     
				 List<AllFundingInfoBean> fundingList = new FundingDAO().getAllFundinglist(category, keyword, endYn, order);
				 new Gson().toJson(fundingList, response.getWriter());
				 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메이커 페이지로 이동 - 정수연
		else if(command.equals("/CompanyDetail.do")){
			action= new CompanyDetailAction();
	       
	        try {
	    	   forward = action.execute(request, response);
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
		}
		
		//(메이커 페이지) 팔로우 & 팔로우취소  Ajax - 정수연
		else if(command.equals("/FollowAction.do")) {
			
			 JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
			 
		     String userId = data.get("userId").getAsString();						//팔로우하는 회원(팔로워)
		     String makerId = data.get("makerId").getAsString(); 		 			//팔로우당하는 회사(팔로우)
		     //int followbtn = Integer.parseInt(request.getParameter("followbtn"));	//0 : 팔로우하기, 1 : 팔로우취소
			 int followStatus = data.get("followStatus").getAsInt();
		     System.out.println("userId: " + userId + ", makerId: " + makerId + ", followStatus: " + followStatus);
			 
		     //int followCount = new FundingDAO().followCompany(id, makerId, followbtn);
			 int followCount = new FundingDAO().followCompany(userId, makerId, followStatus);
			 
			 new Gson().toJson(followCount, response.getWriter());
		}
		
		//펀딩 스토리 페이지로 이동 - 정지운, 하유진
		else if(command.equals("/fundingStory.do")) {
			action=new FundingStoryAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//펀딩페이지 - 선택한 리워드 옵션의 정보 전달 (ajax) 하유진
		else if(command.equals("/getRewardInfo.do")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			     
			    int rewardId = data.get("rewardId").getAsInt(); 
				RewardBean bean = new FundingDAO().getRewards(rewardId);
				System.out.println("rewardId: " + rewardId);
				
				new Gson().toJson(bean, response.getWriter());
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//펀딩페이지, 반환.정책 페이지로 이동 - 정지운, 하유진
		else if(command.equals("/fundingRewardInfo.do")) {	
			action = new FundingInfoAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//펀딩페이지, 커뮤니티 페이지로 이동 - 하유진
		else if(command.equals("/fundingCommunity.do")) {	
			action = new FundingCommunityAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//커뮤니티 페이지 - 댓글 등록 (ajax) 하유진
		else if(command.equals("/insertComment.do")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			    
				CommunityBean bean = new CommunityBean();
				int fundingId = data.get("fundingId").getAsInt(); 
				bean.setWriterId(data.get("writerId").getAsString());  
				bean.setParentId(data.get("parentId").getAsInt()); 
				bean.setContent(data.get("content").getAsString()); 
				int result = new FundingDAO().insertComment(fundingId, bean);
				
				new Gson().toJson(result, response.getWriter());
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//커뮤니티 페이지 - 댓글,대댓글 등록 (ajax) 하유진
		else if(command.equals("/updateComment.do")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			    
				int replyId = data.get("replyId").getAsInt(); 
				String content = data.get("content").getAsString(); 
				int result = new FundingDAO().updateComment(replyId, content);
				
				new Gson().toJson(result, response.getWriter());
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//커뮤니티 페이지 - 댓글,대댓글 삭제 (ajax) 하유진
		else if(command.equals("/deleteComment.do")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			    
				int replyId = data.get("replyId").getAsInt(); 
				int result = new FundingDAO().deleteComment(replyId);
				
				new Gson().toJson(result, response.getWriter());
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//커뮤니티 페이지 - 대댓글 리스트 (ajax) 하유진
		else if(command.equals("/showReplies.do")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			    
				int parentId = data.get("parentId").getAsInt(); 
				System.out.println("parentId: " + parentId);
				List<CommunityBean> replies = new FundingDAO().replyList(parentId);
				System.out.println("replies.size: " + replies.size());
				
				new Gson().toJson(replies, response.getWriter());
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
				
		//펀딩페이지, 서포터 페이지로 이동 - 정수연
		else if(command.equals("/fundingSupporter.do")) {	
			action = new FundingSupporterAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//결제 페이지로 이동 - 하유진
		else if(command.equals("/fundingOrder.do")) {	
			action = new FundingOrderAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//결제 처리, 간단한 결제 확인 페이지로 이동- 하유진
		else if(command.equals("/fundingPayment.do")) {	
			action = new FundingPaymentAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(forward!=null){ 
			if(forward.isRedirect()){
				response.sendRedirect(forward.getPath());
			}else{
				RequestDispatcher dispatcher=request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
		}
	}
}
