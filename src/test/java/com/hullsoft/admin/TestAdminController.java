package com.hullsoft.admin;


import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.hullsoft.entity.admin.Admin;
import com.hullsoft.entity.common.Page;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.admin.IAdminService;

/**
 * Description:
 * Create DateTime: 2015年11月2日 下午3:13:55
 * @author xanxus
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/application-config.xml"})
public class TestAdminController {
	private static Logger log = LoggerFactory.getLogger(TestAdminController.class);
	
	@Resource
	private IAdminService adminService = null;
	
	@Test
	public void testAdd() {
		Admin a = new Admin();
		a.setUsername("xanxus");
		a.setPassword("xbc2852857");
		a.setRoleID(1);
		a.setIsSA(0);
		a.setEmail("2222@qq.com");
		try {
			adminService.insertAndBackID(a);
		} catch (DuplicateKeyException e) {
			log.info("唯一性约束条件冲突，添加失败");
		} catch (Exception e) {
			log.error("系统异常", e);
		}
	}
	
	@Test
	public void testDelete() {
		adminService.deleteById(1);
	}
	
	@Test
	public void testUpdatePwd() {
		Result result = new Result();
		try {
			adminService.updatePwd(2, "123", "root", result);
		} catch (Exception e) {
			log.error("系统异常", e);
			result.setError(e);
		}
		log.info(result.toJSONString());
	}
	
	@Test
	public void testUpdate() {
		Admin admin = new Admin();
		admin.setId(2);
		admin.setEmail("598134644@qq.com");
		try {
			adminService.updateById(admin);
		} catch (Exception e) {
			log.error("系统异常", e);
		}
	}
	
	@Test
	public void testDetails() {
		Admin admin = adminService.selectById(2);
		Assert.assertNotNull(admin);
		log.info("***"+JSON.toJSONString(admin));
	}
	
	@Test
	public void testList() {
		Page<Admin> page = new Page<Admin>();
		page.setSearchValue("");
		page = adminService.selectList(page);
		for(Admin a:page.getResult()){
			log.info("***"+JSON.toJSONString(a));
		}
	}
}
