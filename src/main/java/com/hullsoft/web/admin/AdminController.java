/**
 * 
 */
package com.hullsoft.web.admin;

import java.net.URLDecoder;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.hullsoft.entity.admin.Admin;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Page;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.admin.IAdminService;
import com.hullsoft.service.admin.IMenuService;
import com.hullsoft.service.admin.IRoleService;
import com.hullsoft.utils.DateUtils;

/**
 * @author Administrator
 * AdminController
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	private static final Logger log = LoggerFactory.getLogger(AdminController.class);
	
	@Resource
	private IAdminService adminService;
	
	@Resource
	private IMenuService menuService;
	
	@Resource
	private IRoleService roleService;
	
	/**
	 * 异步请求登录
	 * @param request
	 * @param username 用户名
	 * @param password 密码
	 * @return 请求结果
	 */
	@RequestMapping(value="/login.do", produces="application/json;charset=UTF-8", method=RequestMethod.POST)
	public @ResponseBody String login(HttpServletRequest request, String username, String password) {
		Result result = new Result(); //返回结果
		try {
			adminService.login(username, password, request, result);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return JSON.toJSONString(result);
	}
	
	/**
	 * 注销用户
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/logout.do", produces = "application/json")
	public @ResponseBody String logout(HttpServletRequest request){
		Result result = new Result();
		try {
			HttpSession session = request.getSession();
			Admin admin = (Admin)session.getAttribute("loginAdmin");
			if(admin == null) {
				log.info("HttpSession中已无LoginAdmin的值");
				result.setMsg("session用户缓存已被清除");
			}else{
				log.info("用户["+admin.getUsername()+"]登出，清除session中的缓存");
				session.removeAttribute("loginAdmin");
			}
			result.setState(Result.SUCCESS);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 添加或编辑
	 * @param model
	 * @param method   添加=add，编辑=edit
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddOrEdit")
	public String toAddOrEdit(Model model, String method, HttpServletRequest request) {
		if("edit".equals(method)) {
			//编辑操作，查询id对应信息
			Integer id = Integer.parseInt(request.getParameter("id"));
			Admin admin = adminService.selectById(id);
			model.addAttribute("admin", admin);
		}
		//查询角色列表
		Page<Role> page = new Page<Role>();
		page.setLimit(false);//无限制
		page = roleService.selectList(page);
		model.addAttribute("page", page);
		model.addAttribute("method", method);
		return "admin/admin/addOrEdit";
	}
	
	/**
	 * 添加用户
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/add.do", produces= "application/json;charset=UTF-8", method = RequestMethod.POST)
	public @ResponseBody String save(Admin admin) {
		log.info("添加用户");
		Result result = new Result();
		try {
			adminService.insert(admin);
			result.setState(Result.SUCCESS);
		} catch (DuplicateKeyException e) {
			log.info("唯一性约束条件冲突，用户名已存在，添加失败");
			result.setState(Result.FAILURE);
			result.setMsg("用户名已存在");
		} catch (Exception e) {
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 删除用户信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String delete(int id) {
		log.info("删除用户信息");
		Result result = new Result();
		try {
			adminService.deleteById(id);
			result.setState(Result.SUCCESS);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 修改密码
	 * @param id
	 * @param oldPwd
	 * @param newPwd
	 * @return
	 */
	@RequestMapping(value = "/updatePwd.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String updatePassword(Integer id, String oldPwd, String newPwd) {
		log.info("修改用户密码");
		Result result = new Result();
		try {
			adminService.updatePwd(id, oldPwd, newPwd, result);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 修改用户信息
	 * @param admin
	 * @return
	 */
	@RequestMapping(value = "/update.do", produces="application/json;charset=UTF-8")
	public @ResponseBody String update(Admin admin) {
		log.info("修改用户信息");
		Result result = new Result();
		try {
			adminService.updateById(admin);
			result.setState(Result.SUCCESS);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 查询用户详情
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "details.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String details(int id) {
		log.info("查询用户详情");
		Result result = new Result();
		try {
			Admin admin = adminService.selectById(id);
			result.setState(Result.SUCCESS);
			result.put("admin", admin);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	

	/**
	 * 查询列表
	 * @param model
	 * @param page 
	 * @param request
	 * @return 请求结果
	 */
	@RequestMapping("/list.do")
	public String list(Model model, Page<Admin> page, HttpServletRequest request) {
		log.info("查询用户列表");
		Result result = new Result();
		try {
			String searchValue = request.getParameter("searchValue");
			searchValue = searchValue==null?"":searchValue;
			page.setSearchValue(URLDecoder.decode(searchValue, "utf-8"));
			page.setLimit(false);//不限制查询总数
			page = adminService.selectList(page);
			model.addAttribute("page", page);
			model.addAttribute("searchValue", searchValue);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return "admin/admin/list";
	}
	
	/**
	 * 加载用户信息数据
	 * @param model
	 * @param page
	 * @param request
	 * @return
	 */
	@RequestMapping("/data.do")
	public String data(Model model, Page<Admin> page, HttpServletRequest request) {
		log.info("加载用户信息数据");
		try {
			String searchValue = request.getParameter("searchValue");
			page.setSearchValue(URLDecoder.decode(searchValue, "utf-8"));
			page = adminService.selectList(page);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("系统异常", e);
		}
		return "admin/admin/data";
	}
	
	/**
	 * 跳转后台首页
	 * @return
	 */
	@RequestMapping("/index.do")
	public String index(Model model, HttpServletRequest request) {
		Admin admin = (Admin)request.getSession().getAttribute("loginAdmin");
		Role role = null;
		if(admin.getRoleID()==null || admin.getRoleID()==0) {
			//没有roleID则登录用户是系统超级管理员
			log.info("***【系统超级管理员】登入系统***");
			role = Role.getSaRole();
		}else {
			role = roleService.selectByIdAndMenuIsEnable(admin.getRoleID());
		}
		model.addAttribute("role", role);
		//获取用户角色和权限
		return "index";
	}
	
}
