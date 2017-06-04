using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 培训课程控制器
    /// </summary>
    public class TrainCourseController : Controller
    {
        //
        // GET: /TrainCourse/
        public ActionResult List()
        {
            return View();
        }
	}
}