package com.hullsoft.dao.admin;

import java.util.List;

import com.hullsoft.dao.IBaseDao;
import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Condition;

/**
 * Description:
 * Create DateTime: 2015年11月5日 上午11:07:15
 * @author xanxus
 */
public interface IRoleDao extends IBaseDao<Role> {

	/**
	 * 持久化角色与菜单关联数据
	 * @param condition 
	 */
	void insertAssociation(Condition condition);

	/**
	 * 删除角色与菜单关联数据
	 * @param condition
	 */
	void deleteAssociation(Condition condition);

	/**
	 * 查询与角色关联的菜单
	 * @param id
	 * @return
	 */
	List<Menu> selectMenuList(Integer id);

	/**
	 * 查询与角色关联的菜单(菜单状态为可用)
	 * @param id
	 * @return
	 */
	List<Menu> selectMenuListAndMenuIsEnable(Integer id);

}
