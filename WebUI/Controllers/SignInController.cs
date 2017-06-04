using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 培训人员签到控制器
    /// </summary>
    public class SignInController : Controller
    {
        //
        // GET: /SignIn/
        public ActionResult List()
        {
            return View();
        }
	}
}