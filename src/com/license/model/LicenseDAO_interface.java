package com.license.model;

import java.util.List;

public interface LicenseDAO_interface {
	public void insert(LicenseVO licenseVO);
	public void update(LicenseVO licenseVO);
	public void delete(String licNo);
	public LicenseVO findByPrimaryKey(String licNo);
	public List<LicenseVO> getAll();
}
