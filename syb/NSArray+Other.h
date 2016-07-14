//
//  NSArray+Other.h
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Other)
- (id)safeObjectAtIndex:(NSUInteger)index;

- (id)deepCopy;
- (id)mutableDeepCopy;

- (id)trueDeepCopy;
- (id)trueDeepMutableCopy;

@end

#pragma mark -

@interface NSMutableArray (WeakReferences)

+ (id)noRetainingArray;
+ (id)noRetainingArrayWithCapacity:(NSUInteger)capacity;

@end

#pragma mark -

@interface NSMutableDictionary (WeakReferences)

+ (id)noRetainingDictionary;
+ (id)noRetainingDictionaryWithCapacity:(NSUInteger)capacity;
@end
