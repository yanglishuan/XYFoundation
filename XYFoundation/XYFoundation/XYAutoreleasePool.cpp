//
//  XYPoolManager.cpp
//  XYFoundation
//
//  Created by yanglishuan on 13-8-28.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#include "XYAutoreleasePool.h"
#include "XYHeads.h"

static XYPoolManager* s_pPoolManager = NULL;

XYAutoreleasePool::XYAutoreleasePool(void)
{
    pManagedObjectArray_ = new XYArray();
//    pManagedObjectArray_->init();
}

XYAutoreleasePool::~XYAutoreleasePool(void)
{
    XY_SAFE_DELETE(pManagedObjectArray_);
}

void XYAutoreleasePool::addObject(XYObject *pObject)
{
    pManagedObjectArray_->addObject(pObject);
    
    ++(pObject->uAutoReleaseCount);
}

XYPoolManager* XYPoolManager::sharedPoolManager()
{
    if (s_pPoolManager == NULL)
    {
        s_pPoolManager = new XYPoolManager();
    }
    return s_pPoolManager;
}