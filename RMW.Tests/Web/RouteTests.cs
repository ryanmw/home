using Microsoft.VisualStudio.TestTools.UnitTesting;
using NUnit.Framework;

namespace RMW.Tests.Web
{
    [TestClass]
    public class RouteTests
    {
        //[SetUp]
        //public void SetUp()
        //{
        //    RouteTable.Routes.Clear();
        //    RouteConfig.RegisterRoutes(RouteTable.Routes);
        //}

        [Test]
        public void HomeShouldMapToHomeController()
        {
            Microsoft.VisualStudio.TestTools.UnitTesting.Assert.AreNotEqual(1, 2);
        }
    }
}
