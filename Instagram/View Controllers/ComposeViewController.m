//
//  ComposeViewController.m
//  Instagram
//
//  Created by emily13hsiao on 7/8/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load image
    [self.pictureView setImage:self.image];
    self.captionLabel.layer.borderWidth = 1;
    self.captionLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.captionLabel.layer.cornerRadius = 5;
}

/**
- (IBAction)didTapPost:(id)sender {
    [Post postUserImage:self.image withCaption:self.captionLabel.text withCompletion:nil];
     [self dismissViewControllerAnimated:YES completion:nil];
}
 **/
- (IBAction)didTapShare:(id)sender {
    [Post postUserImage:self.image withCaption:self.captionLabel.text withCompletion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
        
}
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
- (IBAction)didTapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
 **/

//Remove keyboard.
- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
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
