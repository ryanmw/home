using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using NUnit.Framework;
using RMW;
using RMW.Controllers;

namespace RMW.Tests.Controllers
{
    [TestFixture]
    public class ArticlesControllerTest
    {
        [Test]
        public void Index()
        {
            // Arrange
            ArticlesController controller = new ArticlesController();

            // Act
            ViewResult result = controller.Index() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }
      
    }
}
