//
//  MarkUtils.h
//  LoginPart
//
//  Created by blacksky on 2020/2/7.
//  Copyright © 2020 blacksky. All rights reserved.
//

#ifndef MarkUtils_h
#define MarkUtils_h
#define addView(pa, sub) [pa addSubview:sub]
#define insertViewBelow(pa,sub,below) [pa insertSubview:sub belowSubview:below]
#define frameAndBounds(rect) @"frame:(height:%f,width:%f),bounds:(height:%f,width:%f)",CGRectGetHeight(rect.frame),CGRectGetWidth(rect.frame),CGRectGetHeight(rect.bounds),CGRectGetWidth(rect.bounds)
#define NavLeftItemMake(view) [[UIBarButtonItem alloc] initWithCustomView:view]
#endif /* MarkUtils_h */
