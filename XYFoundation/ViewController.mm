//
//  ViewController.m
//  XYFoundation
//
//  Created by yanglishuan on 13-8-26.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#import "ViewController.h"
#include <iostream>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /** 初始化数据库 */
    char *dbName = (char *)[@"person" UTF8String];
    dbInit(dbName, &sqlite3_db);
    int rc, i, ncols;
    
    int personid;
    char *personname;
    
    char *sql = (char *)[[NSString stringWithFormat:@""] UTF8String];
    sqlite3_stmt *stmt;
    const char *tail;
    
    /** 打开数据库 */
    rc = dbOpen(dbName, &sqlite3_db);
    if (rc == SQLITE_OK) {
        printf("打开数据库成功\n");
    } else {
        fprintf(stderr, "can't open database: %s\n", sqlite3_errmsg(sqlite3_db));
    }
    
    /** 插入一条数据 */
    printf("------------------------------\n");
    printf("-- 插入一条数据 --\n");
    srand(time(0));
    char i_rand[5];
    i_rand[4] = '\0';
    for (int i = 0; i < 4; i++) {
        i_rand[i] = 'a' + rand()%26;
    }
    printf("产生的随机数据为：%s\n", i_rand);
    
    sql = "insert into student (name) values(?101)";
    
    rc = sqlite3_prepare_v2(sqlite3_db, sql, -1, &stmt, &tail);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(sqlite3_db));
    }
    sqlite3_bind_text(stmt, 101, i_rand, strlen(i_rand), SQLITE_TRANSIENT);
    rc = sqlite3_step(stmt);
    if (rc == SQLITE_DONE) {
        printf("插入数据student name %s成功\n", i_rand);
    }
    sqlite3_finalize(stmt);
    
    /** 查询全部 */
    printf("------------------------------\n");
    printf("-- 查询全部 --\n");
    sql = "select * from student;";
    
    rc = sqlite3_prepare_v2(sqlite3_db, sql, -1, &stmt, &tail);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(sqlite3_db));
    }
    
    rc = sqlite3_step(stmt);
    ncols = sqlite3_column_count(stmt);
    
    while (rc == SQLITE_ROW) {
        personid = sqlite3_column_int(stmt, 0);
        personname = (char *)sqlite3_column_text(stmt, 1);
        printf("id = %d, student name is %s\n", personid, personname);
        
        rc = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    
    /** 删除一条数据 */
    printf("------------------------------\n");
    printf("-- 删除一条数据 --\n");
    int row;
    sql = "delete from student where personid = ?101";
    rc = sqlite3_prepare_v2(sqlite3_db, sql, -1, &stmt, &tail);
    row = 5;
    int i_remove = rand()%row;
    sqlite3_bind_int(stmt, 101, i_remove);
    rc = sqlite3_step(stmt);
    if (rc == SQLITE_DONE) {
        printf("删除数据student personid = %d成功\n", i_remove);
    } else {
        fprintf(stderr, "delete error: %s\n", sqlite3_errmsg(sqlite3_db));
    }
    sqlite3_finalize(stmt);
    
    /** 查询全部 */
    printf("------------------------------\n");
    printf("-- 查询全部 --\n");
    sql = "select * from student;";
    
    rc = sqlite3_prepare_v2(sqlite3_db, sql, -1, &stmt, &tail);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(sqlite3_db));
    }
    
    rc = sqlite3_step(stmt);
    ncols = sqlite3_column_count(stmt);
    
    while (rc == SQLITE_ROW) {
        personid = sqlite3_column_int(stmt, 0);
        personname = (char *)sqlite3_column_text(stmt, 1);
        printf("id = %d, student name is %s\n", personid, personname);
        
        rc = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    
    /** 修改一条数据 */
    printf("------------------------------\n");
    printf("-- 修改一条数据 --\n");
    sql = "update student set name='updatedname' where personid=?101;";
    rc = sqlite3_prepare_v2(sqlite3_db, sql, -1, &stmt, &tail);
    sqlite3_bind_int(stmt, 101, 3);
    rc = sqlite3_step(stmt);
    if (rc == SQLITE_OK) {
        printf("修改personid = %d 成功\n", 3);
    }
    sqlite3_finalize(stmt);
    
    /** 按条件查询 */
    printf("------------------------------\n");
    printf("-- 按条件查询 --\n");
    sql = "select * from student where personid='2';";
    rc = sqlite3_prepare_v2(sqlite3_db, sql, -1, &stmt, &tail);
    if (rc != SQLITE_OK) {
        fprintf(stderr, "SQL error: %s\n", sqlite3_errmsg(sqlite3_db));
    }
    
    rc = sqlite3_step(stmt);
    ncols = sqlite3_column_count(stmt);
    
    while (rc == SQLITE_ROW) {
        personid = sqlite3_column_int(stmt, 0);
        personname = (char *)sqlite3_column_text(stmt, 1);
        printf("id = %d, student name is %s\n", personid, personname);
        
        rc = sqlite3_step(stmt);
    }
    sqlite3_finalize(stmt);
    
    /** 关闭数据库 */
    rc = dbClose(sqlite3_db);
    if (rc == SQLITE_OK) {
        printf("关闭数据库成功\n");
    } else {
        fprintf(stderr, "can't close database: %s\n", sqlite3_errmsg(sqlite3_db));
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void dbInit(char * dbName, sqlite3 **ppDb)
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *db_source_path = [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:dbName] ofType:@"db"];
    NSString *doc_path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *db_des_path = [doc_path stringByAppendingFormat:@"/%@.db", [NSString stringWithUTF8String:dbName]];
    if (![fileManager fileExistsAtPath:db_des_path]) {
        BOOL rc = [fileManager copyItemAtPath:db_source_path toPath:db_des_path error:nil];
        ;
        printf("---------------------\n数据库文件从%s复制到%s%s\n---------------------\n", [db_source_path cStringUsingEncoding:NSUTF8StringEncoding], [db_des_path cStringUsingEncoding:NSUTF8StringEncoding], rc ? "成功": "失败");
    }
    if(sqlite3_open_v2([db_des_path cStringUsingEncoding:NSUTF8StringEncoding], ppDb, SQLITE_OPEN_READWRITE, NULL) == SQLITE_OK) {
        std::cout << "数据库初始化成功！" << std::endl;
    } else {
        std::cout << "数据库初始化失败" << std::endl;
        sqlite3_close(*ppDb);
    }
    sqlite3_close(*ppDb);
}

int dbOpen(char *dbName, sqlite3 **ppDb)
{
    NSString *doc_path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *db_des_path = [doc_path stringByAppendingFormat:@"/%@.db", [NSString stringWithUTF8String:dbName]];
    return sqlite3_open_v2([db_des_path UTF8String], ppDb, SQLITE_OPEN_READWRITE, NULL);
}

int dbClose(sqlite3 *pDb)
{
    return sqlite3_close(pDb);
}

@end
