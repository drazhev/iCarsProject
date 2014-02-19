//
//  MMNewReminderViewController.m
//  iCars
//
//  Created by Alexandar Drajev on 2/19/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMNewReminderViewController.h"

@interface MMNewReminderViewController ()

@property(nonatomic, strong) Car* carToEdit;
@property(nonatomic, strong) UIScrollView* reminderScrollView;


@end


@implementation MMNewReminderViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (CGRect)getScreenFrameForCurrentOrientation {
    return [self getScreenFrameForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGRect)getScreenFrameForOrientation:(UIInterfaceOrientation)orientation {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect fullScreenRect = screen.bounds;
    BOOL statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
    
    //implicitly in Portrait orientation.
    if(orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationLandscapeLeft){
        CGRect temp = CGRectZero;
        temp.size.width = fullScreenRect.size.height;
        temp.size.height = fullScreenRect.size.width;
        fullScreenRect = temp;
    }
    
    if(!statusBarHidden){
        CGFloat statusBarHeight = 20;//Needs a better solution, FYI statusBarFrame reports wrong in some cases..
        fullScreenRect.size.height -= statusBarHeight;
    }
    
    return fullScreenRect;
}


-(void)loadView {
    CGRect applicationFrame = [self getScreenFrameForCurrentOrientation];
    self.reminderScrollView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:applicationFrame];
    [self.reminderScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.reminderScrollView setAlwaysBounceVertical:YES];
    [self.reminderScrollView setAlwaysBounceHorizontal:NO];
    [self.reminderScrollView setScrollEnabled:YES];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleBordered target:self action:@selector(saveReminder:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    
    
    self.view = self.reminderScrollView;
}

-(void)saveReminder: (id)sender {
    
    MMRemindersViewController* remindersVC = [[MMRemindersViewController alloc] initWithCar:self.carToEdit];
    [self.navigationController pushViewController:remindersVC animated:YES];
}

- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"Reminder %@", car.licenseTag];
        self.carToEdit = car;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
