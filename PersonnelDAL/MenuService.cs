using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelIDAL;
using PersonnelEntity;
using System.Collections;


namespace PersonnelDAL
{
    public class MenuService:IMenuService
    {
        PersonnelEntities db = new PersonnelEntities();
        /// <summary>
        /// 获取用户菜单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IEnumerable<Menu> GetUserMenu(int id)
        {
            var lst = db.Menu.Where(p=>p.ParentId==0).ToList();
            var s = db.User.Join(
                db.UserRole, u => u.Id, ur => ur.User.Id, (u, ur) => new { u, ur }).Where(p=>p.u.Id==id).ToList();

            var c = db.RoleMenuButton.Join(db.Menu, rmb => rmb.Menu.Id, m => m.Id, (rmb, m) => new { rmb, m }).ToList();

            var d = s.Join(c, ur => ur.ur.Role.Id, rmb => rmb.rmb.Role.Id, (ur, rmb) => new { ur, rmb }).Select(p => new Menu{
            Name=p.rmb.m.Name,
            Id=p.rmb.m.Id,
            Icon=p.rmb.m.Icon,
            ParentId=p.rmb.m.ParentId,
            Sort=p.rmb.m.Sort,
            LinkAddress=p.rmb.m.LinkAddress            
            }).Distinct(new MenuDataRowComparer()).ToList();

            var menus = lst.Union(d);

            return menus;
        }
    }

    /// <summary>
    /// 剔除菜单数据重复项
    /// </summary>
    public class MenuDataRowComparer : IEqualityComparer<Menu>
    {
        public bool Equals(Menu x, Menu y)
        {
            if (x == null)
                return y == null;
            return x.Id == y.Id;
        }
        public int GetHashCode(Menu obj)
        {
            if (obj == null)
                return 0;
            return obj.Id.GetHashCode();
        }
    }

}
