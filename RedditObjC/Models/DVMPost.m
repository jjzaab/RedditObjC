//
//  DVMPost.m
//  RedditObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "DVMPost.h"

@implementation DVMPost

- (instancetype)initWithTitle:(NSString *)title ups:(NSInteger)ups commentCount:(NSNumber *)commentCount thumbnail:(NSString *)thumbnail
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _ups = ups;
        _commentCount = [commentCount copy];
        _thumbnail = [thumbnail copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // Get each post from the data key
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    // When your inside the innermost data dictionary which holds the object you want to initialize, that is when you can define your properties that come from the json
    NSString *title = dataDictionary[[DVMPost titleKey]];
    NSInteger ups = [dataDictionary[[DVMPost upsKey]] integerValue];
    NSNumber *commentCount = dataDictionary[[DVMPost commentCountKey]];
    NSString *thumbnail = dataDictionary[[DVMPost thumbnailKey]];
    
    // init object
    return [self initWithTitle:title ups:ups commentCount:commentCount thumbnail:thumbnail];
}

// MARK: - Keys
+ (NSString *)titleKey
{
    return @"title";
}

+ (NSString *)upsKey
{
    return @"ups";
}

+ (NSString *)commentCountKey
{
    return @"num_comments";
}

+ (NSString *)thumbnailKey
{
    return @"thumbnail";
}

@end
