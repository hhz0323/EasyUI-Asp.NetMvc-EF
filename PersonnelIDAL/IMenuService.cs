using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelEntity;

namespace PersonnelIDAL
{
    public interface IMenuService
    {
        /// <summary>
        /// 获取用户菜单
        /// </summary>
        /// <returns></returns>
        IEnumerable<Menu> GetUserMenu(int id);
    }
}
