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
    
    //Setting correct color of the like button.
    [self.likeButton setImage:[UIImage imageNamed:@"white-heart-picture"] forState:UIControlStateNormal];
    [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapLike:(id)sender {
    //if post has already been liked
    if ([sender isSelected]) {
        //Update appearance to be gray.
        [sender setSelected:NO];
        //Update Post object.
        self.post.likeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] - 1];
    } else { //if post has not been liked
        //Update appearance to be gray.
        [sender setSelected:YES];
        //Update Post object.
        self.post.likeCount = [NSNumber numberWithInt:[self.post.likeCount intValue] + 1];
    }
    //Update likes number label.
    self.likesNumberLabel.text = [NSString stringWithFormat:@"%@ likes", self.post.likeCount];
    //Update the object on Parse.
    [self.post saveInBackground];
}



@end
