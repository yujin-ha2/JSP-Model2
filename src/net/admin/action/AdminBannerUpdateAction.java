package net.admin.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


import net.action.Action;
import net.action.ActionForward;
import net.admin.db.BannerBean;
import net.admin.db.adminDAO;
import net.member.db.MemberBean;

public class AdminBannerUpdateAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();

		String uploadPath = request.getRealPath("/bannerUpload");
		int maxSize = 1024 * 1024 * 10; // 10MÅ©±â
		MultipartRequest multi = null;
		
		multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
		
		String originalName1 = multi.getOriginalFileName("file1");
		String originalName2 = multi.getOriginalFileName("file2");
		String originalName3 = multi.getOriginalFileName("file2");
		String originalName4 = multi.getOriginalFileName("file2");

		String file1 = multi.getFilesystemName("file1");
		String file2 = multi.getFilesystemName("file2");
		String file3 = multi.getFilesystemName("file3");
		String file4 = multi.getFilesystemName("file4");
		
		String link1 = multi.getParameter("link1");
		String link2 = multi.getParameter("link2");
		String link3 = multi.getParameter("link3");
		String link4 = multi.getParameter("link4");
		
	   	request.setCharacterEncoding("UTF-8");
	   	
		adminDAO dao = new adminDAO();
		dao.bannerImgUpdate(file1, file2, file3, file4, link1, link2, link3, link4);

		forward.setRedirect(false);
		forward.setPath("AdminBannerSetAction.ad");

		return forward;
	}


}
