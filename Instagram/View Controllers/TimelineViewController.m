//
//  TimelineViewController.m
//  Instagram
//
//  Created by emily13hsiao on 7/8/19.
//  Copyright © 2019 emily13hsiao. All rights reserved.
//

#import "TimelineViewController.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "ComposeViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "PostDetailsViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchPosts];
    
    // Do any additional setup after loading the view.
}

//TABLEVIEW STUFF.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.posts[indexPath.row];
    
    cell.post = post;
    
    cell.usernameLabel.text = post.author.username;
    
    PFFileObject *img = post.image;
    [img getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        cell.photo = imageToLoad;
        [cell.photoView setImage:imageToLoad];
    }];
    
    cell.captionLabel.text = post.caption;
    cell.likesNumberLabel.text = [NSString stringWithFormat:@"%@ likes", post.likeCount];
    
    return cell;
}

//TAP BUTTON STUFF.

- (IBAction)didTapLogout:(id)sender {
    //FIX THIS TO PRESENT LOGIN VIEW CONTROLLER.
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
}

- (IBAction)didTapPost:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

//IMAGEPICKER STUFF.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Set image and caption
    self.selectedImage = [self resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"toCompose" sender:self];}
     ];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

//FETCH POSTS
- (void)fetchPosts {
    
    // construct PFQuery
    
    NSLog(@"Starting to fetch posts.");
    
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    if (self.tabBarController.selectedIndex > 0){
        [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    }
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            NSLog(@"Finished fetching posts.");
        }
        else {
            NSLog(@"Error fetching posts.");
        }
    }];
}

//SCROLL STUFF
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int scrollViewContentHeight = self.tableView.contentSize.height;
    int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
    
    // When the user has scrolled past the threshold, start requesting
    if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
        self.isMoreDataLoading = true;
        [self loadMoreData];
    }
}

-(void)loadMoreData{
    
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.skip = self.posts.count;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            [self.posts addObjectsFromArray:posts];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }
        else {
            NSLog(@"Error fetching posts.");
        }
    }];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if ([segue.identifier isEqualToString:@"toCompose"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeViewController = (ComposeViewController*)navigationController.topViewController;
        
        // Pass the selected image to the new view controller.
        composeViewController.image = self.selectedImage;
        
    } else if ([segue.identifier isEqualToString:@"toPost"]) {
        
        PostCell *tappedCell = sender;
        Post *post = tappedCell.post;
        
        PostDetailsViewController *detailsPage = [segue destinationViewController];
        detailsPage.post = post;
        
    }
}


@end
