namespace RMW.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AuthorName : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Articles", "AuthorName", c => c.String());
        }
        
        public override void Down()
        {
            DropColumn("dbo.Articles", "AuthorName");
        }
    }
}
