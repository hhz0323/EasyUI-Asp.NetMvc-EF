using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 合同管理控制器
    /// </summary>
    public class CompactController : Controller
    {
        //
        // GET: /Compact/
        public ActionResult List()
        {
            return View();
        }
	}
}