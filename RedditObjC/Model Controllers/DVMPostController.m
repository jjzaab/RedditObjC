//
//  DVMPostController.m
//  RedditObjC
//
//  Created by XMS_JZhan on 2/12/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

#import "DVMPostController.h"
#import "DVMPost.h"
#import <UIKit/UIKit.h>

@implementation DVMPostController

+ (DVMPostController *)sharedController
{
    static DVMPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [DVMPostController new];
    });
    return shared;
}

// MARK: - Propeties

- (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://www.reddit.com/r"];
}

// MARK: - Fetch
- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<DVMPost *> *, NSError *))completion
{    
    NSURL *searchURL = [self baseURL];
    searchURL = [searchURL URLByAppendingPathComponent:searchTerm];
    searchURL = [searchURL URLByAppendingPathExtension:@"json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData *data, NSURLResponse * response, NSError * error) {
        
        // Error handling
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if (!data) {
            NSLog(@"Error no data returned");
            completion(nil, error);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"JSON Dictionary is not a dictionary class");
            completion(nil, error);
            return;
        }
        
        NSDictionary *postDataDictionaries = jsonDictionary[@"data"];
        NSArray *childrensArray = postDataDictionaries[@"children"];
        
        // We need a placeholder array
        NSMutableArray *postsArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dataDictionary in childrensArray) {
            
            DVMPost *post = [[DVMPost alloc] initWithDictionary:dataDictionary];
            [postsArray addObject:post];
        }
        completion(postsArray, nil);
        
    }] resume];
}

// Fetching image

- (void)fetchThumbnail:(DVMPost *)post ImageCompletion:(void (^)(UIImage *))completion
{
    NSString *thumbnailString = [[NSString alloc] init];
    thumbnailString = post.thumbnail;
    NSURL *thumbnailURL = [[NSURL alloc] initWithString:thumbnailString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:thumbnailURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error handling image: %@", [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"No data from image task");
            completion(nil);
            return;
        }
        
        UIImage *thumbnail = [[UIImage alloc] initWithData:data];
        completion(thumbnail);
    }] resume];
}

@end
