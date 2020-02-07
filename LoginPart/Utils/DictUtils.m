//
//  DictUtils.m
//  ReactiveCocoaTest
//
//  Created by blacksky on 2020/1/28.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "DictUtils.h"
#import <objc/runtime.h>
@implementation DictUtils
+ (NSDictionary *)Object2Dict:(__autoreleasing id)Object {
    unsigned int property_count = 0;
    NSMutableDictionary *dic    = [[NSMutableDictionary alloc] initWithCapacity:5];
    objc_property_t *properties = class_copyPropertyList([Object class], &property_count);
    for (int i = 0; i < property_count; ++i) {
        const char *name = property_getName(properties[i]);
        NSString *value  = [Object valueForKey:[NSString stringWithUTF8String:name]];
        NSLog(@"{name:%s,value:%@}", name, value);
        if (value != nil) { dic[[NSString stringWithUTF8String:name]] = value; }
    }
    return ![dic count] ? nil : dic;
}
@end
