using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 人事调动控制器
    /// </summary>
    public class ChangeController : Controller
    {
        //
        // GET: /Change/
        public ActionResult List()
        {
            return View();
        }
	}
}