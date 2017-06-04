using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelEntity;

namespace PersonnelIDAL
{
    public interface IButtonService
    {
        IEnumerable<Button> GetButtonByMenuCodeAndUserId(string menuCode,string userId);
    }
}
