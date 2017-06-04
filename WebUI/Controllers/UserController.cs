using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using PersonnelBLL;
using PersonnelEntity;

namespace WebUI.Controllers
{
    /// <summary>
    /// 用户控制器
    /// </summary>
    public class UserController : Controller
    {
        ButtonManager bll = new ButtonManager();
        //
        // GET: /User/
        public ActionResult List()
        {
            List<Button> lst = bll.GetButtonByMenuCodeAndUserId("user", "2") as List<Button>;
            return View();
        }
	}
}