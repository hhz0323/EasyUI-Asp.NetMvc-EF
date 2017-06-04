using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 按键控制器
    /// </summary>
    public class ButtonController : Controller
    {
        //
        // GET: /Button/
        public ActionResult List()
        {
            return View();
        }
	}
}