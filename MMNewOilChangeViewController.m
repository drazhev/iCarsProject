//
//  MMNewOilChangeViewController.m
//  iCars
//
//  Created by Emilian Parvanov on 2/18/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#import "MMNewOilChangeViewController.h"
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@interface MMNewOilChangeViewController ()

@property(nonatomic, strong)Car* carToEdit;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@implementation MMNewOilChangeViewController
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@synthesize carToEdit;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"ol change %@", car.licenseTag];
        carToEdit = car;
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)loadView{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *newOilChangeView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:applicationFrame];
    [newOilChangeView setBackgroundColor:[UIColor whiteColor]];
    [newOilChangeView setAlwaysBounceVertical:YES];
    [newOilChangeView setAlwaysBounceHorizontal:NO];
    [newOilChangeView setScrollEnabled:YES];
    

    
    
    
    
    
    //VERY IMPORTANT FOR THE PROPER FUNCTIONALITY OF RDVKeyboardAvoidingScrollView
   // [gazFormView setContentSize:CGSizeMake(gazFormFrame.size.width, CGRectGetMaxY(self.gasStationTextField.frame) + 65)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleBordered target:self action:@selector(saveOilChange:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    self.view = newOilChangeView;
}
-(void)saveOilChange:(id)sender{
    NSLog(@"nova smqna na maslo");
    
    
    MMOilViewController* oilVC = [[MMOilViewController alloc] initWithCar:carToEdit];
    [self.navigationController pushViewController:oilVC animated:YES];
        
        
        
        
    
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@end
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------