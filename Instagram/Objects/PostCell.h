//
//  PostCell.h
//  Instagram
//
//  Created by emily13hsiao on 7/9/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likesNumberLabel;

@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) UIImage *photo;
@property (strong, nonatomic) IBOutlet PFFileObject *photoImageView;

@end

NS_ASSUME_NONNULL_END
