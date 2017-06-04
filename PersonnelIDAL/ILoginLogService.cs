using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelEntity;
namespace PersonnelIDAL
{
    /// <summary>
    /// 写入用户登录日志
    /// </summary>
    public interface ILoginLogService
    {
        bool WriteLoginLog(LoginLog entity);
    }
}
