package com.hullsoft.dao.admin;

import com.hullsoft.dao.IBaseDao;
import com.hullsoft.entity.admin.Admin;
import com.hullsoft.entity.common.Condition;

public interface IAdminDao extends IBaseDao<Admin>{

	Admin login(Condition condition);
}