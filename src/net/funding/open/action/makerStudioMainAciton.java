package net.funding.open.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.Action;
import net.action.ActionForward;
import net.action.StatusName;
import net.funding.open.db.AllProject;
import net.funding.open.db.FundingOpenDAO;

public class makerStudioMainAciton implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		String id = (String)request.getSession().getAttribute("id");
		int fundingId = Integer.parseInt(request.getParameter("fundingId"));
		
		FundingOpenDAO openDao = new FundingOpenDAO();

		String status = "";
		List<String> statusBtnList = new ArrayList<String>();
		List<String> writeList = new ArrayList<String>();
		List<String> statusList = new ArrayList<String>();
		StatusName statusName = new StatusName();
		
		if(fundingId == 0) {
			System.out.println("before_fundingId : " + fundingId);
			//������Ʈ ����
			fundingId = openDao.insertNewProject(id);
			System.out.println("after_fundingId : " + fundingId);
			
			status = "prepare";
			statusList.add("prepare");
			statusList.add(statusName.get("prepare"));
			statusList.add(statusName.get("prepareDetail"));
			statusBtnList = Arrays.asList("�ۼ��ϱ�", "�ۼ��ϱ�", "�ۼ��ϱ�", "�ۼ��ϱ�", "�ۼ��ϱ�");
			writeList = Arrays.asList("�ۼ���", "�ۼ���", "�ۼ���", "�ۼ���", "�ۼ���"); 
			
		}else {
			List<String> isRegList = openDao.getProjectStatus(fundingId);
		
			if(isRegList == null) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('����Ŀ ��Ʃ����� �Ѿ�µ� ������ �߻��߽��ϴ�.');");
				out.println("location.href='fundingOpenMain.on';");
				out.println("</script>");
				out.close();
				return null;
			}else {
				
	//			public static List<String> ConfirmBtnList = Arrays.asList("Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�"); 
	//			public static List<String> ReviseBtnList = Arrays.asList("�����ϱ�", "�����ϱ�", "�����ϱ�", "�����ϱ�", "�����ϱ�"); 
	//			public static List<String> ApproveBtnList = Arrays.asList("Ȯ���ϱ�", "�����ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�"); 
	//			public static List<String> writeLis1t = Arrays.asList("�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�");
				status = isRegList.get(5);
				statusList.add(status);
				statusList.add(statusName.get(status));
				statusList.add(statusName.get(status+"Detail"));
				if(status.equals("prepare")) {
					
					for(int i=0; i<5; i++) {
						statusBtnList.add(isRegList.get(i).equals("0") ? "�ۼ��ϱ�": "�����ϱ�");
						writeList.add(isRegList.get(i).equals("0") ? "�ۼ���": "�ۼ��Ϸ�");
					}
				}else if(status.equals("reject")) {
					statusBtnList = Arrays.asList("�����ϱ�", "�����ϱ�", "�����ϱ�", "�����ϱ�", "�����ϱ�");
					writeList = Arrays.asList("�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�");
				}else if(status.equals("approve")) {
					statusBtnList = Arrays.asList("Ȯ���ϱ�", "�����ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�");
					writeList = Arrays.asList("�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�"); 
				}else {
					statusBtnList = Arrays.asList("Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�", "Ȯ���ϱ�");
					writeList = Arrays.asList("�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�", "�ۼ��Ϸ�"); 
				}
				
			}
		}
		
		request.setAttribute("statusBtnList", statusBtnList);
		request.setAttribute("writeList", writeList);
		request.setAttribute("statusList", statusList);
		request.setAttribute("fundingId", fundingId);
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(false);
		forward.setPath("fundingOpen/makerStudioMain.jsp");
		
		return forward;
	}

}
