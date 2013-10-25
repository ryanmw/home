using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using RMW.Web.Controllers;

namespace RMW.Web.UnitTests.Controllers
{
    [TestClass]
    public class ArticlesControllerTest
    {
        [Ignore]
        [TestMethod]
        public void Index()
        {
            // Arrange
            var controller = new ArticlesController();

            // Act
            var result = controller.Index() as ActionResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [Ignore]
        [TestMethod]
        public void Admin()
        {
            // Arrange
            var controller = new ArticlesController();

            // Act
            var result = controller.Admin();

            // Assert
            Assert.IsNotNull(result);
        }
    }
}
