using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelEntity;

namespace PersonnelIDAL
{
    public interface IUserService
    {
        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="loginPwd"></param>
        /// <returns></returns>
        User UserLogin(string userName);

    }
}
