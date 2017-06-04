using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 通知控制器
    /// </summary>
    public class InformController : Controller
    {
        //
        // GET: /Inform/
        public ActionResult List()
        {
            return View();
        }
	}
}