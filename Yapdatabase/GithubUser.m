//
//  GithubUser.m
//  Yapdatabase
//
//  Created by terrylin on 2016/10/19.
//  Copyright © 2016年 TerryLin. All rights reserved.
//

#import "GithubUser.h"
#import <objc/objc-runtime.h>

@implementation GithubUser

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id",
             };
}

-(instancetype)updateWithObject:(GithubUser *)user
{
    if ([user isMemberOfClass:[self class]]) {
        YYClassInfo* info = [YYClassInfo classInfoWithClass:[user class]];
        for (YYClassPropertyInfo* pInfo in [info.propertyInfos allValues]) {
//            id this = [self valueForKey:NSStringFromSelector(pInfo.getter)];
            id that = [user valueForKey:NSStringFromSelector(pInfo.getter)];
            if (that) {
                ((void (*)(id, SEL, id))(void *) objc_msgSend)((id)self, pInfo.setter, that);
            }
        }
    }
    return self;
}


// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }
@end
