package com.hullsoft.entity.admin;

import java.util.ArrayList;
import java.util.List;

/**
 * Description: 角色
 * Create DateTime: 2015年11月2日 下午1:57:02
 * @author xanxus
 */
public class Role {
	private Integer id;
	private String name;			//角色名
	private List<Menu> menuList;	//角色拥有的菜单
	private String createTime;		//创建时间
	private String lastUpdateTime;	//最后修改时间
	private Integer status;			//状态：0-启用，1-停用
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public List<Menu> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}
	public String getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(String lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	
	/**
	 * 初始超级管理员
	 */
	public static Role getSaRole() {
		Role role = new Role();
		role.setName("系统管理员");
		role.setMenuList(initMenu());
		return role;
	}
	
	/**
	 * 初始化超级管理员菜单
	 * @return
	 */
	private static List<Menu> initMenu() {
		List<Menu> list = new ArrayList<Menu>();
		
		Menu menuManage = new Menu(1, "系统菜单", "", 0);
		List<Menu> menuManageSonList = new ArrayList<Menu>();
		menuManageSonList.add(new Menu(4, "系统菜单管理", "admin/menu/list.do", 1));
//		menuManageSonList.add(new Menu(5, "系统菜单添加", "admin/menu/toAdd.do", 1));
		menuManage.setMenuList(menuManageSonList);
		
		Menu roleManage = new Menu(2, "系统角色", "", 0);
		List<Menu> roleManageSonList = new ArrayList<Menu>();
		roleManageSonList.add(new Menu(6, "系统角色管理", "admin/role/list.do", 2));
		roleManageSonList.add(new Menu(7, "系统角色添加", "admin/role/toAdd.do", 2));
		roleManage.setMenuList(roleManageSonList);
		
		Menu adminManage = new Menu(3, "系统用户", "", 0);
		List<Menu> adminManageSonList = new ArrayList<Menu>();
		adminManageSonList.add(new Menu(8, "系统用户管理", "admin/list.do", 2));
		adminManageSonList.add(new Menu(9, "系统用户添加", "admin/toAdd.do", 2));
		adminManage.setMenuList(adminManageSonList);
		
		list.add(menuManage);
		list.add(roleManage);
		list.add(adminManage);
		return list;
	}
	
	
}
