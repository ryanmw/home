using DevLog.Web.Helpers;
using Xunit;

namespace DevLog.Web.UnitTests.Helpers
{

    public class SiteUtilityHelperTests
    {
        [Theory]
        [InlineData("this is MY story", "this-is-my-story")]
        [InlineData("#ghyfg8ds8#", "ghyfg8ds8")]
        [InlineData("something C#", "something-c")]
        public void CreateKeyCorrectly(string input, string expected)
        {
            var result = SiteUtilityHelper.WebSafeMaker(input);

            Assert.Equal(expected, result);
        }
    }
}
