using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 工作经历控制器
    /// </summary>
    public class WorkExperienceController : Controller
    {
        //
        // GET: /WorkExperience/
        public ActionResult List()
        {
            return View();
        }
	}
}