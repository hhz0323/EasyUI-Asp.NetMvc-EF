using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 制定培训计划控制器
    /// </summary>
    public class TrainPlanController : Controller
    {
        //
        // GET: /TrainPlan/
        public ActionResult List()
        {
            return View();
        }
	}
}