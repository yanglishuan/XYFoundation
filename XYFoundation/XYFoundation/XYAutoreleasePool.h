//
//  XYPoolManager.h
//  XYFoundation
//
//  Created by yanglishuan on 13-8-28.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#ifndef __XYFoundation__XYPoolManager__
#define __XYFoundation__XYPoolManager__

#include <iostream>
#include "XYObject.h"
#include "XYArray.h"

class XYAutoreleasePool : public XYObject
{
    XYArray* pManagedObjectArray_;
public:
    XYAutoreleasePool(void);
    ~XYAutoreleasePool(void);
    
    void addObject(XYObject* pObject);
    void removeObject(XYObject* pObject);
};

class XYPoolManager
{
    XYArray* pManagedObjectArray_;
    
public:
    static XYPoolManager* sharedPoolManager();
};

#endif /* defined(__XYFoundation__XYPoolManager__) */
