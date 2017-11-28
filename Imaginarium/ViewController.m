//
//  ViewController.m
//  Imaginarium
//
//  Created by Dragota Mircea on 28/11/2017.
//  Copyright © 2017 Dragota Mircea. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:ImageViewController.class]) {
        ImageViewController *ivc = (ImageViewController *)segue.destinationViewController;
        if ([segue.identifier isEqualToString:@"Nuts"]) {
            ivc.imageURL = [NSURL URLWithString:@"https://cdn.pixabay.com/photo/2017/11/22/22/53/nuts-2971675_960_720.jpg"];
        } else if([segue.identifier isEqualToString:@"Hamburg"]) {
            ivc.imageURL = [NSURL URLWithString:@"https://cdn.pixabay.com/photo/2017/11/25/12/34/hamburg-2976711_960_720.jpg"];
        } else if([segue.identifier isEqualToString:@"Flowers"]) {
            ivc.imageURL = [NSURL URLWithString:@"https://cdn.pixabay.com/photo/2017/11/25/12/08/rose-2976674_960_720.jpg"];
        }
        ivc.title = segue.identifier;
        
    }
}

@end
