using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelEntity;
using PersonnelIDAL;

namespace PersonnelDAL
{
    public class UserService:IUserService
    {
        PersonnelEntities db = new PersonnelEntities();
        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public PersonnelEntity.User UserLogin(string userName)
        {
            var user = db.User.Where(p => p.UserName == userName).FirstOrDefault();

            return user;
        }
    }
}
