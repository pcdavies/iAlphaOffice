//
//  DebugLogger.h
//  iAlphaOffice
//
//  Created by Patrick Davies on 9/16/14.
//  Copyright (c) 2014 PCD. All rights reserved.
//


#ifdef DEBUG
#define DebugLog(...) NSLog(@"%s (%d) %@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define DebugLog(...)
#endif