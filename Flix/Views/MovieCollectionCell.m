//
//  MovieCollectionCell.m
//  Flix
//
//  Created by Ana Cismaru on 6/25/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCollectionCell

- (void)setUpCell:(Movie *)movie {
     NSURL *posterURL = movie.posterURL;
     NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
     
     self.posterView.image = nil;
        
     [self.posterView setImageWithURLRequest:request placeholderImage:nil
     success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
            // imageResponse will be nil if the image is cached
            if (imageResponse) {
                //NSLog(@"Image was NOT cached, fade in image");
                self.posterView.alpha = 0.0;
                self.posterView.image = image;
                self.posterView.layer.cornerRadius = 6;
                
                //Animate UIImageView back to alpha 1 over 0.3sec
                [UIView animateWithDuration:0.3 animations:^{
                    self.posterView.alpha = 1.0;
                }];
            }
            else {
                //NSLog(@"Image was cached so just update the image");
                self.posterView.image = image;
                self.posterView.layer.cornerRadius = 6;
            }
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
            // do something for the failure condition
            NSLog(@"Image failed to load.");
    }];
}

@end
