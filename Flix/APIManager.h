//
//  APIManager.h
//  Flix
//
//  Created by Ana Cismaru on 7/1/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject
@property (nonatomic, strong) NSURLSession *session;

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion;

- (void)fetchSuperhero:(void(^)(NSArray *movies, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
