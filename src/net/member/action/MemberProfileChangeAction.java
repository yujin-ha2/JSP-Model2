package net.member.action;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberDAO;

public class MemberProfileChangeAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("memberProfileChangeAction");

		request.setCharacterEncoding("utf-8");
		String id = (String)request.getSession().getAttribute("id"); 

		String uploadPath1 = request.getRealPath("/profileUpload/");
		System.out.println("uploadPath1: " + uploadPath1);
		String uploadPath = request.getSession().getServletContext().getRealPath("/profileUpload/");
		System.out.println("uploadPath: " + uploadPath);
		
		File targetDir = new File(uploadPath);
		if(!targetDir.exists()){
			targetDir.mkdirs();
		}
		
		int maxSize = 1024 * 1024 * 5; // �ѹ��� �ø� �� �ִ� ���� �뷮 : 10M�� ����
		
		// request,����������,�뷮,���ڵ�Ÿ��,�ߺ����ϸ� ���� �⺻ ��å
		MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		String file = multi.getFilesystemName("profileFile");
		
		String type = multi.getParameter("mType");
		System.out.println("type:" + type);
		
		int result = new MemberDAO().profileImgUpdate(file, id, type);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		out.println("<script>");
		out.println("history.back();");
		out.println("opener.document.location.reload();");
		out.println("self.close();");
		out.println("</script>");
		out.close();

		return null;
		
	}

}
