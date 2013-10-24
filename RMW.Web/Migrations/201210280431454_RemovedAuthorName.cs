namespace RMW.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class RemovedAuthorName : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.Articles", "AuthorName");
        }
        
        public override void Down()
        {
            AddColumn("dbo.Articles", "AuthorName", c => c.String());
        }
    }
}
