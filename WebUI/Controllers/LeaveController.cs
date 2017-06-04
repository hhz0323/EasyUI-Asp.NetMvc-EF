using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 请假控制器
    /// </summary>
    public class LeaveController : Controller
    {
        //
        // GET: /Leave/
        public ActionResult List()
        {
            return View();
        }
	}
}