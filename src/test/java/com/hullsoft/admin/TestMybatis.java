/**
 * 
 */
package com.hullsoft.admin;



import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.hullsoft.entity.admin.Admin;
import com.hullsoft.service.admin.IAdminService;


/**
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:spring/application-config.xml"})
public class TestMybatis {
	private static Logger logger = LoggerFactory.getLogger(TestMybatis.class);
//	private ApplicationContext ac = null;
	
	@Resource
	private IAdminService adminService = null;
	/**
	 * @throws java.lang.Exception
	 */
//	@Before
//	public void setUp() throws Exception {
//		ac = new ClassPathXmlApplicationContext("spring/application-config.xml");
//		adminService = (IAdminService) ac.getBean("adminService");
//	}

	@Test
	public void test() {
		Admin admin = new Admin();
//		admin.setId(4);
		admin.setUsername("Aaron6");
		admin.setPassword("zzl6666");
		int id;
		try {
			id = adminService.insertAndBackID(admin);
			logger.info("持久化数据并返回id="+id);
			logger.info(JSON.toJSONString(adminService.selectById(id)));
		} catch (Exception e) {
			logger.error("系统异常", e);
		}
		
//		adminService.deleteById(4);
//		try {
//			adminService.insertSelective(admin);
//		} catch (Exception e) {
//		}
//		adminService.updateById(admin);
//		logger.info(JSON.toJSONString(adminService.selectById(4)));
//		Admin admin = adminService.selectAdminById(1);
//		Assert.assertNull("msg null ",admin);
//		logger.info("admin信息 :"+JSON.toJSONString(admin));
	}

	public void test2(){
		
	}
}
