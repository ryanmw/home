namespace RMW.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Articles",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Key = c.String(nullable: false, maxLength: 75),
                        CreatedOn = c.DateTime(nullable: false),
                        UpdatedOn = c.DateTime(),
                        Title = c.String(nullable: false, maxLength: 75),
                        MetaDescription = c.String(nullable: false, maxLength: 250),
                        Body = c.String(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Comments",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        AuthorPhoto = c.String(),
                        CreatedOn = c.DateTime(nullable: false),
                        UpdatedOn = c.DateTime(),
                        Author = c.String(nullable: false, maxLength: 50),
                        Body = c.String(nullable: false),
                        Email = c.String(nullable: false, maxLength: 75),
                        IPAddress = c.String(nullable: false, maxLength: 50),
                        Url = c.String(maxLength: 150),
                        ArticleId = c.Int(nullable: false),
                        IsEmailSubscribed = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id)
                .ForeignKey("dbo.Articles", t => t.ArticleId, cascadeDelete: true)
                .Index(t => t.ArticleId);
            
        }
        
        public override void Down()
        {
            DropIndex("dbo.Comments", new[] { "ArticleId" });
            DropForeignKey("dbo.Comments", "ArticleId", "dbo.Articles");
            DropTable("dbo.Comments");
            DropTable("dbo.Articles");
        }
    }
}
