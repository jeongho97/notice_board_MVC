package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BbsDao;
import dto.BbsDto;

@WebServlet("/bbs")
public class bbsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(req,resp);
	}
	public void doProcess(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException{
		System.out.println("bbsController doProcess");
		req.setCharacterEncoding("utf-8");
		
		String param=req.getParameter("param"); //구분자
		
		if(param.equals("bbslist")) {
			String sPageNumber = req.getParameter("pageNumber");
			String choice = req.getParameter("choice");
			String search = req.getParameter("search");
			
			int pageNumber = 0;
			if(sPageNumber != null && sPageNumber.equals("") == false){
				pageNumber = Integer.parseInt(sPageNumber);
			}
			
			if(choice == null){
				choice = "";
			}
			if(search == null){
				search = "";
			}
			BbsDao dao = BbsDao.getInstance();
			//List<BbsDto> list = dao.getBbsList();
			//List<BbsDto> list = dao.getBbsSearchList(choice, search);
			List<BbsDto> list = dao.getBbsPagingList(choice, search, pageNumber);
			
			// 글의 총수
			int len = dao.getAllBbs(choice, search);
			System.out.println("글의 총수:" + len);

			// 페이지수
			int bbsPage = len / 10;
			if(len % 10 > 0){
				bbsPage = bbsPage + 1;	
			}
			
			req.setAttribute("pageNumber", pageNumber);
			req.setAttribute("choice", choice);
			req.setAttribute("search", search);
			req.setAttribute("bbsPage", bbsPage);
			req.setAttribute("list", list);		// 짐싸!
			
		//	RequestDispatcher dispatch = req.getRequestDispatcher("bbslist.jsp");
		//	dispatch.forward(req, resp);
			forward("bbs/bbslist.jsp", req, resp);	// 잘가!
			
		}
		else if(param.equals("bbswrite")) {
			resp.sendRedirect("bbs/bbswrite.jsp");
		}
		else if(param.equals("bbswriteAf")) {
			String id=req.getParameter("id");
			String title=req.getParameter("title");
			String content=req.getParameter("content");
			BbsDao dao=BbsDao.getInstance();

			boolean isS=dao.writeBbs(new BbsDto(id,title,content));
			String msg="";
			if(isS) {
				msg="write_success";
			}else {
				msg="wirte_error";
			}
			resp.sendRedirect("message.jsp?proc=write&msg="+msg);
		}
		else if(param.equals("bbsdetail")) {
			String seq=req.getParameter("seq");
			resp.sendRedirect("bbs/bbsdetail.jsp?seq="+seq);
		}
		else if(param.equals("answer")) {
			String seq=req.getParameter("seq");
			resp.sendRedirect("bbs/answer.jsp?seq="+seq);
		}
		else if(param.equals("answerAf")) {
			int seq=Integer.parseInt(req.getParameter("seq"));
			String id = req.getParameter("id");
			String title=req.getParameter("title");
			String content=req.getParameter("content");
			
			BbsDao dao = BbsDao.getInstance();
			boolean isS=dao.answer(seq, new BbsDto(id,title,content));
			String msg="";
			if(isS) {
				msg="answer_success";
			}else {
				msg="answer_error";
			}
			resp.sendRedirect("message.jsp?proc=answer&msg="+msg);
		}
		else if(param.equals("update")) {
			String seq=req.getParameter("seq");
			resp.sendRedirect("bbs/update.jsp?seq="+seq);
		}
		else if(param.equals("updateAf")) {
			int seq=Integer.parseInt(req.getParameter("seq"));
			String id = req.getParameter("id");
			String title=req.getParameter("title");
			String content=req.getParameter("content");
			
			BbsDao dao = BbsDao.getInstance();
			boolean isS=dao.update(seq, new BbsDto(id,title,content));
			String msg="";
			if(isS) {
				msg="update_success";
			}else {
				msg="update_error";
			}
			resp.sendRedirect("message.jsp?proc=update&msg="+msg+"&seq="+seq);
		}
		else if(param.equals("delete")) {
			int seq=Integer.parseInt(req.getParameter("seq"));
			BbsDao dao = BbsDao.getInstance();
			boolean isS=dao.delete(seq);
			String msg="";
			if(isS) {
				msg="delete_success";
			}else {
				msg="delete_error";
			}
			resp.sendRedirect("message.jsp?proc=delete&msg="+msg);
		}
		
	}
	public void forward(String arg,HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatch = req.getRequestDispatcher(arg);
		dispatch.forward(req, resp);
	}

}