// <auto-generated />
namespace RMW.Migrations
{
    using System.Data.Entity.Migrations;
    using System.Data.Entity.Migrations.Infrastructure;
    using System.Resources;
    
    public sealed partial class AuthorName : IMigrationMetadata
    {
        private readonly ResourceManager Resources = new ResourceManager(typeof(AuthorName));
        
        string IMigrationMetadata.Id
        {
            get { return "201210280240105_AuthorName"; }
        }
        
        string IMigrationMetadata.Source
        {
            get { return null; }
        }
        
        string IMigrationMetadata.Target
        {
            get { return Resources.GetString("Target"); }
        }
    }
}