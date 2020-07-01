//
//  WebViewController.m
//  Flix
//
//  Created by Ana Cismaru on 6/26/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webkitView;
@property (strong, nonatomic) NSURL *youtubeURL;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *movies = dataDictionary[@"results"];
                //Get first trailer
                NSString *youtubeID = movies[0][@"key"];
                NSString *const youtubeBase = @"https://www.youtube.com/watch?v=";
                NSString *youtubeURLString = [youtubeBase stringByAppendingString:youtubeID];
                self.youtubeURL = [NSURL URLWithString:youtubeURLString];
                NSLog(@"%@", self.youtubeURL);
                
                // Place the URL in a URL Request.
                NSURLRequest *youtubeRequest = [NSURLRequest requestWithURL:self.youtubeURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
                
                // Load Request into WebView.
                [self.webkitView loadRequest:youtubeRequest];
            }
        }];
    [task resume];
    
   
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
