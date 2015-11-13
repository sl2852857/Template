/**
 * 
 */
package com.hullsoft.service.impl.admin;



import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.hullsoft.dao.admin.IAdminDao;
import com.hullsoft.entity.admin.Admin;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.admin.IAdminService;
import com.hullsoft.service.impl.BaseServiceImpl;
import com.hullsoft.utils.MD5Utils;

/**
 * @author Administrator
 *
 */

@Service("adminService")
public class AdminServiceImpl extends BaseServiceImpl<Admin> implements IAdminService {
	private static final Logger log = LoggerFactory.getLogger(AdminServiceImpl.class);
	@Resource
	private IAdminDao adminDao;

	public void login(String username, String password, HttpSession session, Result result) {
		log.info("------登录验证 Start------");
		long startTime = System.currentTimeMillis();
		Condition condition = new Condition();
		condition.put("username", username);
		condition.put("password", MD5Utils.MD5(password));
		Admin admin = this.adminDao.login(condition);
		if(admin==null) {
			//数据库验证未通过
			log.info("用户["+username+"]登录失败：用户名或密码错误");
			result.setState(Result.FAILURE);
			result.setMsg("用户名或密码错误");
		}else {
			if(admin.getStatus()==0) {
				//status=0表示账号状态为启用
				result.setState(Result.SUCCESS);
				session.setAttribute("loginAdmin", admin);
			}else if(admin.getStatus()==1) {
				//status=1表示账号转改为封停
				result.setState(Result.FAILURE);
				result.setMsg("该账号已被管理员封停");
			}else{
				log.info("用户["+JSON.toJSONString(admin)+"]状态异常！");
				result.setState(Result.FAILURE);
				result.setMsg("该账号状态异常，请联系管理员");
			}
		}
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("------登录验证 End------");
	}
	
	@Override
	@Transactional
	public void insert(Admin t) throws Exception {
		log.info("------添加用户 Start------");
		long startTime = System.currentTimeMillis();
		try {
			//密码MD5加密
			t.setPassword(MD5Utils.MD5(t.getPassword()));
			log.info("添加对象："+JSON.toJSONString(t));
			adminDao.insert(t);
		} catch (Exception e) {
			throw e;
		} finally {
			log.info("------添加用户 End------");
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		}
	}
	
	@Override
	@Transactional
	public Integer insertAndBackID(Admin t) throws Exception {
		log.info("------添加用户(返回对象ID) Start------");
		long startTime = System.currentTimeMillis();
		try {
			t.setPassword(MD5Utils.MD5(t.getPassword()));
			log.info("添加对象："+JSON.toJSONString(t));
			this.adminDao.insert(t);
			Integer id = this.adminDao.selectLastInsertId();
			log.info("返回对象ID："+id);
			return id;
		} catch (Exception e) {
			throw e;
		} finally {
			log.info("------添加用户(返回对象ID) End------");
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		}
	}

	public void updatePwd(Integer id, String oldPwd, String newPwd, Result result) {
		log.info("------修改用户密码 Start------");
		long startTime = System.currentTimeMillis();
		//验证旧密码
		Condition condition = new Condition();
		condition.put("id", id);
		condition.put("password", MD5Utils.MD5(oldPwd));
		Admin a = this.adminDao.selectByCondition(condition);
		if(a==null){
			//原密码不正确
			result.setState(Result.FAILURE);
			result.setMsg("原密码不正确");
		}else{
			//原密码验证通过
			a.setPassword(MD5Utils.MD5(newPwd));
			this.adminDao.updateByPrimaryKeySelective(a);
			result.setState(Result.SUCCESS);
		}
		log.info("------修改用户密码 End------");
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
	}
	
	@Override
	public void updateById(Admin t) throws Exception {
		log.info("------修改用户信息 Start------");
		long startTime = System.currentTimeMillis();
		//不允许有用户名，密码修改
		t.setUsername(null);
		t.setPassword(null);
		this.adminDao.updateByPrimaryKeySelective(t);
		log.info("------修改用户信息 End------");
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
	}
}
