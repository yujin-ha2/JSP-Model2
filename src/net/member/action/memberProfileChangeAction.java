package net.member.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.action.Action;
import net.action.ActionForward;
import net.member.db.MemberDAO;

public class memberProfileChangeAction implements Action {
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		String id = (String)request.getSession().getAttribute("id"); 
		ActionForward forward = new ActionForward();

		// request.getRealPath("�����") �� ���� ������ ������ ���� ��θ� ���ؿ´�.
		// �ü�� �� ������Ʈ�� ��ġ�� ȯ�濡 ���� ��ΰ� �ٸ��� ������ �Ʒ�ó�� ���ؿ��°� ����
		String uploadPath = request.getRealPath("/profileUpload");
		int maxSize = 1024 * 1024 * 10; // �ѹ��� �ø� �� �ִ� ���� �뷮 : 10M�� ����
		MultipartRequest multi = null;
		
		// request,����������,�뷮,���ڵ�Ÿ��,�ߺ����ϸ� ���� �⺻ ��å
		multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		
		String originalName = multi.getOriginalFileName("file");
		String file = multi.getFilesystemName("file");
		
		request.setCharacterEncoding("UTF-8");
		MemberDAO dao = new MemberDAO();
		dao.profileImgUpdate(file, id);

		StringBuffer sb = new StringBuffer();
		sb.append("<script type='text/javascript'>");
		sb.append("window.close();");
		sb.append("</script>");
		PrintWriter out = response.getWriter();
		out.print(sb);
		out.flush();

		return null;
		
	}

}
