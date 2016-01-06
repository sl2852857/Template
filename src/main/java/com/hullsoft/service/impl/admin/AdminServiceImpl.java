/**
 * 
 */
package com.hullsoft.service.impl.admin;



import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.hullsoft.dao.admin.IAdminDao;
import com.hullsoft.dao.admin.IRoleDao;
import com.hullsoft.entity.admin.Admin;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.admin.IAdminService;
import com.hullsoft.service.impl.BaseServiceImpl;
import com.hullsoft.utils.DateUtils;
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
	
	@Resource
	private IRoleDao roleDao;

	public void login(String username, String password, HttpServletRequest request, Result result) {
		log.info("------登录验证 Start------");
		long startTime = System.currentTimeMillis();
		HttpSession session = request.getSession();
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
				if(admin.getRoleID() != null) {
					//不是系统超级管理员，判断该账号的角色是否正常启用
					Role role = roleDao.selectByPrimaryKey(admin.getRoleID());
					if(role.getStatus() == 0) {
						//角色正常使用
						String lastLoginIP = request.getRemoteAddr();
						if("0:0:0:0:0:0:0:1".equals(lastLoginIP)) {
							lastLoginIP = "127.0.0.1";
						}
						String lastLoginTime = DateUtils.now("yyyy-MM-dd HH:mm:ss");
						log.info("用户 ["+admin.getUsername()+"]登陆成功，进入系统，IP为"+lastLoginIP);
						//更新用户登录时间与登录IP
						Admin temp = new Admin();
						temp.setId(admin.getId());
						temp.setLastLoginIP(lastLoginIP);
						temp.setLastLoginTime(lastLoginTime);
						adminDao.updateByPrimaryKeySelective(temp);
						//设置success信息，将用户信息存入session中
						result.setState(Result.SUCCESS);
						session.setAttribute("loginAdmin", admin);
					}else if(role.getStatus() == 1) {
						//角色已被停用
						log.info("用户 ["+admin.getUsername()+"]所属角色已被管理员停用");
						result.setState(Result.FAILURE);
						result.setMsg("您的用户角色已被管理员停用，请联系管理员");
					}
				}else {
					String lastLoginIP = request.getRemoteAddr();
					if("0:0:0:0:0:0:0:1".equals(lastLoginIP)) {
						lastLoginIP = "127.0.0.1";
					}
					String lastLoginTime = DateUtils.now("yyyy-MM-dd HH:mm:ss");
					log.info("用户 ["+admin.getUsername()+"]登陆成功，进入系统，IP为"+lastLoginIP);
					//更新用户登录时间与登录IP
					Admin temp = new Admin();
					temp.setId(admin.getId());
					temp.setLastLoginIP(lastLoginIP);
					temp.setLastLoginTime(lastLoginTime);
					adminDao.updateByPrimaryKeySelective(temp);
					//设置success信息，将用户信息存入session中
					result.setState(Result.SUCCESS);
					session.setAttribute("loginAdmin", admin);
				}
			}else if(admin.getStatus()==1) {
				//status=1表示账号转改为封停
				result.setState(Result.FAILURE);
				result.setMsg("您的账号已被管理员停用");
				log.info("用户 ["+admin.getUsername()+"]账号已被管理员停用");
			}else{
				log.info("用户["+JSON.toJSONString(admin)+"]状态异常！");
				result.setState(Result.FAILURE);
				result.setMsg("该账号存在状态异常[status="+admin.getStatus()+"]，请联系管理员");
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
			t.setCreateTime(DateUtils.now("yyyy-MM-dd HH:mm:ss"));
			t.setIsSA(0);
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
