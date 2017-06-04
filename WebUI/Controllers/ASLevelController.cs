using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 行政级别控制器
    /// </summary>
    public class ASLevelController : Controller
    {
        //
        // GET: /ASLevel/
        public ActionResult List()
        {
            return View();
        }
	}
}