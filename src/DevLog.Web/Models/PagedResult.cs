using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DevLog.Web.Models
{
    /// <summary>
    /// Provides a way to page through results
    /// </summary>
    /// <see cref="http://weblogs.asp.net/gunnarpeipman/archive/2010/09/14/returning-paged-results-from-repositories-using-pagedresult-lt-t-gt.aspx"/>
    /// <typeparam name="T"></typeparam>
    public class PagedResult<T>
    {
        public IList<T> Results { get; set; }
        public int CurrentPage { get; set; }
        public int PageCount { get; set; }
        public int PageSize { get; set; }
        public int RowCount { get; set; }
    }
}
