using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using PersonnelIDAL;
using PersonnelEntity;

namespace PersonnelDAL
{
    class ButtonService:IButtonService
    {
        PersonnelEntities db = new PersonnelEntities();
        public IEnumerable<Button> GetButtonByMenuCodeAndUserId(string menuCode,string userId)
        {
            int id = Convert.ToInt32(userId);
            var s = db.User.Join(db.UserRole, u => u.Id, ur => ur.User.Id, (u, ur) => new { u, ur }).Where(p => p.u.Id.Equals(id)).Join(
               db.RoleMenuButton, uur => uur.ur.Role.Id, rmb => rmb.Role.Id, (ur, rmb) => new { ur, rmb }).Join(
               db.Menu, uurrmb => uurrmb.rmb.Menu.Id, m => m.Id, (uurrmb, m) => new { uurrmb, m }).Where(p => p.m.Code.Equals(menuCode)).Join(
               db.Button, uurrmbb => uurrmbb.uurrmb.rmb.Button.Id, b => b.Id, (uurrmbb, b) => new { uurrmbb, b }).ToList();


            var lst = db.User.Join(db.UserRole, u => u.Id, ur => ur.User.Id, (u, ur) => new { u, ur }).Where(p => p.u.Id.Equals(id)).Join(
               db.RoleMenuButton, uur => uur.ur.Role.Id, rmb => rmb.Role.Id, (ur, rmb) => new { ur, rmb }).Join(
               db.Menu, uurrmb => uurrmb.rmb.Menu.Id, m => m.Id, (uurrmb, m) => new { uurrmb, m }).Where(p => p.m.Code.Equals(menuCode)).Join(
               db.Button, uurrmbb => uurrmbb.uurrmb.rmb.Button.Id, b => b.Id, (uurrmbb, b) => new { uurrmbb, b }).Select(p => new Button 
                {
                    Id=p.b.Id,
                    Code=p.b.Code,
                    Name=p.b.Name,
                    Icon=p.b.Icon,
                    Sort=p.b.Sort
                
                }).OrderBy(o=>o.Sort);

            return lst;
        }
    }
}
