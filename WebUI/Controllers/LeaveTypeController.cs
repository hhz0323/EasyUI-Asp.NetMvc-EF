using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebUI.Controllers
{
    /// <summary>
    /// 请假类型控制器
    /// </summary>
    public class LeaveTypeController : Controller
    {
        //
        // GET: /LeaveType/
        public ActionResult List()
        {
            return View();
        }
	}
}