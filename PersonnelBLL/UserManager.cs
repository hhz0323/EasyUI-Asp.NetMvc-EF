using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelIDAL;
using PersonnelDALFactory;

namespace PersonnelBLL
{
    public class UserManager
    {
        private static readonly IUserService dal = Factory.GetInstance("UserService") as IUserService;

        public PersonnelEntity.User UserLogin(string userName)
        {
            return dal.UserLogin(userName);
        }
    }
}
