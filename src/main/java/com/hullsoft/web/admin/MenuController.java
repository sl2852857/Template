package com.hullsoft.web.admin;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.admin.IMenuService;

/**
 * Description: 菜单controller
 * Create DateTime: 2015年11月2日 下午4:27:53
 * @author xanxus
 */

@Controller
@RequestMapping("/admin/menu")
public class MenuController {
	private static final Logger log = LoggerFactory.getLogger(MenuController.class);

	@Resource
	private IMenuService menuService;
	
	/**
	 * 查询菜单列表
	 * @param model
	 * @param page
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/list.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String list(HttpServletRequest request) {
		log.info("查询菜单列表");
		Result result = new Result();
		try {
			String searchValue = request.getParameter("searchValue");
			Condition c = new Condition();
			searchValue = searchValue==null?"":searchValue;
			c.put(Condition.SEARCH_VALUE, searchValue);
			List<Menu> menuList = menuService.selectList(c);
			result.setState(Result.SUCCESS);
			result.put("menuList", menuList);
		} catch (Exception e) {
			log.error("异常错误", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 添加菜单数据
	 * @param menu
	 * @return
	 */
	@RequestMapping(value = "/add.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String add(Menu menu) {
		log.info("添加菜单数据");
		Result result = new Result();
		try {
			menuService.insert(menu);
			//菜单名称不重复,并执行数据插入
			result.setState(Result.SUCCESS);
		} catch (DuplicateKeyException e) {	//数据库设置约束条件 name&parentID
			log.info("唯一性约束条件冲突，插入数据失败");
			result.setState(Result.FAILURE);
			result.setMsg("菜单名称已存在，请检查");
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 删除菜单数据，若删除主菜单则连同删除子菜单
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/delete.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String delete(int[] ids){
		log.info("删除菜单数据");
		Result result = new Result();
		try {
			for(int id:ids){
				menuService.deleteById(id);
			}
			result.setState(Result.SUCCESS);
		} catch (Exception e) {
			log.error("异常错误", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 根据id查询菜单信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/selectById.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String selectById(Integer id) {
		log.info("根据ID查询菜单信息");
		Result result = new Result();
		try {
			Menu menu = menuService.selectById(id);
			result.put("menu", menu);
			result.setState(Result.SUCCESS);
		} catch (Exception e) {
			log.error("异常错误", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 修改菜单信息
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/update.do", produces = "application/json;charset=UTF-8")
	public @ResponseBody String update(Menu menu) {
		log.info("修改菜单信息");
		Result result = new Result();
		try {
			menuService.updateById(menu);
			result.setState(Result.SUCCESS);
		} catch (DuplicateKeyException e) {
			log.info("唯一性约束条件冲突，修改失败");
			result.setState(Result.FAILURE);
			result.setMsg("菜单名称已存在，请检查");
		} catch (Exception e) {
			log.error("异常错误", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
	
	/**
	 * 修改菜单状态
	 * @param menu
	 * @return
	 */
	@RequestMapping("/updateStatus.do")
	public @ResponseBody String updateStatus(Menu menu){
		log.info("修改菜单状态");
		Result result = new Result();
		try {
			Condition condition = new Condition();
			condition.put(Condition.ID, menu.getId());
			condition.put("status", menu.getStatus());
			menuService.updateByCondition(condition);
			result.setState(Result.SUCCESS);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		return result.toJSONString();
	}
}
