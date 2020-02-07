//
//  NSObject+BlockSEL.h
//  LoginPart
//
//  Created by blacksky on 2020/2/4.
//  Copyright © 2020 blacksky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BlockSEL)
- (SEL)selectorBlock:(void (^)(id))block;
@end

NS_ASSUME_NONNULL_END
