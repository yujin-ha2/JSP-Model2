package net.funding.action;

import java.io.IOException;
import java.util.Vector;

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
import net.funding.db.fundingDAO;
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

		
		//메이커 상세 페이지로 이동	
		if(command.equals("/CompanyDetailAction.go")){
			action= new CompanyDetailAction();
	       
	        try {
	    	   forward = action.execute(request, response);
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
		}
		
		//메이커 상세 페이지, 팔로우 & 팔로우 취소 Ajax
		else if(command.equals("/FollowAction.go")) {
			
			 JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
			 
		     String id = data.get("id").getAsString();							 	//팔로우하는 회원(팔로워)
		     String companyId = data.get("companyId").getAsString(); 		 	//팔로우당하는 회사(팔로우)
		     int followbtn = Integer.parseInt(request.getParameter("followbtn"));	//0 : 팔로우하기, 1 : 팔로우취소
			 
		     int followCount = new fundingDAO().followCompany(id, companyId, followbtn);
			 
			 new Gson().toJson(followCount, response.getWriter());
		}
		
		//
		else if(command.equals("/FundingListAction.do")) {	
			action = new FundingListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if(command.equals("/FundingListAjax.do")) {
			request.setCharacterEncoding("utf-8");
			action = new FundingListAction();			
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");

			     int category = data.get("category").getAsInt(); //카테고리 숫자값 0-5
			     int statusVal = data.get("statusVal").getAsInt();
			     int sortVal = data.get("sortVal").getAsInt(); // 정렬값
			     //String text = data.get("text").getAsString(); //입력값
			     
			     System.out.println(category);
			     System.out.println(sortVal);
			     //System.out.println(text);
			     fundingDAO dao = new fundingDAO(); 
				 Vector<AllFundingInfoBean> v = dao.getAllFundinglist(category, statusVal, sortVal);
				 
				 new Gson().toJson(v, response.getWriter());			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(command.equals("/FundingTextList.do")) {			
			JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
			response.setHeader("Content-Type", "application/json"); 
			response.setContentType("text/html;charset=UTF-8"); 
			response.setCharacterEncoding("utf-8");
			
		     int category = data.get("category").getAsInt(); //카테고리 숫자값 0-5
		     int statusVal = data.get("statusVal").getAsInt();
		     int sortVal = data.get("sortVal").getAsInt(); // 정렬값
		     String text = data.get("text").getAsString(); //입력값
		     
		     System.out.println(category);
		     System.out.println(sortVal);
		     System.out.println(text);
		     fundingDAO dao = new fundingDAO(); 
			 Vector<AllFundingInfoBean> v = dao.FundingTextListAction(category, statusVal, sortVal, text);	
			 
			 new Gson().toJson(v, response.getWriter());	
		}
		
		//펀딩페이지, 서포터 페이지로 이동 - 정수연
		else if(command.equals("/FundingDetailSupport.do")) {	
			action = new FundingDetailSupportAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//펀딩페이지, 제공 정보 페이지로 이동 - 정지운
		else if(command.equals("/fundingDetailInfo.do")) {
			action = new fundingDetailInfoAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//펀딩페이지, 스토리 페이지로 이동 - 정지운
		else if(command.equals("/fundingDetailStory.do")) {
			action=new fundingDetailStoryAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		else if(command.equals("/detailAction.do")) {
            int fundingId =(int)request.getSession().getAttribute("fundingId");
            
            JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
            String num = data.get("num").getAsString();
            
            RewardBean list = new fundingDAO().getdetail(fundingId, num);
            new Gson().toJson(list, response.getWriter()); 
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
