using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 部门控制器
    /// </summary>
    public class DepartmentController : Controller
    {
        //
        // GET: /Department/
        public ActionResult List()
        {
            return View();
        }
	}
}