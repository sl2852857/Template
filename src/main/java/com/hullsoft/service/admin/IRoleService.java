package com.hullsoft.service.admin;

import com.hullsoft.entity.admin.Role;
import com.hullsoft.service.IBaseService;

/**
 * Description:角色 service
 * Create DateTime: 2015年11月5日 上午11:05:31
 * @author xanxus
 */
public interface IRoleService extends IBaseService<Role> {

	/**
	 * 持久化角色信息和角色与菜单对应关系
	 * @param role
	 * @param menuIds
	 * @throws Exception 
	 */
	void insert(Role role, int[] menuIds) throws Exception;

	void updateById(Role role, int[] menuIds) throws Exception;
	
}
