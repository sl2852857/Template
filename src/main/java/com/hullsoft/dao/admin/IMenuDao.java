package com.hullsoft.dao.admin;

import java.util.List;

import com.hullsoft.dao.IBaseDao;
import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.common.Condition;

/**
 * Description:
 * Create DateTime: 2015年11月2日 下午4:36:30
 * @author xanxus
 */
public interface IMenuDao extends IBaseDao<Menu> {

	List<Menu> selectList(Condition condition);

}
