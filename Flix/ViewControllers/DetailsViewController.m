//
//  DetailsViewController.m
//  Flix
//
//  Created by Ana Cismaru on 6/24/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "WebViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    unichar firstChar = [posterURLString characterAtIndex:0];
    if (firstChar != '/') {
        posterURLString = [@"/" stringByAppendingString:posterURLString];
    }
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL =[NSURL URLWithString:fullPosterURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterURL];
    
    self.posterView.image = nil;
    
    [self.posterView setImageWithURLRequest:request placeholderImage:nil
    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
        
        // imageResponse will be nil if the image is cached
        if (imageResponse) {
            NSLog(@"Image was NOT cached, fade in image");
            self.posterView.alpha = 0.0;
            self.posterView.image = image;
            self.posterView.layer.cornerRadius = 6;
            
            //Animate UIImageView back to alpha 1 over 0.3sec
            [UIView animateWithDuration:0.3 animations:^{
                self.posterView.alpha = 1.0;
            }];
        }
        else {
            NSLog(@"Image was cached so just update the image");
            self.posterView.image = image;
            self.posterView.layer.cornerRadius = 6;
        }
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
        // do something for the failure condition
        NSLog(@"Image failed to load.");
    }];
    
    self.backgroundImageView.image = nil;
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    unichar firstBackdropChar = [backdropURLString characterAtIndex:0];
    if (firstBackdropChar != '/') {
        backdropURLString = [@"/" stringByAppendingString:backdropURLString];
    }
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL =[NSURL URLWithString:fullBackdropURLString];
    NSURLRequest *backdropRequest = [NSURLRequest requestWithURL:backdropURL];
    
    [self.backgroundImageView setImageWithURLRequest:backdropRequest placeholderImage:nil
      success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
          
          // imageResponse will be nil if the image is cached
          if (imageResponse) {
              NSLog(@"Image was NOT cached, fade in image");
              self.backgroundImageView.alpha = 0.0;
              self.backgroundImageView.image = image;
              self.backgroundImageView.layer.cornerRadius = 6;
              
              //Animate UIImageView back to alpha 1 over 0.3sec
              [UIView animateWithDuration:0.3 animations:^{
                  self.backgroundImageView.alpha = 1.0;
              }];
          }
          else {
              NSLog(@"Image was cached so just update the image");
              self.backgroundImageView.image = image;
              self.backgroundImageView.layer.cornerRadius = 6;
          }
      }
      failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
          // do something for the failure condition
          NSLog(@"Image failed to load.");
      }];
    
    
    
    self.titleLabel.text = self.movie[@"title"];
    [self.titleLabel sizeToFit];
    
    self.synopsisLabel.text = self.movie[@"overview"];
    [self.synopsisLabel sizeToFit];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *movieID = [NSString stringWithFormat:@"%@", self.movie[@"id"]];
    NSLog(@"%@", movieID);
    NSString *baseURL = @"https://api.themoviedb.org/3/movie";
    NSString *endURL = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
    unichar firstChar = [movieID characterAtIndex:0];
    if (firstChar != '/') {
        movieID = [@"/" stringByAppendingString:movieID];
    }
    NSString *fullURLString = [baseURL stringByAppendingString:movieID];
    fullURLString = [fullURLString stringByAppendingString:endURL];
    NSURL *fullURL = [NSURL URLWithString:fullURLString];
    
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.url = fullURL;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
