using System.Collections.Specialized;
using System.Web;
using System.Web.Mvc;
using FakeItEasy;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using RMW.Repository;
using RMW.Web.Controllers;

namespace RMW.Web.UnitTests.Controllers
{
    [TestClass]
    public class HomeControllerTest
    {
        [TestMethod]
        public void Index_IsRequested_IsNotNull()
        {
            // Arrange
            var mockHttpContext = new Mock<HttpContextBase>();
            mockHttpContext.Setup(x => x.Request.QueryString).Returns(new NameValueCollection());
            var articles = new Fake<IArticleRepository>();
            var comments = new Fake<ICommentRepository>();
            var controller = new ArticlesController(
                articles.FakedObject, comments.FakedObject, mockHttpContext.Object);

            A.CallTo(() => controller._articleRepository.GetsArticles(A<int>.Ignored, A<int>.Ignored)).Returns(null);

            // Act
            var result = controller.Index();

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Index_IsRequested_ReturnsViewResult()
        {
            // Arrange
            var mockHttpContext = new Mock<HttpContextBase>();
            mockHttpContext.Setup(x => x.Request.QueryString).Returns(new NameValueCollection());
            var articles = new Fake<IArticleRepository>();
            var comments = new Fake<ICommentRepository>();
            var controller = new ArticlesController(
                articles.FakedObject, comments.FakedObject, mockHttpContext.Object);
            A.CallTo(() => controller._articleRepository.GetsArticles(A<int>.Ignored, A<int>.Ignored)).Returns(null);

            // Act
            var result = controller.Index();

            // Assert
            Assert.IsInstanceOfType(result, typeof(ViewResult));
        }

        [TestMethod]
        public void About_IsRequested_IsNotNull()
        {
            // Arrange
            var controller = new HomeController();

            // Act
            var result = controller.About() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Contact_IsRequested_IsNotNull()
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