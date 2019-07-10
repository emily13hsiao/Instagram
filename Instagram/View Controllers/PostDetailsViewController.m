//
//  PostDetailsViewController.m
//  Instagram
//
//  Created by emily13hsiao on 7/9/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import "PostDetailsViewController.h"
#import "Parse/Parse.h"

@interface PostDetailsViewController ()

@end


@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     @property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
     @property (weak, nonatomic) IBOutlet UIImageView *photoView;
     @property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
     @property (weak, nonatomic) IBOutlet UILabel *captionLabel;
     **/
    
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    
    //set timestamp
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatter stringFromDate:self.post.createdAt];
    self.timestampLabel.text = stringFromDate;
    
    //set big image
    PFFileObject *img = self.post.image;
    
    // retain cycle will cause memory leaks
    __weak __typeof(self) weakSelf = self;
    [img getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        __strong __typeof(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [strongSelf.photoView setImage:imageToLoad];
    }];
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
