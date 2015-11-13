/**
 * 
 */
package com.hullsoft.service.admin;

import javax.servlet.http.HttpSession;

import com.hullsoft.entity.admin.Admin;
import com.hullsoft.entity.common.Result;
import com.hullsoft.service.IBaseService;

/**
 * @author Administrator
 * AdminService
 *
 */
public interface IAdminService extends IBaseService<Admin>{
	
	/**
	 * 用户登录验证
	 * @param username 用户名
	 * @param password 密码
	 * @param session 验证通过后存放用户信息
	 * @param result 设置结果
	 * @return
	 */
	void login(String username, String password, HttpSession session, Result result);

	/**
	 * 修改密码
	 * @param id
	 * @param oldPwd
	 * @param newPwd
	 * @param result
	 */
	void updatePwd(Integer id, String oldPwd, String newPwd, Result result);
}
