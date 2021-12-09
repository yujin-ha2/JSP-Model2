package net.funding.open.action;

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
import net.funding.open.db.FundingOpenDAO;
import net.funding.open.db.rewardInfoBean;

public class FundingOpenController extends HttpServlet{

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
		System.out.println(RequestURI);
		
		String contextPath=request.getContextPath();
		//System.out.println("op_contextPath:" + contextPath);
		
		String command=RequestURI.substring(contextPath.length()+6);
		System.out.println("op_command:" + command);
		
		ActionForward forward = null;
		Action action = null;

		//�ݵ� ���� �޴��� ���� ȭ������ �̵�
		if(command.equals("/fundingOpenMain.on")) {
			forward=new ActionForward();
			forward.setRedirect(false);
			forward.setPath("fundingOpen/fundingOpenMain.jsp");
		}
		
		//����Ŀ ���� ��� ȭ������ �̵�
		else if(command.equals("/makerEasyRegForm.on")) {
			action=new makerEasyRegFormAction(); //��ũ��Ʈ�� ��޷� ����(�ΰ�)
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ���� ��� ó�� ��û�� ������ ��
		else if(command.equals("/makerEasyReg.on")){
			action=new makerEasyRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//���� ���� ������Ʈ ȭ������ �̵�
		else if(command.equals("/myprojectList.on")) {
			action=new myProjectListAction();
				
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� ���� ȭ������ �̵�
		else if(command.equals("/makerStudioMain.on")) {
			action=new makerStudioMainAciton(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//����Ŀ ��Ʃ��� - �ݵ� ���� ��û (ajax)
		else if(command.equals("/RequestFundingApproval.on")) {
			try {
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			     
			    int fundingId = data.get("fundingId").getAsInt(); 
			    
			    String message = "";
			    int result = new FundingOpenDAO().RequestForApproval(fundingId);
				if(result == 1) 
					message = "������Ʈ �غ� �ۼ��� ����Ǿ����ϴ�.";
				else 
					message = "������Ʈ ���⿡ �����Ͽ����ϴ�.";
			
				new Gson().toJson(message, response.getWriter());	
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ��� ��� ȭ������ �̵�
		else if(command.equals("/BasicRequireRegForm.on")) {
			action=new BasicRequireFormAction(); 
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ��� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/BasicRequireReg.on")) {
			action=new BasicRequireRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ��� ���� �������� �̵� 
		else if(command.equals("/BasicRequireUpdateForm.on")) {
			action=new BasicRequireUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ����/���丮 ��� ȭ������ �̵�
		else if(command.equals("/BasicInfoRegForm.on")) {
			action=new BasicInfoRegFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ����/���丮 ��� ó�� ��û�̵����� �� 
		else if(command.equals("/BasicInfoReg.on")) {
			action=new BasicInfoRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - �⺻ ����/���丮 ���� �������� �̵� 
		else if(command.equals("/BasicInfoUpdateForm.on")) {
			action=new BasicInfoUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ������ ���� ��� ȭ������ �̵�
		else if(command.equals("/rewardRegForm.on")) {
			
			action=new RewardRegFormAction();
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ������ ���� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/rewardReg.on")) {
			action=new RewardRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ������ ���� ���� ȭ������ �̵� 
		else if(command.equals("/rewardUpdateForm.on")) {
			action=new RewardUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	
		//����Ŀ ��Ʃ��� - ���� ���� ��� ȭ������ �̵�
		else if(command.equals("/rewardDetailRegForm.on")) {
			action=new RewardDetailRegFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ī�װ� �� ���� ����Ʈ ��ȯ(ajax)
		else if(command.equals("/conveyCategorydetail.on")) {
			try {
				
				JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
				response.setHeader("Content-Type", "application/json"); 
				response.setContentType("text/html;charset=UTF-8"); 
				response.setCharacterEncoding("utf-8");
			     
			    int categoryId = data.get("categoryId").getAsInt(); //ī�װ� ���ڰ� 0-5
			    System.out.println("ī�װ�id: " + categoryId);
			    
			    FundingOpenDAO dao = new FundingOpenDAO();
				Vector<rewardInfoBean> v = dao.getCategoryDetails(categoryId);
				
			/*	for(rewardInfoBean bean : v) { //for���� ���� ��ü���
				    System.out.println(bean.getDetailId() + " : " + bean.getDetailName() + ", ex: " + bean.getExample());
				}
			*/
				new Gson().toJson(v, response.getWriter());			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//����Ŀ ��Ʃ��� - ������ ��� ó�� ��û�� ������ �� 
		else if(command.equals("/rewardDetailReg.on")) {
			action=new RewardDetailRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ������ ���� ȭ������ �̵�
		else if(command.equals("/rewardDetailUpdateForm.on")) {
			action=new RewardDetailUpdateFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ����Ŀ ���� ��� ȭ������ �̵�
		else if(command.equals("/makerInfoRegForm.on")) {
			action=new MakerInfoFormAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ����Ŀ ���� ��� ó�� ��û�� ������ �� 
		else if(command.equals("/makerInfoReg.on")) {
			action=new MakerInfoRegAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ����Ŀ ���� ���� ȭ������ �̵� 
		else if(command.equals("/makerInfoUpdate.on")) {
			action=new MakerInfoUpdateAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		//����Ŀ ��Ʃ��� - �ݵ� ��Ȳ ȭ������ �̵�
		else if(command.equals("/fundingReport.on")) {
			action=new FundingReportAction();
			
			try {
				forward=action.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//����Ŀ ��Ʃ��� - ���� ��Ȳ ȭ������ �̵�
		else if(command.equals("/fundingResult.on")) {
			action=new FundingResultAction();
			
			try {
				forward=action.execute(request, response);
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
