package com.hullsoft.web.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Page;
import com.hullsoft.entity.common.Result;
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

	/**
	 * 添加角色信息
	 * @param name
	 * @param menuIds
	 * @return
	 */
	@RequestMapping(value = "/add.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String add(String name, int[] menuIds) {
		log.info("添加角色信息");
		Result result = new Result();
		try {
			Role role = new Role();
			role.setName(name);
			String now = DateUtils.now("yyyy-MM-dd HH:mm:ss");
			role.setCreateTime(now);
			role.setLastUpdateTime(now);
			role.setStatus(0);//默认启用
			roleService.insert(role, menuIds);
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
			roleService.deleteById(id);
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
		Result result = new Result();
		try {
			roleService.updateById(role, menuIds);
		} catch (DuplicateKeyException e) { //重复键异常：name字段设置了unique约束
			log.info("唯一性约束冲突，持久化数据失败");
			result.setState(Result.FAILURE);
			result.setMsg("角色名["+role.getName()+"]已存在");
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 查询角色信息列表
	 * @return
	 */
	@RequestMapping(value = "list.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String list(Page<Role> page, HttpServletRequest request) {
		log.info("查询角色信息列表");
		Result result = new Result();
		try {
			String searchValue = request.getParameter(Condition.SEARCH_VALUE);
			page.setSearchValue(searchValue);
			page = roleService.selectList(page);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
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
