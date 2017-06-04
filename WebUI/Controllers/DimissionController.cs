using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 人员离职控制器
    /// </summary>
    public class DimissionController : Controller
    {
        //
        // GET: /Dimission/
        public ActionResult List()
        {
            return View();
        }
	}
}