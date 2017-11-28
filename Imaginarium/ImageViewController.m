//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Dragota Mircea on 28/11/2017.
//  Copyright © 2017 Dragota Mircea. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (strong,nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) UIImage *image;
@end

@implementation ImageViewController

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;
    _scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self startDownloadingImage];
}

- (void)startDownloadingImage {
    self.image = nil;
    if(self.imageURL) {
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *localfile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error) {
                if ([request.URL isEqual:self.imageURL]) {
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.image = image;
                    });
                }
            }
        }];
        [task resume];
    }
}

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.imageView sizeToFit];
    // because it's a struct
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

@end
