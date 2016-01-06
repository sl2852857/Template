package com.hullsoft.web.admin;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Page;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.admin.IMenuService;
import com.hullsoft.service.admin.IRoleService;
import com.hullsoft.utils.DateUtils;

/**
 * Description:角色Controller
 * Create DateTime: 2015年11月5日 上午11:11:01
 * @author xanxus
 */
@Controller
@RequestMapping("/admin/role")
public class RoleController {
	private static final Logger log = LoggerFactory.getLogger(RoleController.class);
	
	@Resource
	private IRoleService roleService;
	
	@Resource
	private IMenuService menuService;

	/**
	 * 权限编辑
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping("/editRoot.do")
	public String toAdd(Model model, HttpServletRequest request) {
		//若method为add则不去查询menuList
		String method = request.getParameter("method");
		Integer roleID = Integer.parseInt(request.getParameter("roleID"));
		if(method.equals("edit")) {
			//编辑权限，将原有权限对应的菜单id集合获取
			Condition condition = new Condition();
			condition.put("roleID", roleID);
			List<Menu> menuList = roleService.selectMenuListById(roleID);
			List<Integer> menuIdList = new ArrayList<Integer>();
			for(Menu m:menuList) {
				menuIdList.add(m.getId());
				for(Menu m2:m.getMenuList()) {
					menuIdList.add(m2.getId());
				}
			}
			model.addAttribute("menuIdList", menuIdList);
		}
		//获取所有菜单
		List<Menu> allMenuList = menuService.selectList(new Condition());
		model.addAttribute("roleID", roleID);
		model.addAttribute("allMenuList", allMenuList);
		return "admin/role/addOrEdit";
	}
	
	/**
	 * 添加角色信息
	 * @param name
	 * @param menuIds
	 * @return
	 */
	@RequestMapping(value = "/add.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String add(String name, int status) {
		log.info("添加角色信息");
		Result result = new Result();
		try {
			Role role = new Role();
			role.setName(name);
			String now = DateUtils.now("yyyy-MM-dd HH:mm:ss");
			role.setCreateTime(now);
			role.setLastUpdateTime(now);
			role.setStatus(status);//默认启用
			Integer roleID = roleService.insertAndBackId(role);
			result.put("roleID", roleID);
			result.setState(Result.SUCCESS);
		} catch (DuplicateKeyException e) { //重复键异常：name字段设置了unique约束
			log.info("唯一性约束冲突，持久化数据失败");
			result.setState(Result.FAILURE);
			result.setMsg("角色名["+name+"]已存在");
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 删除角色信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/delete.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String delete(int id) {
		log.info("删除角色");
		Result result = new Result();
		try {
			roleService.deleteById(id, result);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 修改角色信息
	 * @param role
	 * @param menuIds
	 * @return
	 */
	@RequestMapping(value = "/update.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String update (Role role, int[] menuIds) {
		log.info("------ 根据角色信息与权限 Start ------");
		Result result = new Result();
		try {
			if(role.getName()!=null) {
				role.setName(URLDecoder.decode(role.getName(), "utf-8"));
			}
			roleService.updateById(role, menuIds);
			result.setState(Result.SUCCESS);
		} catch (DuplicateKeyException e) { //重复键异常：name字段设置了unique约束
			log.info("唯一性约束冲突，持久化数据失败");
			result.setState(Result.FAILURE);
			result.setMsg("角色名["+role.getName()+"]已存在");
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		log.info("------ 根据角色信息与权限 End ------");
		return result.toJSONString();
	}
	
	/**
	 * 查询角色信息列表
	 * @return
	 */
	@RequestMapping(value = "list.do", produces = "application/json;charset=UTF-8")
	public String list(Model model, Page<Role> page, HttpServletRequest request) {
		log.info("查询角色信息列表");
		try {
			String searchValue = request.getParameter(Condition.SEARCH_VALUE);
			searchValue = searchValue==null?"":URLDecoder.decode(searchValue, "utf-8");
			page.setSearchValue(searchValue);
			page.setLimit(false);
			page = roleService.selectList(page);
			model.addAttribute("searchValue", searchValue);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("系统异常", e);
		}
		return "admin/role/list";
	}
	
	/**
	 * 加载数据
	 * @param model
	 * @param page
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "data.do")
	public String data(Model model, Page<Role> page, HttpServletRequest request) {
		log.info("加载角色数据");
		try {
			String searchValue = request.getParameter("searchValue");
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
			page.setSearchValue(searchValue);
			page = roleService.selectList(page);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("系统异常", e);
		}
		return "admin/role/data";
	}
	
	/**
	 * 根据角色ID获取详细信息，包括对应菜单
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/details.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String details(int id) {
		log.info("获取角色详细信息");
		Result result = new Result();
		try {
			Role role = roleService.selectById(id);
			result.setState(Result.SUCCESS);
			result.put("role", role);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
}
