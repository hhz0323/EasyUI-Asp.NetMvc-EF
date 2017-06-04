using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelIDAL;
using PersonnelEntity;

namespace PersonnelDAL
{
    public class LoginLogService : ILoginLogService
    {
        PersonnelEntities db = new PersonnelEntities();
        /// <summary>
        /// 记录用户登录日志
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public bool WriteLoginLog(PersonnelEntity.LoginLog entity)
        {
            bool b = true;
            try
            {
                db.LoginLog.Add(entity);
                db.SaveChanges();
            }
            catch { b = false; }
            return b;
        }
    }
}
