using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelDALFactory;
using PersonnelIDAL;
using PersonnelEntity;

namespace PersonnelBLL
{
    public class MenuManager
    {
        private static readonly IMenuService dal = Factory.GetInstance("MenuService") as IMenuService;
        /// <summary>
        /// 获取用户菜单
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public IEnumerable<Menu> GetUserMenu(int id)
        {
            return dal.GetUserMenu(id);
        }
    }
}
