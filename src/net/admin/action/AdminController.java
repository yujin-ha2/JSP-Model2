package net.admin.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;

public class AdminController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	private void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
		String RequestURI=request.getRequestURI();
		System.out.println(RequestURI);
		
		String contextPath=request.getContextPath();
		System.out.println("ad_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("ad_command:" + command);
		
		ActionForward forward = null;
		Action action = null;
		
		//���ΰ��� �޴�
		if(command.equals("/AdminApproveListAction.ad")) {
			action = new AdminApproveListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		else if(command.equals("/AdminApproveAction.ad")) {
			action = new AdminApproveAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		/*
		//�������� �޴�
		else if(command.equals("/AdminNoticeListAction.ad")) {
			action = new AdminNoticeListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		*/
		//ȸ������ �޴�
		else if(command.equals("/AdminMemberGeneralListAction.ad")) {
			action = new AdminMemberGeneralListAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//ȸ�� �������·� ����
		else if(command.equals("/AdminMemberSuspenderAction.ad")) {
			action = new AdminMemberSuspenderAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//���� ������ �Ϲݰ������� ���� 
		else if(command.equals("/AdminMemberStateReturnAction.ad")) {
			action = new AdminMemberStateReturnAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//��ʰ��� �޴�
		else if(command.equals("/AdminBannerSetAction.ad")) {
			action = new AdminBannerSetAction();			
			try {
				forward=action.execute(request, response);						
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//��� ����
		else if(command.equals("/AdminBannerUpdateAction.ad")) {
			action = new AdminBannerUpdateAction();			
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
			
			
	
	
