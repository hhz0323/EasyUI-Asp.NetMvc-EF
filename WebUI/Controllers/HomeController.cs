using PersonnelEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using PersonnelBLL;
using PersonnelEntity;

namespace WebUI.Controllers
{
    public class HomeController : Controller
    {
        MenuManager bll = new MenuManager();
        //
        // GET: /Home/
        public ActionResult Index()
        {
            if (Session["username"]==null)
            {
                return new RedirectResult("Login/Login");
            }
            return View();
        }
        public JsonResult GetUserMenu()
        {
            int userId = Session["userid"] == null ? 0 : Convert.ToInt32(Session["userid"].ToString());
            IEnumerable<Menu> lst = bll.GetUserMenu(userId);

            return Json(lst,JsonRequestBehavior.AllowGet);
        }
	}
}