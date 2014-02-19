//
//  MMNewServiceViewController.m
//  iCars
//
//  Created by Emilian Parvanov on 2/18/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMNewServiceViewController.h"

@interface MMNewServiceViewController ()

@property(nonatomic, strong)Car* carToEdit;

@end

@implementation MMNewServiceViewController
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@synthesize carToEdit;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"remont %@", car.licenseTag];
        carToEdit = car;
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)loadView{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *newServiceView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:applicationFrame];
    [newServiceView setBackgroundColor:[UIColor whiteColor]];
    [newServiceView setAlwaysBounceVertical:YES];
    [newServiceView setAlwaysBounceHorizontal:NO];
    [newServiceView setScrollEnabled:YES];
    
    
    
    
    
    
    
    //VERY IMPORTANT FOR THE PROPER FUNCTIONALITY OF RDVKeyboardAvoidingScrollView
    // [gazFormView setContentSize:CGSizeMake(gazFormFrame.size.width, CGRectGetMaxY(self.gasStationTextField.frame) + 65)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleBordered target:self action:@selector(saveServiceButtonAction:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    self.view = newServiceView;
}
-(void)saveServiceButtonAction:(id)sender{
    NSLog(@"nov remont");
    
    
    MMServicesViewController* serviceVC = [[MMServicesViewController alloc] initWithCar:carToEdit];
    [self.navigationController pushViewController:serviceVC animated:YES];
    
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