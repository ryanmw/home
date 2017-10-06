using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using System;
using System.Collections.Generic;

namespace DevLog.Data.Migrations
{
    public partial class UseBasePropertiesForDates : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Comments_Articles_ArticleId",
                table: "Comments");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Comments",
                table: "Comments");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Articles",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "Id",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "CreatedOn",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "UpdatedOn",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "Id",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "CreatedOn",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "UpdatedOn",
                table: "Articles");

            migrationBuilder.AddColumn<int>(
                name: "CommentId",
                table: "Comments",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreateDate",
                table: "Comments",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdateDate",
                table: "Comments",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "ArticleId",
                table: "Articles",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreateDate",
                table: "Articles",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "PublishedOn",
                table: "Articles",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdateDate",
                table: "Articles",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Comments",
                table: "Comments",
                column: "CommentId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Articles",
                table: "Articles",
                column: "ArticleId");

            migrationBuilder.CreateIndex(
                name: "IX_Articles_Key",
                table: "Articles",
                column: "Key",
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Comments_Articles_ArticleId",
                table: "Comments",
                column: "ArticleId",
                principalTable: "Articles",
                principalColumn: "ArticleId",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Comments_Articles_ArticleId",
                table: "Comments");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Comments",
                table: "Comments");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Articles",
                table: "Articles");

            migrationBuilder.DropIndex(
                name: "IX_Articles_Key",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "CommentId",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "CreateDate",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "UpdateDate",
                table: "Comments");

            migrationBuilder.DropColumn(
                name: "ArticleId",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "CreateDate",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "PublishedOn",
                table: "Articles");

            migrationBuilder.DropColumn(
                name: "UpdateDate",
                table: "Articles");

            migrationBuilder.AddColumn<int>(
                name: "Id",
                table: "Comments",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedOn",
                table: "Comments",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdatedOn",
                table: "Comments",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Id",
                table: "Articles",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            migrationBuilder.AddColumn<DateTime>(
                name: "CreatedOn",
                table: "Articles",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<DateTime>(
                name: "UpdatedOn",
                table: "Articles",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_Comments",
                table: "Comments",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Articles",
                table: "Articles",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Comments_Articles_ArticleId",
                table: "Comments",
                column: "ArticleId",
                principalTable: "Articles",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
