//
//  DVMPost.h
//  RedditObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMPost : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger ups;
@property (nonatomic, readonly) NSNumber *commentCount;
@property (nonatomic, copy, readonly) NSString *thumbnail;

- (instancetype)initWithTitle:(NSString *)title ups:(NSInteger)ups commentCount:(NSNumber *)commentCount thumbnail:(NSString *)thumbnail;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
