//
//  Movie.m
//  Flix
//
//  Created by Ana Cismaru on 7/1/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    NSLog(@"%@", dictionary);
    self.title = dictionary[@"title"];
    self.synopsis = dictionary[@"overview"];

    NSString *const baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = dictionary[@"poster_path"];
    if (posterURLString != nil && posterURLString != (id)[NSNull null]) {
        unichar firstCharPoster = [posterURLString characterAtIndex:0];
        if (firstCharPoster != '/') {
            posterURLString = [@"/" stringByAppendingString:posterURLString];
        }
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        self.posterURL =[NSURL URLWithString:fullPosterURLString];
    }
    
    NSString *backdropURLString = dictionary[@"backdrop_path"];
    if (backdropURLString != nil && backdropURLString != (id)[NSNull null]) {
        unichar firstBackdropChar = [backdropURLString characterAtIndex:0];
        if (firstBackdropChar != '/') {
            backdropURLString = [@"/" stringByAppendingString:backdropURLString];
        }
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
        self.backdropURL =[NSURL URLWithString:fullBackdropURLString];
    }
    
    NSString *movieID = [NSString stringWithFormat:@"%@", dictionary[@"id"]];
    if (movieID != nil && movieID != (id)[NSNull null]) {
        NSString *const baseURL = @"https://api.themoviedb.org/3/movie";
        NSString *const endURL = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
        unichar firstCharTrailer = [movieID characterAtIndex:0];
        if (firstCharTrailer != '/') {
            movieID = [@"/" stringByAppendingString:movieID];
        }
        NSString *fullURLString = [baseURL stringByAppendingString:movieID];
        fullURLString = [fullURLString stringByAppendingString:endURL];
        self.trailerURL = [NSURL URLWithString:fullURLString];
    } 
    
    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
   // Implement this function
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return movies;
}

@end
