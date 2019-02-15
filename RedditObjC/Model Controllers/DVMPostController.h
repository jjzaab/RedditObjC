//
//  DVMPostController.h
//  RedditObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DVMPost;

NS_ASSUME_NONNULL_BEGIN

@interface DVMPostController : NSObject

+ (DVMPostController *)sharedController;

- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void(^) (NSArray<DVMPost *> *posts, NSError *_Nullable error))completion;

- (void)fetchThumbnail:(DVMPost *)post ImageCompletion:(void (^)(UIImage *))completion;

@end

NS_ASSUME_NONNULL_END
