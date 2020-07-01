//
//  MovieCell.m
//  Flix
//
//  Created by Ana Cismaru on 6/24/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCell:(Movie *)movie {
    self.titleLabel.text = movie.title;
    self.synopsisLabel.text = movie.synopsis;

    NSURLRequest *request = [NSURLRequest requestWithURL:movie.posterURL];
    
    self.posterImageView.image = nil;
    self.backgroundImageView.image = nil;
    
    [self.posterImageView setImageWithURLRequest:request placeholderImage:nil
    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
        
        // imageResponse will be nil if the image is cached
        if (imageResponse) {
            //NSLog(@"Image was NOT cached, fade in image");
            self.posterImageView.alpha = 0.0;
            self.posterImageView.image = image;
            self.posterImageView.layer.cornerRadius = 6;
            
            //Animate UIImageView back to alpha 1 over 0.3sec
            [UIView animateWithDuration:0.3 animations:^{
                self.posterImageView.alpha = 1.0;
            }];
        }
        else {
            //NSLog(@"Image was cached so just update the image");
            self.posterImageView.image = image;
            self.posterImageView.layer.cornerRadius = 6;
        }
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
        // do something for the failure condition
        NSLog(@"Image failed to load.");
    }];
    
    [self.backgroundImageView setImageWithURL:movie.posterURL];
}

@end
