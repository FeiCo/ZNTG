//
//  DebugHeader.h
//  ZNTG
//
//  Created by Peter Hu on 16/7/27.
//  Copyright © 2016年 Peter Hu. All rights reserved.
//

#ifndef DebugHeader_h
#define DebugHeader_h


// 日志
#ifdef DEBUG

#ifndef DebugLog
#define DebugLog(fmt, ...) NSLog((@"[%s Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#else

#ifndef DebugLog
#define DebugLog(fmt, ...)
#endif

#define NSLog



#endif /* DebugHeader_h */
