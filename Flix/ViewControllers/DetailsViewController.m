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
#import "Movie.h"

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
    NSURL *posterURL = self.movie.posterURL;
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
  
    NSURL *backdropURL = self.movie.backdropURL;
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
    
    
    
    self.titleLabel.text = self.movie.title;
    [self.titleLabel sizeToFit];
    
    self.synopsisLabel.text = self.movie.synopsis;
    [self.synopsisLabel sizeToFit];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.url = self.movie.trailerURL;
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
