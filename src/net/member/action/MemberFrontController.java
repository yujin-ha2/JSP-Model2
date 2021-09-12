package net.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberFrontController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String RequestURI=request.getRequestURI();
		
		String contextPath=request.getContextPath();
		//System.out.println("contextPath:" + contextPath.length());
		System.out.println("me_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("me_command:" + command);
		
		ActionForward forward = null;
		Action action = null;

		//회원가입 화면으로 이동
		if(command.equals("/MemberJoin.me")){
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./index.jsp?center=/aroma/member/join.jsp");
		}
		
		//회원가입 처리 요청이 들어 왔을떄
		else if(command.equals("/MemberJoinAction.me")){
			action=new MemberJoinAction();
			
			try {
				forward=action.execute(request, response);
						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//회원가입 유효성 체크
		else if(command.equals("/IdCheck.me")){
			 response.setContentType("text/html;charset=utf-8");
	         JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
	         String id = data.get("id").getAsString();
	         System.out.println("id="+id);
	         
	         MemberDAO dao = new MemberDAO();
	         int idx = dao.idCheck(id);
	         
	         if(idx == 1){
	            new Gson().toJson("이미 존재하는 아이디 입니다.", response.getWriter());
	         }else{
	            new Gson().toJson("사용가능한 아이디 입니다.", response.getWriter());
	         }
		}
		
		//로그인 화면으로 이동
		else if(command.equals("/MemberLogin.me")){ 	
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("/aroma/member/login.jsp"); 
		}

		//로그인 처리 요청이 들어왔을 때
		else if(command.equals("/MemberLoginAction.me")){
			action=new MemberLoginAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//로그아웃 처리 요청이 들어왔을 때
		else if(command.equals("/MemberLogout.me")){
			action=new MemberLogoutAction(); 

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//메인 화면으로 이동
		else if(command.equals("/Main.me")){
			/*
			action= new MainLoadAction();
			
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
			*/
			forward=new ActionForward();	
			forward.setRedirect(true);
			forward.setPath("index.jsp"); 
		}
		
		//마이페이지 화면으로 이동
		else if(command.equals("/Mypage.me")) {
			action = new MypageAction();
			
			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//마이페이지 화면으로 이동
		else if(command.equals("/memberProfileChange.me")) {
			action=new memberProfileChangeAction();

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//마이페이지(서포터), 나의 메이커 팔로잉 리스트 화면으로 이동
		else if(command.equals("/myFollowList.me")){
	       action= new myFollowListAction();
	       
	       try {
	    	   forward = action.execute(request, response);
	       } catch (Exception e) {
	       e.printStackTrace();
	       }
	    }
		
		//회원 정보 수정 화면으로 이동
		else if(command.equals("/MyInfoUpdateForm.me")){
			action = new MyInfoUpdateFormAction();
			try{
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//회원 정보 수정 처리 요청이 들어왔을 때
		else if(command.equals("/MyInfoUpdate.me")){
			action = new MyInfoUpdateAction();
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	

		//아이디 찾기 화면으로 이동
		else if(command.equals("/FindIdForm.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/findIdForm.jsp");
		}
		
		//아이디 찾기 처리 요청이 들어왔을 때
		else if(command.equals("/ShowId.me")){
			action = new ShowIdAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//비밀번호 찾기 화면으로 이동
		else if(command.equals("/FindPwdForm.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/findPwdForm.jsp");
		}
		
		//비밀번호 찾기에서 사용자 인증 요청이 들어왔을 때
		else if(command.equals("/CheckMember.me")){
			action = new CheckMemberAction();
			try{
				forward = action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		//비밀번호 변경 요청이 들어왔을 때
		else if(command.equals("/passwordUpdate.me")){
			action= new PasswordUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//회원 탈퇴 화면으로 이동
		else if(command.equals("/MemberDeleteForm.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/memberDelete.jsp");
		}

		//회원 탈퇴 요청이 들어왔을 때
		else if(command.equals("/MemberDelete.me")){
			action= new MemberDeleteAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//마이페이지 화면 이동
		else if(command.equals("/MemberDelete.me")){
			action= new issueCouponAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		
		//주소 이동
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
