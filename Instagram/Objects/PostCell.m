//
//  PostCell.m
//  Instagram
//
//  Created by emily13hsiao on 7/9/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import "PostCell.h"
#import "Parse/Parse.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
- (void)setPost:(Post *)post {
    _post = post;
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}
 **/


@end
