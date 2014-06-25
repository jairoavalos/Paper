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
@property (weak, nonatomic) IBOutlet UIImageView *menuView;
@property (assign, nonatomic) CGPoint offset;
@property (assign, nonatomic) float origTouchPositionY;
@property (assign, nonatomic) float originalHeadlineY;
@property UIScrollView *newsScrollView;
@property UIPanGestureRecognizer *pgr;


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
    
    
    // Add black bar to bg to mimic Paper app when dragging headline past the top
    UIView *blackBGBar = [[UIView alloc] initWithFrame:CGRectMake(0, 530, self.view.frame.size.width, 40)];
    blackBGBar.backgroundColor = [UIColor blackColor];
    [self.menuView addSubview:blackBGBar];
  
    
    // Set the headline to be draggable
    self.headline.userInteractionEnabled = YES;
    
    
    // Set up scroll view with news feed
    UIImageView *newsFeed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news"]];
  
    self.newsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 321, 320, 254)];
    self.newsScrollView.contentSize = CGSizeMake([UIImage imageNamed:@"news"].size.width, newsFeed.frame.size.height);
    [self.newsScrollView setShowsHorizontalScrollIndicator:NO];
    
    // add the news feed to the scrollview
    [self.newsScrollView addSubview:newsFeed];
  
    
    // add the scrollview to the headline view
    [self.headline addSubview:self.newsScrollView];
  
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
    CGPoint touchPosition = [sender locationInView:self.view];
    float offset;
    
    // On inital tap & drag
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.origTouchPositionY = touchPosition.y;
        self.originalHeadlineY = self.headline.center.y + 3.5;

    // While dragging
    } else if (sender.state == UIGestureRecognizerStateChanged) {

        offset = touchPosition.y - self.origTouchPositionY;
        // if the view is being dragged up past the top friction should increase
        if (self.headline.frame.origin.y < 0) offset = offset/10;
        
        self.headline.center = CGPointMake(self.view.frame.size.width/2, self.originalHeadlineY + offset);
        
    // Once dragging has stopped
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        float topThreshold = 100;
        float bottomThreshold = self.view.frame.size.width/2 + 20;
        CGPoint velocity = [sender velocityInView:self.view];
        
        // if the view is not dragged far down enough, pin back to top
        if (self.headline.frame.origin.y < topThreshold) {

            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.headline.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            } completion:^(BOOL finished) {
                // nothing if no completion
            }];

        // if view has been dragged far enough, move to the bottom
        } else {
            // this is to check if the view is being moved down.
            if (self.headline.frame.origin.y < bottomThreshold || velocity.y > 1500) {
                [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.headline.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height + 240);
                } completion:^(BOOL finished) {
                    // nothing if no completion
                }];
            
            // if the view has started from the bottom then move up to original position
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    self.headline.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
                }];
            }
        }
    }
}
@end
