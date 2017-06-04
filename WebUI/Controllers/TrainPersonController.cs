using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 培训人员控制器
    /// </summary>
    public class TrainPersonController : Controller
    {
        //
        // GET: /TrainPerson/
        public ActionResult List()
        {
            return View();
        }
	}
}