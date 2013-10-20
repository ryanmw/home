using Microsoft.VisualStudio.TestTools.UnitTesting;
using RMW.Controllers;
using System.Web.Mvc;

namespace RMW.Tests.Controllers
{
    [TestClass]
    public class HomeControllerTest
    {
        [Ignore]// TODO: MOCK HTTPCONTEXT FOR ARTICLES
        [TestMethod]
        public void Index()
        {
            // Arrange
            var controller = new ArticlesController();

            // Act
            var result = controller.Index() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void About()
        {
            // Arrange
            var controller = new HomeController();

            // Act
            var result = controller.About() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }


        [TestMethod]
        public void Contact()
        {
            // Arrange
            var controller = new HomeController();

            // Act
            var result = controller.Contact();

            // Assert
            Assert.IsNotNull(result);
        }
    }
}
