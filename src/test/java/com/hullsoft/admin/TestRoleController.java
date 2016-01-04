package com.hullsoft.admin;


import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Page;
import com.hullsoft.service.admin.IRoleService;
import com.hullsoft.utils.DateUtils;


/**
 * Description:
 * Create DateTime: 2015年11月5日 下午2:26:32
 * @author xanxus
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/application-config.xml"})
public class TestRoleController {
	private Logger log = LoggerFactory.getLogger(TestRoleController.class);
	
	@Resource
	private IRoleService roleService = null;

	@Test
	public void testInsert() {
		Role role = new Role();
		role.setName("管理者");
		String now = DateUtils.now("yyyy-MM-dd HH:mm:ss");
		role.setCreateTime(now);
		role.setLastUpdateTime(now);
		role.setStatus(1);
		//int[] menuIds = {1,2};
		try {
			//roleService.insert(role, menuIds);
		} catch(DuplicateKeyException e) {
			log.info("数据插入异常，约束性条件引起");
		} catch (Exception e) {
			log.error("系统异常", e);
		}
	}

	@Test
	public void testDelete() {
		roleService.deleteById(9);
	}
	
	@Test
	public void testUpdate() {
		Role role = new Role();
		role.setId(10);
		role.setName("管理者");
		int[] menuIds = {1};
		try {
			roleService.updateById(role, menuIds);
		} catch (DuplicateKeyException e) {
			log.info("唯一性约束条件冲突，修改失败");
		} catch (Exception e) {
			log.error("系统异常", e);
		}
	}
	
	@Test
	public void testList() {
		Page<Role> page = new Page<Role>();
		page = roleService.selectList(page);
		log.info("pageCount:"+page.getPageCount());
		log.info("dataCount:"+page.getDataCount());
		for(Role r:page.getResult()){
			log.info("***"+JSON.toJSONString(r));
		}
	}
	
	@Test
	public void testDetails(){
		Role role = roleService.selectById(11);
		log.info("***"+JSON.toJSONString(role));
	}
}
