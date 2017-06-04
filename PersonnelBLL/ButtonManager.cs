using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelIDAL;
using PersonnelEntity;
using PersonnelDALFactory;

namespace PersonnelBLL
{
    public class ButtonManager
    {
        public static readonly IButtonService dal = Factory.GetInstance("ButtonService") as IButtonService;


        public IEnumerable<Button> GetButtonByMenuCodeAndUserId(string menuCode, string userId) 
        {
            return dal.GetButtonByMenuCodeAndUserId(menuCode,userId);
        }
    }
}
