using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 用户操作日志控制器
    /// </summary>
    public class UserOperateLogController : Controller
    {
        //
        // GET: /UserOperateLog/
        public ActionResult List()
        {
            return View();
        }
	}
}