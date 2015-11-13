package com.hullsoft.entity.admin;

/**
 * Description:	系统使用者
 * Create DateTime: 2015年11月2日 下午1:51:58
 * @author xanxus
 */
public class Admin {
    private Integer id;
    private String username;//用户名
    private String password;//密码
    private String createTime;//创建时间
    private String lastLoginTime;//最后登录时间
    private String lastLoginIP;	//最后登录Ip地址
    private Integer roleID;		//角色ID
	private String email;	//邮箱
	private String tel;		//联系电话
	private Integer status;	//状态：0-启用/1-停用
    private Integer isSA;		//是否是超级管理员：0-不是/1-是
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getLastLoginTime() {
		return lastLoginTime;
	}

	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}

	public String getLastLoginIP() {
		return lastLoginIP;
	}

	public void setLastLoginIP(String lastLoginIP) {
		this.lastLoginIP = lastLoginIP;
	}

	public Integer getIsSA() {
		return isSA;
	}
	
	/**
	 * 0代表是一般用户，1代表是SuperAdmin超级用户
	 * @param isSA
	 */
	public void setIsSA(Integer isSA) {
		this.isSA = isSA;
	}

	public Integer getRoleID() {
		return roleID;
	}

	public void setRoleID(Integer roleID) {
		this.roleID = roleID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}
    
}