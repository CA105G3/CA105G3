package Android.menu.model;

import java.util.List;

public interface MenuListDAO_interface {
	public void insert(MenuListVO menuListVO);
	public void update(MenuListVO menuListVO);
	public void delete(String menuListNo);
	public MenuListVO findByPrimaryKey(String menuListNo);
	public List<MenuListVO> getAll();
	public List<MenuListVO> getAllByMenuNo(String menuNo);
}
