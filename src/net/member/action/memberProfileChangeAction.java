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

		// request.getRealPath("상대경로") 를 통해 파일을 저장할 절대 경로를 구해온다.
		// 운영체제 및 프로젝트가 위치할 환경에 따라 경로가 다르기 때문에 아래처럼 구해오는게 좋음
		String uploadPath = request.getRealPath("/profileUpload");
		int maxSize = 1024 * 1024 * 10; // 한번에 올릴 수 있는 파일 용량 : 10M로 제한
		MultipartRequest multi = null;
		
		// request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
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
