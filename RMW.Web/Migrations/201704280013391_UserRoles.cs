namespace RMW.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UserRoles : DbMigration
    {
        public override void Up()
        {
            RenameTable(name: "dbo.RoleUsers", newName: "UserRoles");
            DropIndex("dbo.RoleUsers", new[] { "User_Id" });
            DropPrimaryKey("dbo.UserRoles");
            AddPrimaryKey("dbo.UserRoles", new[] { "User_Id", "Role_RoleId" });
        }
        
        public override void Down()
        {
            DropIndex("dbo.UserRoles", new[] { "User_Id" });
            DropPrimaryKey("dbo.UserRoles");
            AddPrimaryKey("dbo.UserRoles", new[] { "Role_RoleId", "User_Id" });
            RenameTable(name: "dbo.UserRoles", newName: "RoleUsers");
        }
    }
}
