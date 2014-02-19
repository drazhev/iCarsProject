//
//  MMNewReminderViewController.m
//  iCars
//
//  Created by Alexandar Drajev on 2/19/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMNewReminderViewController.h"

@interface MMNewReminderViewController ()

@property(nonatomic, strong) UIScrollView* reminderScrollView;
@property (nonatomic, strong) NSArray* reminderTypes;


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

- (id)initWithNibName:(NSString*) nibName details: (NSString*) details {
    self = [super initWithNibName:nibName bundle:nil];
    if (self) {
        self.reminderTypes = @[@"OilChange", @"Tax", @"Service", @"Insurance"];
        self.detailsTextField.text = details;
        [self.typePickerView selectRow:2 inComponent:0 animated:NO];
        
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
- (IBAction)typeButtonTapped:(id)sender {
    self.detailsTextField.hidden = self.typePickerView.hidden ? YES : NO;
    self.typePickerView.hidden = self.typePickerView.hidden ? NO : YES;
    [self.view endEditing:YES];
    self.datePicker.hidden = YES;
}

- (IBAction)dateButtonTapped:(id)sender {
    self.detailsTextField.hidden = self.datePicker.hidden ? YES : NO;
    self.datePicker.hidden = self.datePicker.hidden ? NO : YES;
    [self.view endEditing:YES];
    self.typePickerView.hidden = YES;

}

//-(void)loadView {
////    CGRect applicationFrame = [self getScreenFrameForCurrentOrientation];
////    self.reminderScrollView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:applicationFrame];
////    [self.reminderScrollView setBackgroundColor:[UIColor whiteColor]];
////    [self.reminderScrollView setAlwaysBounceVertical:YES];
////    [self.reminderScrollView setAlwaysBounceHorizontal:NO];
////    [self.reminderScrollView setScrollEnabled:YES];
//    
//
//    
//    
//    
//    //self.view = self.reminderScrollView;
//}

-(void)saveReminder: (id)sender {
    
    if (self.detailsTextField.text.length == 0){
        UIAlertView *notEnoughInfo = [[UIAlertView alloc] initWithTitle:@"Недостатъчна информация!" message:@"Моля, въведете детайли!"delegate:sender cancelButtonTitle:@"Опитайте отново" otherButtonTitles:nil];
        [notEnoughInfo show];
    }
    else{
        
        
        MMAppDelegate* appDelegate = (MMAppDelegate*)[[UIApplication sharedApplication] delegate];
        Reminder* newReminder = [NSEntityDescription insertNewObjectForEntityForName:@"Reminder" inManagedObjectContext:appDelegate.managedObjectContext];
        
        newReminder.reminderDate = self.datePicker.date;
        newReminder.reminderDetails = self.detailsTextField.text;
        newReminder.reminderOdometer = [NSNumber numberWithInt: [self.odometerTextField.text intValue]];
        newReminder.reminderType = [self.reminderTypes objectAtIndex:[self.typePickerView selectedRowInComponent:0]];
        
        newReminder.car = self.carToEdit;
        
        
        
        // Save the object to managedObjectContext
        NSError* newReminderError = nil;
        if (![appDelegate.managedObjectContext save:&newReminderError]) {
            NSLog(@"New Reminder ERROR: %@ %@", newReminderError, [newReminderError localizedDescription]);
        }
        else{
            NSLog(@"dobavihte novo zarejdane");
        }
        
        NSError *error01 = nil;
        // Save the object to persistent store
        if (![appDelegate.managedObjectContext save:&error01]) {
            NSLog(@"Can't Save! %@ %@", error01, [error01 localizedDescription]);
        }
        
        
        MMRemindersViewController* remindersVC = [[MMRemindersViewController alloc] initWithCar:self.carToEdit];
        [self.navigationController pushViewController:remindersVC animated:YES];
    }
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
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.reminderTypes.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //set item per row
    return [self.reminderTypes objectAtIndex:row];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGPoint touchLocation = [touch locationInView:self.view];
    if (!self.typePickerView.hidden && CGRectContainsPoint(self.typePickerView.frame, touchLocation)) return NO;
    if (!self.datePicker.hidden && CGRectContainsPoint(self.datePicker.frame, touchLocation)) return NO;
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"New reminder";
    self.reminderTypes = @[@"OilChange", @"Tax", @"Service", @"Insurance"];
    self.typePickerView.delegate = self;
	// Do any additional setup after loading the view.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleBordered target:self action:@selector(saveReminder:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedScreen:)];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown) name:UIKeyboardWillShowNotification object:nil];
    
    [self.datePicker addTarget:self action:@selector(datePickerValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.typeLabel setTitle:self.reminderTypes[0] forState:UIControlStateNormal];
    
    NSString* dateString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    dateString = [formatter stringFromDate:self.datePicker.date];
    [self.dateLabel setTitle:dateString forState:UIControlStateNormal];
    
}

-(void)datePickerValueChanged {
    NSString* dateString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    dateString = [formatter stringFromDate:self.datePicker.date];
    [self.dateLabel setTitle:dateString forState:UIControlStateNormal];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.typeLabel setTitle:self.reminderTypes[row] forState:UIControlStateNormal];
}


-(void)keyboardShown {
    self.datePicker.hidden = YES;
    self.typePickerView.hidden = YES;
    self.detailsTextField.hidden = NO;
    
}

-(void) tappedScreen: (id) sender {
    self.datePicker.hidden = YES;
    self.typePickerView.hidden = YES;
    self.detailsTextField.hidden = NO;
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
