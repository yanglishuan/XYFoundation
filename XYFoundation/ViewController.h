//
//  ViewController.h
//  XYFoundation
//
//  Created by yanglishuan on 13-8-26.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

struct Person {
    int personid;
    char *name;
    bool married;
};

@interface ViewController : UIViewController
{
    sqlite3 *sqlite3_db;
}

@end
