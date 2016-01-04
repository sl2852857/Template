package com.hullsoft.service.impl.admin;


import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hullsoft.dao.admin.IRoleDao;
import com.hullsoft.entity.admin.Menu;
import com.hullsoft.entity.admin.Role;
import com.hullsoft.entity.common.Condition;
import com.hullsoft.service.admin.IRoleService;
import com.hullsoft.service.impl.BaseServiceImpl;
import com.hullsoft.utils.DateUtils;


/**
 * Description:
 * Create DateTime: 2015年11月5日 上午11:09:19
 * @author xanxus
 */
@Service("roleService")
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {
	private static final Logger log = LoggerFactory.getLogger(RoleServiceImpl.class);
	
	@Resource
	private IRoleDao roleDao;

	@Transactional
	public Integer insertAndBackId(Role role) throws Exception{
		long startTime = System.currentTimeMillis();
		log.info("------持久化角色信息 Start------");
		Integer roleID = 0;
		try {
			//检查是否重名
			roleID = super.insertAndBackID(role); //保存角色基本信息并返回对应ID
			/*Condition condition = new Condition();
			condition.put("roleID", roleID);
			for(int menuID:menuIds){
				condition.put("menuID", menuID);
				roleDao.insertAssociation(condition);//保存关联信息
			}*/
		} catch(DuplicateKeyException e) {
			log.info("唯一性约束冲突，持久化数据失败");
			throw e;
		} catch (Exception e) {
			throw e;
		} finally {
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
			log.info("------持久化角色信息 End------");
		}
		return roleID;
	}

	@Override
	public void deleteById(Integer id) {
		long startTime = System.currentTimeMillis();
		log.info("---删除角色信息 Start------");
		//删除基本信息
		super.deleteById(id);
		//删除角色与菜单关联信息
		Condition condition = new Condition();
		condition.put("roleID", id);
		roleDao.deleteAssociation(condition);
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("---删除角色信息 End------");
	}

	@Transactional
	public void updateById(Role role, int[] menuIds) throws Exception {
		long startTime = System.currentTimeMillis();
		log.info("---修改角色信息 Start------");
		try {
			//修改角色信息
			role.setLastUpdateTime(DateUtils.now("yyyy-MM-dd HH:mm:ss"));
			roleDao.updateByPrimaryKeySelective(role);
			//修改关联关系，先删除原有关联关系
			Condition condition = new Condition();
			condition.put("roleID", role.getId());
			roleDao.deleteAssociation(condition);
			//添加新的关联关系
			for(int menuID:menuIds){
				condition.put("menuID", menuID);
				roleDao.insertAssociation(condition);
			}
		} catch (DuplicateKeyException e) {
			log.info("唯一性约束冲突，修改失败");
			throw e;
		} catch (Exception e) {
			throw e;
		} finally {
			log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
			log.info("---修改角色信息 End------");
		}
	}
	
	@Override
	public Role selectById(Integer id) {
		long startTime = System.currentTimeMillis();
		log.info("---查询角色信息 Start------");
		Role role = super.selectById(id);
		List<Menu> menuList = roleDao.selectMenuList(id);
		role.setMenuList(menuList);
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("---查询角色信息 End------");
		return role;
	}

	public Role selectByIdAndMenuIsEnable(Integer id) {
		long startTime = System.currentTimeMillis();
		log.info("---查询角色信息(菜单状态为可用) Start------");
		Role role = super.selectById(id);
		List<Menu> menuList = roleDao.selectMenuListAndMenuIsEnable(id);
		role.setMenuList(menuList);
		log.info("耗时："+(System.currentTimeMillis() - startTime) + "ms");
		log.info("---查询角色信息 End------");
		return role;
	}

	public List<Menu> selectMenuListById(Integer roleID) {
		return roleDao.selectMenuList(roleID);
	}
}
