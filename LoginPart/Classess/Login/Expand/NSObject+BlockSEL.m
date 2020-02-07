//
//  NSObject+BlockSEL.m
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import "NSObject+BlockSEL.h"

static void selectorImp(id self, SEL _cmd, id arg) {
    void (^block)(id arg) = objc_getAssociatedObject(self, _cmd);
    if (block) block(arg);
}
@implementation NSObject (BlockSEL)
- (SEL)selectorBlock:(void (^)(id))block {
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    SEL sel           = NSSelectorFromString(selName);
    class_addMethod([self class], sel, (IMP)selectorImp, "v@:@");
    objc_setAssociatedObject(self, sel, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return sel;
}
@end
