//
//  MMNewRefuelingViewController.m
//  iCars
//
//  Created by Emilian Parvanov on 2/16/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMNewRefuelingViewController.h"

@interface MMNewRefuelingViewController ()

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
@property (nonatomic, strong) UILabel *gasNotesLabel;
@property (nonatomic, strong) UITextField *gasNotesTextField;

@end

@implementation MMNewRefuelingViewController

@synthesize formLabel, dateLabel, totalCostLabel, fuelPriceLabel, litersLabel, odometerLabel,fuelTypeLabel, gasStationLabel, gasNotesLabel;
@synthesize datePicker, totalCostTextField, fuelPriceTextField, litersTextField, odometerTextField, fuelTypeTextField, gasStationTextField, gasNotesTextField;
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
    
    self.formLabel = [[UILabel alloc] init];
    self.formLabel.textColor = [UIColor blackColor];
    self.formLabel.font = [UIFont fontWithName:@"Arial" size:15];
    self.formLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.formLabel.text = @"Зареждане";
    [gazFormView addSubview:self.formLabel];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.dateLabel.text = @"Дата на зареждане:";
    [gazFormView addSubview:self.dateLabel];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview:self.datePicker];
    
//    self.dateTextField = [[UITextField alloc] init];
//    [self.dateTextField setBorderStyle:UITextBorderStyleRoundedRect];
//    //[self.dateTextField setDelegate:self];
//    self.dateTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    self.dateTextField.translatesAutoresizingMaskIntoConstraints = NO;
//    //self.dateTextField.secureTextEntry = YES;
//    //self.dateTextField.placeholder = @"Enter Password";
//    [gazFormView addSubview: self.dateTextField];
    
    self.totalCostLabel = [[UILabel alloc] init];
    self.totalCostLabel.textColor = [UIColor blackColor];
    self.totalCostLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.totalCostLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.totalCostLabel.text = @"Крайна цена:";
    [gazFormView addSubview:self.totalCostLabel];
    
    self.fuelPriceLabel = [[UILabel alloc] init];
    self.fuelPriceLabel.textColor = [UIColor blackColor];
    self.fuelPriceLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.fuelPriceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fuelPriceLabel.text = @"Цена за литър:";
    [gazFormView addSubview:self.fuelPriceLabel];
    
    
    self.totalCostTextField = [[UITextField alloc] init];
    [self.totalCostTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.totalCostTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.totalCostTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.totalCostTextField];
    
    self.fuelPriceTextField = [[UITextField alloc] init];
    [self.fuelPriceTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.fuelPriceTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.fuelPriceTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.fuelPriceTextField];
    
    self.litersLabel = [[UILabel alloc] init];
    self.litersLabel.textColor = [UIColor blackColor];
    self.litersLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.litersLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.litersLabel.text = @"Заредени литри:";
    [gazFormView addSubview:self.litersLabel];
    
    self.litersTextField = [[UITextField alloc] init];
    [self.litersTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.litersTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.litersTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.litersTextField];
    
    self.odometerLabel = [[UILabel alloc] init];
    self.odometerLabel.textColor = [UIColor blackColor];
    self.odometerLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.odometerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.odometerLabel.text = @"Километраж:";
    [gazFormView addSubview:self.odometerLabel];
    
    self.odometerTextField = [[UITextField alloc] init];
    [self.odometerTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.odometerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.odometerTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.odometerTextField];
    
    
    //-------------------------------------------------------------------------------
    //Change into Drop Down meny
    self.fuelTypeLabel = [[UILabel alloc] init];
    self.fuelTypeLabel.textColor = [UIColor blackColor];
    self.fuelTypeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.fuelTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.fuelTypeLabel.text = @"Гориво тип:";
    [gazFormView addSubview:self.fuelTypeLabel];
    
    self.fuelTypeTextField = [[UITextField alloc] init];
    [self.fuelTypeTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.fuelTypeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.fuelTypeTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.fuelTypeTextField];
    //-------------------------------------------------------------------------------
    
    
    self.gasStationLabel = [[UILabel alloc] init];
    self.gasStationLabel.textColor = [UIColor blackColor];
    self.gasStationLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.gasStationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.gasStationLabel.text = @"Бензиностанция:";
    [gazFormView addSubview:self.gasStationLabel];
    
    self.gasStationTextField = [[UITextField alloc] init];
    [self.gasStationTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.gasStationTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.gasStationTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.gasStationTextField];
    
    self.gasNotesLabel = [[UILabel alloc] init];
    self.gasNotesLabel.textColor = [UIColor blackColor];
    self.gasNotesLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.gasNotesLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.gasNotesLabel.text = @"Забележка:";
    [gazFormView addSubview:self.gasNotesLabel];
    
    self.gasNotesTextField = [[UITextField alloc] init];
    [self.gasNotesTextField setBorderStyle:UITextBorderStyleRoundedRect];
    //[self.dateTextField setDelegate:self];
    self.gasNotesTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.gasNotesTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [gazFormView addSubview: self.gasNotesTextField];
    
    
    
    //Main formLabel
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-120-[formLabel(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(formLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[formLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(formLabel)]];
    
    //Date label and textField
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[dateLabel(120)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dateLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[dateLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dateLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-18-[datePicker(320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(datePicker)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-85-[datePicker]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(datePicker)]];
    
    //Total cost, fuel price and liters labels
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-22-[totalCostLabel(80)]-10-[fuelPriceLabel(90)]-10-[litersLabel(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(totalCostLabel, fuelPriceLabel, litersLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-310-[totalCostLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(totalCostLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-310-[fuelPriceLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fuelPriceLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-310-[litersLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(litersLabel)]];
    
    
    //Total cost, fuel price and liters textField
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[totalCostTextField(80)]-10-[fuelPriceTextField(90)]-10-[litersTextField(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings( totalCostTextField, fuelPriceTextField, litersTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-335-[totalCostTextField(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(totalCostTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-335-[fuelPriceTextField(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fuelPriceTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-335-[litersTextField(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(litersTextField)]];
    
    //Odometer label and textfield
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-22-[odometerLabel(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(odometerLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-360-[odometerLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(odometerLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[odometerTextField(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(odometerTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-385-[odometerTextField(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(odometerTextField)]];
    
    //fuel tupe and gas station
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-22-[fuelTypeLabel(80)]-30-[gasStationLabel(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fuelTypeLabel, gasStationLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-410-[fuelTypeLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fuelTypeLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-410-[gasStationLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(gasStationLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-22-[fuelTypeTextField(80)]-30-[gasStationTextField(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fuelTypeTextField, gasStationTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-435-[fuelTypeTextField(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(fuelTypeTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-435-[gasStationTextField(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(gasStationTextField)]];
    
    //Notes
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-22-[gasNotesLabel(80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(gasNotesLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-460-[gasNotesLabel(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(gasNotesLabel)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-20-[gasNotesTextField(280)]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(gasNotesTextField)]];
    [gazFormView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-485-[gasNotesTextField(60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(gasNotesTextField)]];
    
    //VERY IMPORTANT FOR THE PROPER FUNCTIONALITY OF RDVKeyboardAvoidingScrollView
    [gazFormView setContentSize:CGSizeMake(gazFormFrame.size.width, CGRectGetMaxY(self.gasNotesTextField.frame) + 	55)];
    
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
        
       /* if (self.fuelTypeTextField.text.length != 0)*/ newRefueling.fuelType = @"A95";//da se prepravi!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! spisuk @"95, 95+, 98, 98+, diesel, gaz4iza, metan4e i t.n"
       /* if (self.gasStationTextField.text.length != 0) */newRefueling.refuelingGasStation = @"Lukoil";///!!!!!!!!!!!!!!!!!!    i tva da se napravi sys spisuk ot WS sa6o
        newRefueling.fullTank = @(1);//da se sloji checkboX
        
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
