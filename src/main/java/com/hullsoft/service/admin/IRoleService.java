package com.hullsoft.service.admin;

import java.util.List;

import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Result;
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
	Integer insertAndBackId(Role role) throws Exception;

	/**
	 * 修改角色与菜单关联关系
	 * @param role
	 * @param menuIds
	 * @throws Exception
	 */
	void updateById(Role role, int[] menuIds) throws Exception;
	
	/**
	 * 查询角色对应的菜单集（菜单状态为可用状态）
	 * @param id
	 * @return
	 */
	Role selectByIdAndMenuIsEnable(Integer id);

	/**
	 * 根据角色id查询其对应菜单集合
	 * @param roleID
	 * @return
	 */
	List<Menu> selectMenuListById(Integer roleID);
	
	/**
	 * 删除角色，并删除其角色权限关系，前提得验证是否有用户使用该角色
	 * @param id
	 * @param result
	 */
	void deleteById(Integer id, Result result) throws Exception;
}
