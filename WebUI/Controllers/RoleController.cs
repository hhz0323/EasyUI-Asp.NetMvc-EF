using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 角色控制器
    /// </summary>
    public class RoleController : Controller
    {
        //
        // GET: /Role/
        public ActionResult List()
        {
            return View();
        }
	}
}