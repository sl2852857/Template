package com.hullsoft.admin;


import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.service.admin.IMenuService;

/**
 * Description:
 * Create DateTime: 2015年11月2日 下午4:48:02
 * @author xanxus
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/application-config.xml"})
public class TestMenuController {
	
	@Resource
	private IMenuService menuService = null;

	private static Logger log = LoggerFactory.getLogger(TestMenuController.class);

	@Test
	public void test() {
		Menu menu = new Menu();
		menu.setName("客户管理");
		menu.setUrl("333");
		menu.setOrderNum(3);
		Integer id;
		try {
			id = menuService.insertAndBackID(menu);
			log.info(JSON.toJSONString(menuService.selectById(id)));
		} catch (Exception e) {
			log.error("系统异常", e);
		}
	}
	
	@Test
	public void testAdd() {
		Menu menu = new Menu();
		menu.setName("用户管理");
		menu.setUrl("admin/menu/list.do");
		menu.setOrderNum(0);
		log.info("准备插入menu："+JSON.toJSONString(menu));
		int id;
		try {
			id = menuService.insertAndBackID(menu);
			log.info("刚插入的菜单："+JSON.toJSONString(menuService.selectById(id)));
		} catch (Exception e) {
			log.error("系统异常", e);
		}
	}
	
	@Test
	public void testAddSonMenu() {
		Menu menu = new Menu();
		menu.setName("部门管理");
		menu.setUrl("admin/dept/list.do");
		menu.setOrderNum(3);
		menu.setParentID(3);
//		int id = menuService.insertAndBackID(menu);
//		log.info("刚插入的菜单："+JSON.toJSONString(menuService.selectById(id)));
		Condition condition = new Condition();
		condition.put(Condition.SEARCH_VALUE, "账号");
		List<Menu> list = menuService.selectList(condition);
		log.info("*****************");
		for(Menu m:list){
			log.info(JSON.toJSONString(m));
		}
	}

	@Test
	public void testUpdate(){
		Menu m = menuService.selectById(6);
		log.info("修改前的menu："+JSON.toJSONString(m));
		m.setUrl("admin/root/list.do");
		try {
			menuService.updateById(m);
		} catch (DuplicateKeyException e) {
			log.info("唯一性约束条件冲突，修改失败");
		} catch (Exception e) {
			log.error("系统异常", e);
		}
		log.info("修改后的menu："+JSON.toJSONString(menuService.selectById(6)));
	}
	
	@Test
	public void testDelete() {
		menuService.deleteById(7);
		List<Menu> list = menuService.selectList(new Condition());
		log.info("*****************");
		for(Menu m:list){
			System.out.println(JSON.toJSON(m));
		}
	}
	
	@Test
	public void testList() {
		List<Menu> list = menuService.selectList(new Condition());
		for(Menu m:list){
			log.info("***"+JSON.toJSONString(m));
		}
	}
}
