//
//  MainViewController.m
//  Paper
//
//  Created by Jairo Avalos on 6/19/14.
//  Copyright (c) 2014 Jairo Avalos. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headline;

- (IBAction)onDragHeadline:(UIPanGestureRecognizer *)sender;
@property (assign, nonatomic) CGPoint offset;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
  
    // Hide status bar
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
      // iOS 7
      [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
      // iOS 6
      [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
  
    // Set the headline to be draggable
    self.headline.userInteractionEnabled = YES;
    
    // Set up scroll view
  UIImageView *newsFeed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news"]];
  
  UIScrollView *newsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 314, 320, 254)];
  newsScrollView.contentSize = CGSizeMake([UIImage imageNamed:@"news"].size.width, newsFeed.frame.size.height);
  [newsScrollView setShowsHorizontalScrollIndicator:NO];
  
  [newsScrollView addSubview:newsFeed];
  
  
  [self.view addSubview:newsScrollView];
  
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onDragHeadline:(UIPanGestureRecognizer *)sender {
    NSLog(@"dragged");
}
@end
