//
//  XYMacros.h
//  XYFoundation
//
//  Created by yanglishuan on 13-8-28.
//  Copyright (c) 2013年 yls. All rights reserved.
//

#ifndef XYFoundation_XYMacros_h
#define XYFoundation_XYMacros_h

#define XY_SAFE_DELETE(p)   do { if(p) { delete (p); (p) = 0; } } while(0)

#endif
