using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using RMW.Web.Controllers;

namespace RMW.Web.UnitTests.Controllers
{
    [TestClass]
    public class ResumeControllerTests
    {
        [TestMethod]
        public void Resume_IsRequested_IsNotNull()
        {
            // Arrange
            var controller = new ResumeController();

            // Act
            var result = controller.Index() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }
    }
}