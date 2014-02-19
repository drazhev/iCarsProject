//
//  MMNewInsuranceViewController.m
//  iCars
//
//  Created by Emilian Parvanov on 2/19/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMNewInsuranceViewController.h"

@interface MMNewInsuranceViewController ()

@property(nonatomic, strong)Car* carToEdit;

@end

@implementation MMNewInsuranceViewController

@synthesize carToEdit;

- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"new ins %@", car.licenseTag];
        carToEdit = car;
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)loadView{
    CGRect newInsFrame = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *newInsView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:newInsFrame];
    [newInsView setBackgroundColor:[UIColor whiteColor]];
    [newInsView setAlwaysBounceVertical:YES];
    [newInsView setAlwaysBounceHorizontal:NO];
    [newInsView setScrollEnabled:YES];
    


    
    
    
    
    
    //VERY IMPORTANT FOR THE PROPER FUNCTIONALITY OF RDVKeyboardAvoidingScrollView
   // [gazFormView setContentSize:CGSizeMake(gazFormFrame.size.width, CGRectGetMaxY(self.gasStationTextField.frame) + 65)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleBordered target:self action:@selector(saveInsurance:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    self.view = newInsView;
}
-(void)saveInsurance:(id)sender{
    NSLog(@"zastrahovka");
  /*  if (self.totalCostTextField.text.length == 0 || self.fuelPriceTextField.text.length == 0 || self.odometerTextField.text.length == 0) {
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
        
        // if (self.fuelTypeTextField.text.length != 0) newRefueling.fuelType = self.fuelTypeTextField.text;;//da se prepravi!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! spisuk @"95, 95+, 98, 98+, diesel, gaz4iza, metan4e i t.n"
        // if (self.gasStationTextField.text.length != 0) newRefueling.refuelingGasStation = self.gasStationTextField.text;
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
        */
    
        
        MMInsurancesViewController* insuranceVC = [[MMInsurancesViewController alloc] initWithCar:carToEdit];
        [self.navigationController pushViewController:insuranceVC animated:YES];
        
        
        
        
        
    //}
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
