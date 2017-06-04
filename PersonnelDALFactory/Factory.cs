using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using System.Reflection;
using PersonnelIDAL;
namespace PersonnelDALFactory
{
    public class Factory
    {
        public static object GetInstance(string name)
        {
            string configName = System.Configuration.ConfigurationManager.AppSettings["DataAccess"];
            if (string.IsNullOrEmpty(configName))
            {
                //log.Fatal("没有从配置文件中获取命名空间名称！");   //Fatal致命错误，优先级最高
                throw new InvalidOperationException();    //抛错，代码不会向下执行了
            }
            string className = string.Format("{0}.{1}", configName, name);  //ZGZY.SQLServerDAL.传入的类名name

            //加载程序集
            System.Reflection.Assembly assembly = System.Reflection.Assembly.Load(configName);
            //创建指定类型的对象实例
            return assembly.CreateInstance(className);
        }
    }
}
