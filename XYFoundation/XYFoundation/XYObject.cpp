//
//  XYObjcet.cpp
//  XYFoundation
//
//  Created by yanglishuan on 13-8-28.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#include "XYObject.h"

XYObject::XYObject(void)
:uAutoReleaseCount(0)
{
    static unsigned int uObjectCount = 0;
    uObjID = ++uObjectCount;
}


XYObject::~XYObject(void)
{
    if (uAutoReleaseCount > 0) {
        
    }
}