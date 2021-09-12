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

		//ȸ������ ȭ������ �̵�
		if(command.equals("/MemberJoin.me")){
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("./index.jsp?center=/aroma/member/join.jsp");
		}
		
		//ȸ������ ó�� ��û�� ��� ������
		else if(command.equals("/MemberJoinAction.me")){
			action=new MemberJoinAction();
			
			try {
				forward=action.execute(request, response);
						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ������ ��ȿ�� üũ
		else if(command.equals("/IdCheck.me")){
			 response.setContentType("text/html;charset=utf-8");
	         JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
	         String id = data.get("id").getAsString();
	         System.out.println("id="+id);
	         
	         MemberDAO dao = new MemberDAO();
	         int idx = dao.idCheck(id);
	         
	         if(idx == 1){
	            new Gson().toJson("�̹� �����ϴ� ���̵� �Դϴ�.", response.getWriter());
	         }else{
	            new Gson().toJson("��밡���� ���̵� �Դϴ�.", response.getWriter());
	         }
		}
		
		//�α��� ȭ������ �̵�
		else if(command.equals("/MemberLogin.me")){ 	
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("/aroma/member/login.jsp"); 
		}

		//�α��� ó�� ��û�� ������ ��
		else if(command.equals("/MemberLoginAction.me")){
			action=new MemberLoginAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//�α׾ƿ� ó�� ��û�� ������ ��
		else if(command.equals("/MemberLogout.me")){
			action=new MemberLogoutAction(); 

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//���� ȭ������ �̵�
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
		
		//���������� ȭ������ �̵�
		else if(command.equals("/Mypage.me")) {
			action = new MypageAction();
			
			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//���������� ȭ������ �̵�
		else if(command.equals("/memberProfileChange.me")) {
			action=new memberProfileChangeAction();

			try {
				forward=action.execute(request, response); 
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����������(������), ���� ����Ŀ �ȷ��� ����Ʈ ȭ������ �̵�
		else if(command.equals("/myFollowList.me")){
	       action= new myFollowListAction();
	       
	       try {
	    	   forward = action.execute(request, response);
	       } catch (Exception e) {
	       e.printStackTrace();
	       }
	    }
		
		//ȸ�� ���� ���� ȭ������ �̵�
		else if(command.equals("/MyInfoUpdateForm.me")){
			action = new MyInfoUpdateFormAction();
			try{
				forward = action.execute(request, response);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� ���� ���� ó�� ��û�� ������ ��
		else if(command.equals("/MyInfoUpdate.me")){
			action = new MyInfoUpdateAction();
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	

		//���̵� ã�� ȭ������ �̵�
		else if(command.equals("/FindIdForm.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/findIdForm.jsp");
		}
		
		//���̵� ã�� ó�� ��û�� ������ ��
		else if(command.equals("/ShowId.me")){
			action = new ShowIdAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//��й�ȣ ã�� ȭ������ �̵�
		else if(command.equals("/FindPwdForm.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/findPwdForm.jsp");
		}
		
		//��й�ȣ ã�⿡�� ����� ���� ��û�� ������ ��
		else if(command.equals("/CheckMember.me")){
			action = new CheckMemberAction();
			try{
				forward = action.execute(request, response);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		//��й�ȣ ���� ��û�� ������ ��
		else if(command.equals("/passwordUpdate.me")){
			action= new PasswordUpdateAction();
			try {
				forward = action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� Ż�� ȭ������ �̵�
		else if(command.equals("/MemberDeleteForm.me")) {
			forward=new ActionForward();
			forward.setRedirect(false); 
			forward.setPath("member/memberDelete.jsp");
		}

		//ȸ�� Ż�� ��û�� ������ ��
		else if(command.equals("/MemberDelete.me")){
			action= new MemberDeleteAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		//���������� ȭ�� �̵�
		else if(command.equals("/MemberDelete.me")){
			action= new issueCouponAction();
			try {
			forward = action.execute(request, response);
			} catch (Exception e) {
			e.printStackTrace();
			}
		}
		
		
		//�ּ� �̵�
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
