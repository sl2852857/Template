package com.hullsoft.service.admin;

import java.util.List;

import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.service.IBaseService;

/**
 * Description:
 * Create DateTime: 2015年11月2日 下午4:35:23
 * @author xanxus
 */
public interface IMenuService extends IBaseService<Menu> {
	/**
	 * 根据条件查询菜单列表
	 * @param condition
	 * @return
	 */
	public List<Menu> selectList(Condition condition);
}
