//
//  XYObjcet.h
//  XYFoundation
//
//  Created by yanglishuan on 13-8-28.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#ifndef __XYFoundation__XYObjcet__
#define __XYFoundation__XYObjcet__

#include <iostream>


class XYObject
{
public:
    unsigned int uObjID;
protected:
    unsigned int uAutoReleaseCount;
public:
    XYObject(void);
    virtual ~XYObject(void);
    friend class XYAutoreleasePool;
protected:
    XYObject* autorelease(void);
};

#endif /* defined(__XYFoundation__XYObjcet__) */
