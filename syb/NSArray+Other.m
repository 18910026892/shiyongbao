//
//  NSArray+Other.m
//  syb
//
//  Created by GX on 15/11/6.
//  Copyright © 2015年 GX. All rights reserved.
//

#import "NSArray+Other.h"

@implementation NSArray (Other)
- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (self.count > index)
    {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)deepCopy
{
    return [[NSArray alloc] initWithArray:self copyItems:YES];
}

- (id)mutableDeepCopy
{
    return [[NSMutableArray alloc] initWithArray:self copyItems:YES];
}

- (id)trueDeepCopy
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
}

- (id)trueDeepMutableCopy
{
    return [[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]] mutableCopy];
}

@end

#pragma mark -

// No-ops for non-retaining objects.
static const void *	__TTRetainNoOp( CFAllocatorRef allocator, const void * value ) { return value; }
static void			__TTReleaseNoOp( CFAllocatorRef allocator, const void * value ) { }


@implementation NSMutableArray (WeakReferences)

+ (id)noRetainingArray
{
    return [self noRetainingArrayWithCapacity:0];
}

+ (id)noRetainingArrayWithCapacity:(NSUInteger)capacity
{
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = __TTRetainNoOp;
    callbacks.release = __TTReleaseNoOp;
    return (__bridge_transfer NSMutableArray*)CFArrayCreateMutable(nil, capacity, &callbacks);
}

@end

#pragma mark -

@implementation NSMutableDictionary (WeakReferences)

+ (id)noRetainingDictionary
{
    return [self noRetainingDictionaryWithCapacity:0];
}

+ (id)noRetainingDictionaryWithCapacity:(NSUInteger)capacity
{
    CFDictionaryKeyCallBacks keyCallbacks = kCFTypeDictionaryKeyCallBacks;
    CFDictionaryValueCallBacks callbacks = kCFTypeDictionaryValueCallBacks;
    callbacks.retain = __TTRetainNoOp;
    callbacks.release = __TTReleaseNoOp;
    return (__bridge_transfer NSMutableDictionary*)CFDictionaryCreateMutable(nil, 0, &keyCallbacks, &callbacks);
}
@end
