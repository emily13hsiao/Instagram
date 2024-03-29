//
//  Post.h
//  Instagram
//
//  Created by emily13hsiao on 7/8/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//  Post.h


@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFUser *author;

@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) NSNumber *commentCount;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
