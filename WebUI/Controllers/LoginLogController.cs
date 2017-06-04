using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 登录日志控制器
    /// </summary>
    public class LoginLogController : Controller
    {
        //
        // GET: /LoginLog/
        public ActionResult List()
        {
            return View();
        }
	}
}