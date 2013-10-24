namespace RMW.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class AddLog4net : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Log4Net",
                c => new
                    {
                        ID = c.Int(nullable: false, identity: true),
                        Date = c.DateTime(nullable: false),
                        Thread = c.String(nullable: false, maxLength: 255),
                        Level = c.String(nullable: false, maxLength: 50),
                        Logger = c.String(nullable: false, maxLength: 255),
                        Message = c.String(nullable: false),
                        Exception = c.String(),
                        Location = c.String(),
                    })
                .PrimaryKey(t => t.ID);
            Sql(@"
create proc [dbo].[up_AddLog4Net]

  @log_date DateTime
  ,@thread varchar(255)
   ,@log_level varchar(50)
   ,@logger varchar(255)
   ,@message varchar(4000)
   ,@exception varchar(2000)
  ,@location varchar(255)
 
as
  
INSERT INTO Log4Net ([Date],[Thread],[Level],[Logger],[Message],[Exception], [Location]) 
VALUES (@log_date, @thread, @log_level, @logger, @message, @exception,@location)");
            
        }
        
        public override void Down()
        {
            DropTable("dbo.Log4Net");
            Sql(@" DROP PROC up_AddLog4Net ");
        }
    }
}
