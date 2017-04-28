using Microsoft.VisualStudio.TestTools.UnitTesting;
using RMW.Web.Controllers;

namespace RMW.Web.UnitTests.Controllers
{
    [TestClass]
    public class ContactControllerTests
    {
        [TestMethod]
        public void Contact_IsRequested_IsNotNull()
        {
            // Arrange
            var controller = new ContactController();

            // Act
            var result = controller.Index();

            // Assert
            Assert.IsNotNull(result);
        }
    }
}