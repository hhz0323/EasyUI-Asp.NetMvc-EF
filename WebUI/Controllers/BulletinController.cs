using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 公告控制器
    /// </summary>
    public class BulletinController : Controller
    {
        //
        // GET: /Bulletin/

        public ActionResult List()
        {
            return View();
        }
	}
}