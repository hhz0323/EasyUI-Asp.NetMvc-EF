using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 菜单控制器
    /// </summary>
    public class MenuController : Controller
    {
        //
        // GET: /Menu/
        public ActionResult List()
        {
            return View();
        }
	}
}