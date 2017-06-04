using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using PersonnelBLL;
using PersonnelEntity;
using System.Web.Security;
using System.Web.Script.Serialization;


namespace WebUI.Controllers
{
    public class LoginController : Controller
    {
        PersonnelBLL.UserManager bll = new UserManager();
        //
        // GET: /Login/
        public ActionResult Login()
        {
            return View();
        }
        /// <summary>
        /// 检查用户登录
        /// </summary>
        /// <returns></returns>
        public JsonResult CheckUserLogin(User entity,string city) 
        {
            LoginLog loginLog = new LoginLog();
            loginLog.UserName = entity.UserName;
            loginLog.UserIp = HttpContext.Request.UserHostAddress;
            loginLog.City = city == null ? "未知" : city;
            loginLog.LoginDate = DateTime.Now;

            PersonnelEntity.User currentUser = bll.UserLogin(entity.UserName);
            if (currentUser == null)
            {
                loginLog.IfSuccess = false;
                new LoginLogManager().WriteLoginLog(loginLog);
                return Json(new { result = "error", content = "用户名不存在,请重新输入!" });                
            }
            else if (currentUser.UserPwd != PersonnelCommon.Md5.GetMD5String(entity.UserPwd))
            {
                loginLog.IfSuccess = false;
                new LoginLogManager().WriteLoginLog(loginLog);
                loginLog.IfSuccess = false;
                return Json(new { result = "error", content = "你输入的密码不正确,请您检查!" });
            }
            else
            {
                if (currentUser.IsAble)
                {
                    loginLog.IfSuccess = true;
                    new LoginLogManager().WriteLoginLog(loginLog);
                    Session["username"] = currentUser.UserName;
                    Session["userid"] = currentUser.Id;
                    return Json(new { result = "success", content = "" });
                }
                else
                {
                    loginLog.IfSuccess = false;
                    new LoginLogManager().WriteLoginLog(loginLog);
                    return Json(new { result = "error", content = "用户被禁用" });
                } 
                
            }
        }
	}
}