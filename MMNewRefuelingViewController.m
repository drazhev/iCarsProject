//
//  MMNewRefuelingViewController.m
//  iCars
//
//  Created by Emilian Parvanov on 2/16/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMNewRefuelingViewController.h"

@interface MMNewRefuelingViewController ()<UITextFieldDelegate>

@property(nonatomic, strong)Car* carToEdit;

@property (nonatomic, strong) UILabel *formLabel;
@property (nonatomic, strong) UILabel *dateLabel;
//@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UILabel *totalCostLabel;
@property (nonatomic, strong) UILabel *fuelPriceLabel;
@property (nonatomic, strong) UITextField *totalCostTextField;
@property (nonatomic, strong) UITextField *fuelPriceTextField;
@property (nonatomic, strong) UILabel *litersLabel;
@property (nonatomic, strong) UITextField *litersTextField;
@property (nonatomic, strong) UILabel *odometerLabel;
@property (nonatomic, strong) UITextField *odometerTextField;
@property (nonatomic, strong) UILabel *fuelTypeLabel;
@property (nonatomic, strong) UITextField *fuelTypeTextField;
@property (nonatomic, strong) UILabel *gasStationLabel;
@property (nonatomic, strong) UITextField *gasStationTextField;

@end

@implementation MMNewRefuelingViewController

@synthesize formLabel, dateLabel, totalCostLabel, fuelPriceLabel, litersLabel, odometerLabel,fuelTypeLabel, gasStationLabel;
@synthesize datePicker, totalCostTextField, fuelPriceTextField, litersTextField, odometerTextField, fuelTypeTextField, gasStationTextField;
@synthesize carToEdit;

- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"refuel %@", car.licenseTag];
        carToEdit = car;
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)loadView{
    CGRect gazFormFrame = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *gazFormView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:gazFormFrame];
    [gazFormView setBackgroundColor:[UIColor whiteColor]];
    [gazFormView setAlwaysBounceVertical:YES];
    [gazFormView setAlwaysBounceHorizontal:NO];
    [gazFormView setScrollEnabled:YES];
    
    self.formLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, gazFormFrame.size.width, 30)];
    self.formLabel.textColor = [UIColor blackColor];
    self.formLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.formLabel.text = @"Зареждане";
    [gazFormView addSubview:self.formLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.formLabel.frame) + 10, gazFormFrame.size.width, 25)];
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.dateLabel.text = @"Дата на зареждане:";
    [gazFormView addSubview:self.dateLabel];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateLabel.frame) + 10, gazFormFrame.size.width, 150)];
    [gazFormView addSubview:self.datePicker];
    
    self.totalCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.datePicker.frame) + 10, gazFormFrame.size.width / 3, 25)];
    self.totalCostLabel.textColor = [UIColor blackColor];
    self.totalCostLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.totalCostLabel.text = @"Крайна цена:";
    [gazFormView addSubview:self.totalCostLabel];
    
    self.fuelPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.totalCostLabel.frame) + 10, CGRectGetMaxY(self.datePicker.frame) + 10, gazFormFrame.size.width / 3, 25)];
    self.fuelPriceLabel.textColor = [UIColor blackColor];
    self.fuelPriceLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.fuelPriceLabel.text = @"Цена за литър:";
    [gazFormView addSubview:self.fuelPriceLabel];
    
    self.litersLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fuelPriceLabel.frame) + 10, CGRectGetMaxY(self.datePicker.frame) + 10, gazFormFrame.size.width / 3, 25)];
    self.litersLabel.textColor = [UIColor blackColor];
    self.litersLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.litersLabel.text = @"Заредени литри:";
    [gazFormView addSubview:self.litersLabel];
    
    
    self.totalCostTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.totalCostLabel.frame) + 10, gazFormFrame.size.width / 3, 25)];
    [self.totalCostTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.totalCostTextField setDelegate:self];
    self.totalCostTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [gazFormView addSubview: self.totalCostTextField];
    
    self.fuelPriceTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.totalCostTextField.frame) + 10, CGRectGetMaxY(self.fuelPriceLabel.frame) + 10, gazFormFrame.size.width / 3, 25)];
    [self.fuelPriceTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.fuelPriceTextField setDelegate:self];
    self.fuelPriceTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [gazFormView addSubview: self.fuelPriceTextField];
    
    self.litersTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.fuelPriceTextField.frame) + 10, CGRectGetMaxY(self.litersLabel.frame) + 10, gazFormFrame.size.width / 3, 25)];
    [self.litersTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.litersTextField setDelegate:self];
    self.litersTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [gazFormView addSubview: self.litersTextField];
    
    self.odometerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.litersTextField.frame) + 10, gazFormFrame.size.width / 3, 25)];
    self.odometerLabel.textColor = [UIColor blackColor];
    self.odometerLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.odometerLabel.text = @"Километраж:";
    [gazFormView addSubview:self.odometerLabel];
    
    self.odometerTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.odometerLabel.frame) + 10, gazFormFrame.size.width / 3, 25)];
    [self.odometerTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.odometerTextField setDelegate:self];
    self.odometerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [gazFormView addSubview: self.odometerTextField];
    
    
    self.fuelTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.odometerTextField.frame) + 10, gazFormFrame.size.width / 3, 25)];
    self.fuelTypeLabel.textColor = [UIColor blackColor];
    self.fuelTypeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.fuelTypeLabel.text = @"Гориво тип:";
    [gazFormView addSubview:self.fuelTypeLabel];
    
    self.fuelTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.fuelTypeLabel.frame) + 10, gazFormFrame.size.width / 3, 25)];
    [self.fuelTypeTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.fuelTypeTextField setDelegate:self];
    self.fuelTypeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [gazFormView addSubview: self.fuelTypeTextField];
    
    
    self.gasStationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.fuelTypeTextField.frame) + 10, gazFormFrame.size.width / 3, 25)];
    self.gasStationLabel.textColor = [UIColor blackColor];
    self.gasStationLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.gasStationLabel.text = @"Бензиностанция:";
    [gazFormView addSubview:self.gasStationLabel];
    
    self.gasStationTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.gasStationLabel.frame) + 10, gazFormFrame.size.width / 3, 25)];;
    [self.gasStationTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.gasStationTextField setDelegate:self];
    self.gasStationTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [gazFormView addSubview: self.gasStationTextField];
    
    
    
    
    
    //VERY IMPORTANT FOR THE PROPER FUNCTIONALITY OF RDVKeyboardAvoidingScrollView
    [gazFormView setContentSize:CGSizeMake(gazFormFrame.size.width, CGRectGetMaxY(self.gasStationTextField.frame) + 65)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleBordered target:self action:@selector(saveCarButtonAction:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    self.view = gazFormView;
}


-(void)saveCarButtonAction:(id)sender{
    NSLog(@"novo zarejdane");
    if (self.totalCostTextField.text.length == 0 || self.fuelPriceTextField.text.length == 0 || self.odometerTextField.text.length == 0) {
        UIAlertView *notEnoughCarInfo = [[UIAlertView alloc] initWithTitle:@"Недостатъчна информация!" message:@"Крайна цена, пробег и цена за литър са задължинелни полета!!!"delegate:sender cancelButtonTitle:@"Опитайте отново" otherButtonTitles:nil];
        [notEnoughCarInfo show];
    }
    else{
        
        //DRAFT 6it
        
        MMAppDelegate* appDelegate = (MMAppDelegate*)[[UIApplication sharedApplication] delegate];
        Refueling* newRefueling = [NSEntityDescription insertNewObjectForEntityForName:@"Refueling" inManagedObjectContext:appDelegate.managedObjectContext];
        
        newRefueling.refuelingDate = self.datePicker.date;
        
        newRefueling.refuelingTotalCost = @([self.totalCostTextField.text integerValue]);
        newRefueling.odometer = @([self.odometerTextField.text integerValue]);
        newRefueling.fuelPrice = @([self.fuelPriceTextField.text integerValue]);
        
        if (self.litersTextField.text.length != 0) newRefueling.refuelingQantity = @([self.litersTextField.text integerValue]);
        
        /* if (self.fuelTypeTextField.text.length != 0)*/ newRefueling.fuelType = self.fuelTypeTextField.text;;//da se prepravi!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! spisuk @"95, 95+, 98, 98+, diesel, gaz4iza, metan4e i t.n"
        /* if (self.gasStationTextField.text.length != 0) */newRefueling.refuelingGasStation = self.gasStationTextField.text;
        newRefueling.fullTank = @(1);
        newRefueling.car = carToEdit;
        
        
        
        // Save the object to managedObjectContext
        NSError* newRefuelingError = nil;
        if (![appDelegate.managedObjectContext save:&newRefuelingError]) {
            NSLog(@"New Refueling ERROR: %@ %@", newRefuelingError, [newRefuelingError localizedDescription]);
        }
        else{
            NSLog(@"dobavihte novo zarejdane");
        }
        
        NSError *error01 = nil;
        // Save the object to persistent store
        if (![appDelegate.managedObjectContext save:&error01]) {
            NSLog(@"Can't Save! %@ %@", error01, [error01 localizedDescription]);
        }
        
        //push to gasolineVC
        
        MMGasolineViewController* gasolineVC = [[MMGasolineViewController alloc] initWithCar:carToEdit];
        [self.navigationController pushViewController:gasolineVC animated:YES]; 
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[[self navigationController] navigationBar] setTranslucent:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Auto/Rotation CONFIG
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotate {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return YES;
    }
    else return NO;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSUInteger)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait |
    UIInterfaceOrientationMaskLandscapeLeft |
    UIInterfaceOrientationMaskLandscapeRight;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@end
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
