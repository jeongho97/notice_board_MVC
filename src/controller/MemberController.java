package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDao;
import dto.MemberDto;
import net.sf.json.JSONObject;

@WebServlet("/member")
public class MemberController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
	
	public void doProcess(HttpServletRequest req, HttpServletResponse resp)throws ServletException, IOException{
		System.out.println("MemberController doProcess");
		req.setCharacterEncoding("utf-8");
		
		String param=req.getParameter("param"); //구분자
		
		if(param.equals("login")) {
			resp.sendRedirect("member/login.jsp");
		}
		else if(param.equals("regi")) {
			resp.sendRedirect("member/regi.jsp");
		}
		else if(param.equals("checkid")) {
			String id=req.getParameter("id");
			System.out.println("id:"+id);

			//DB 접속 Data 산출
			MemberDao dao=MemberDao.getInstance();
			boolean b=dao.getId(id);
			
			String str = "NO";
			if(b == false) {
				str = "OK";
			}
			
			JSONObject obj = new JSONObject();
			obj.put("str",str);
			
			resp.setContentType("application/x-json; charset=utf-8");
			resp.getWriter().print(obj);
			
			
		}
		else if(param.equals("regiAf")) {
			String id=req.getParameter("id");
			String pwd=req.getParameter("pwd");
			String name=req.getParameter("name");
			String email=req.getParameter("email");

			//out.println(id+" "+pwd+" "+name+" "+email);
			MemberDao dao = MemberDao.getInstance();
			MemberDto dto=new MemberDto(id,pwd,name,email,0);
			boolean isS = dao.addMember(dto);
			
			String msg="OK";
			if(isS == false) {
				msg="NG";
			}
			resp.sendRedirect("message.jsp?proc=regi&msg="+msg);
		}
		else if(param.equals("loginAf")) {
			String id=req.getParameter("id");
			String pwd=req.getParameter("pwd");
			
			MemberDao dao=MemberDao.getInstance();
			MemberDto dto=dao.login(new MemberDto(id,pwd,null,null,0));
			String msg="";
			if(dto != null && !dto.getId().equals("")){
				req.getSession().setAttribute("login", dto);
				msg="yes_login";
			}else {
				msg="no_login";
			}
			resp.sendRedirect("message.jsp?proc=login&msg="+msg);
				
				
		}
		
	}
}
