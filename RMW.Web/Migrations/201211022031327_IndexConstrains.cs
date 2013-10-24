namespace RMW.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class IndexConstrains : DbMigration
    {
        public override void Up()
        {
            Sql(@"
CREATE UNIQUE INDEX IX_Article_Key ON dbo.Articles([key]);
CREATE UNIQUE INDEX IX_Article_Title ON dbo.Articles([Title]);");
        }
        
        public override void Down()
        {
            Sql(@"
DROP INDEX IX_Article_Key ON dbo.Articles;
DROP INDEX IX_Article_Title ON dbo.Articles;");
        }
    }
}
