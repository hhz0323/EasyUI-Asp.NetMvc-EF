using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelIDAL;
using PersonnelDALFactory;

namespace PersonnelBLL
{
    public class LoginLogManager
    {
        private static readonly ILoginLogService dal = Factory.GetInstance("LoginLogService") as ILoginLogService;
        public bool WriteLoginLog(PersonnelEntity.LoginLog entity)
        {
            return dal.WriteLoginLog(entity);
        }
    }
}
