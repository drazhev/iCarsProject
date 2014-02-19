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
@interface MMNewOilChangeViewController ()<UITextFieldDelegate, /*UIPickerViewDelegate, UIPickerViewDataSource,*/ UIActionSheetDelegate, UIGestureRecognizerDelegate>{
    //UIScrollView *newCarView;
    BOOL isDatePickerViewDrop;
}

@property(nonatomic, strong)Car* carToEdit;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
//--------------------------------------------------------------
@property (nonatomic, strong) UILabel *formLabel;
@property (nonatomic, strong) UITextField *dateTextField;
@property (nonatomic, strong) UILabel *totalCostLabel;
@property (nonatomic, strong) UITextField *totalCostTextField;
@property (nonatomic, strong) UILabel *litersLabel;
@property (nonatomic, strong) UITextField *litersTextField;
@property (nonatomic, strong) UILabel *odometerLabel;
@property (nonatomic, strong) UITextField *odometerTextField;
@property (nonatomic, strong) UILabel *nextChangeLabel;
@property (nonatomic, strong) UITextField *nextChangeTextField;
@property (nonatomic, strong) UILabel *changeLocationLabel;
@property (nonatomic, strong) UITextField *changeLocationTextField;
@property (nonatomic, strong) UIButton *datePickerButton;

@property (strong, nonatomic, getter = theNewOilChangeView) UIScrollView *newOilChangeView;
//-----------------------------------------------------------------

@property (nonatomic) UIButton *increaseButton;
@property (nonatomic) UIButton *decreaseButton;



@end
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@implementation MMNewOilChangeViewController
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@synthesize carToEdit;
@synthesize formLabel, dateLabel, totalCostLabel, nextChangeLabel, litersLabel, odometerLabel, changeLocationLabel;
@synthesize dateTextField, totalCostTextField, nextChangeTextField, litersTextField, odometerTextField, changeLocationTextField;
@synthesize datePickerButton, datePicker, newOilChangeView;

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = [NSString stringWithFormat:@"oil change %@", car.licenseTag];
        carToEdit = car;
        isDatePickerViewDrop = NO;
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)loadView{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    newOilChangeView = [[RDVKeyboardAvoidingScrollView alloc]initWithFrame:applicationFrame];
    [newOilChangeView setBackgroundColor:[UIColor whiteColor]];
    [newOilChangeView setAlwaysBounceVertical:YES];
    [newOilChangeView setAlwaysBounceHorizontal:NO];
    [newOilChangeView setScrollEnabled:YES];
    
    //-----------------------------------------------------------
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (applicationFrame.size.width / 4), 20)];
    self.dateLabel.textColor = [UIColor blackColor];
    self.dateLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.dateLabel.text = @"Дата на смяна:";
    [self.newOilChangeView addSubview:self.dateLabel];
    
    self.datePickerButton = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(self.formLabel.frame) + 10, 400, 25)];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd' 'MMMM' 'yyyy"];
    NSString *formattedDate = [formatter stringFromDate:[NSDate date]];
    [self.datePickerButton setTitle: [NSString stringWithFormat:@"%@", formattedDate] forState: UIControlStateNormal];
    [self.datePickerButton setTitle: @"Изберете" forState: UIControlStateApplication];
    [self.datePickerButton setTitle: @"Изберете" forState: UIControlStateHighlighted];
    [self.datePickerButton setTitle: @"Изберете" forState: UIControlStateSelected];
    [self.datePickerButton setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    self.datePickerButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
    [self.datePickerButton addTarget:self action: @selector(chooseDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.newOilChangeView addSubview:self.datePickerButton];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dateTextField.frame) + 10, applicationFrame.size.width, 0)];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.totalCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.dateLabel.frame) +10, 90, 25)];
    self.totalCostLabel.textColor = [UIColor blackColor];
    self.totalCostLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.totalCostLabel.text = @"Крайна цена:";
    [self.newOilChangeView addSubview:self.totalCostLabel];
    
    self.totalCostTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.totalCostLabel.frame) + 5, applicationFrame.size.width/4, 20)];
    [self.totalCostTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.totalCostTextField setDelegate:self];
    //self.totalCostTextField.backgroundColor = [UIColor redColor];
    self.totalCostTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.newOilChangeView addSubview: self.totalCostTextField];
    
    self.litersLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.totalCostLabel.frame) + 10, CGRectGetMaxY(self.dateLabel.frame) +10, applicationFrame.size.width /3, 25)];
    self.litersLabel.textColor = [UIColor blackColor];
    self.litersLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.litersLabel.text = @"Литри:";
    [self.newOilChangeView addSubview:self.litersLabel];
    
    self.litersTextField = [[UITextField alloc] initWithFrame:CGRectMake(litersLabel.frame.origin.x -20 , litersLabel.frame.origin.y + litersLabel.frame.size.height + 5, 150, 25)];
    NSLog(@"{{%.1f : %.1f} {%.1f : %.1f}}", litersTextField.frame.origin.x, litersTextField.frame.origin.y, litersTextField.frame.size.width, litersTextField.frame.size.height);
    self.litersTextField.text = @"0.0";
    [self.litersTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.dateTextField setDelegate:self];
    self.litersTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.newOilChangeView addSubview: self.litersTextField];
    
    self.increaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.increaseButton setTitle:@"▲" forState:UIControlStateNormal];
    self.increaseButton.frame = CGRectMake(200, CGRectGetMaxY(litersTextField.frame ), 20, 20);
    //self.increaseButton.layer.borderWidth = 0.5;
    //self.increaseButton.layer.cornerRadius = 3;
    //self.increaseButton.backgroundColor = [UIColor redColor];
    [self.increaseButton addTarget:self
                            action:@selector(increaseLitters)
                  forControlEvents:UIControlEventTouchDown];
    [self.newOilChangeView addSubview:self.increaseButton];
    
    self.decreaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.decreaseButton setTitle:@"▼" forState:UIControlStateNormal];
    self.decreaseButton.frame = CGRectMake(232, 70, 20, 20);
    //self.decreaseButton.layer.borderColor = [UIColor greenColor].CGColor;
    //self.increaseButton.layer.borderWidth = 0.5;
    //self.decreaseButton.layer.cornerRadius = 3;
    //self.decreaseButton.backgroundColor = [UIColor redColor];
    [self.decreaseButton addTarget:self
                            action:@selector(decreaseLitters)
                  forControlEvents:UIControlEventTouchDown];
    [self.newOilChangeView addSubview:self.decreaseButton];
    
    self.odometerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.totalCostTextField.frame) + 10, CGRectGetMaxY(self.totalCostTextField.frame), 25)];
    self.odometerLabel.textColor = [UIColor blackColor];
    self.odometerLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.odometerLabel.text = @"Километраж:";
    [self.newOilChangeView addSubview:self.odometerLabel];
    
    self.odometerTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.odometerLabel.frame) + 10, (applicationFrame.size.width - 60) / 2, 25)];
    [self.odometerTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.dateTextField setDelegate:self];
    self.odometerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.newOilChangeView addSubview: self.odometerTextField];
    
    
    self.nextChangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.litersLabel.frame.origin.x + 20, CGRectGetMaxY(totalCostTextField.frame) + 10, (applicationFrame.size.width - 60) / 2, 25)];
    self.nextChangeLabel.textColor = [UIColor blackColor];
    //self.nextChangeLabel.backgroundColor = [UIColor redColor];
    self.nextChangeLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.nextChangeLabel.text = @"Следваща смяна:";
    [self.newOilChangeView addSubview:self.nextChangeLabel];
    
    self.nextChangeTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.nextChangeLabel.frame.origin.x + 20, (litersLabel.frame.origin.y + 100 ), nextChangeLabel.frame.size.width, 25)];
    [self.nextChangeTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.dateTextField setDelegate:self];
    self.nextChangeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.newOilChangeView addSubview: self.nextChangeTextField];
    
    self.changeLocationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.odometerTextField.frame) + 10, (applicationFrame.size.width / 4) + 8, 20)];
    self.changeLocationLabel.textColor = [UIColor blackColor];
    self.changeLocationLabel.font = [UIFont fontWithName:@"Arial" size:12];
    self.changeLocationLabel.text = @"Сервиз:";
    [self.newOilChangeView addSubview:self.changeLocationLabel];
    
    self.changeLocationTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.changeLocationLabel.frame) + 10, (applicationFrame.size.width / 4) + 8, 20 )];
    [self.changeLocationTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.dateTextField setDelegate:self];
    self.changeLocationTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.newOilChangeView addSubview: self.changeLocationTextField];
    
    //-------------------------------------------------------------------------------
    
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
-(void) addNewOilChange:(id)sender{
    MMOilViewController *oilFormViewController = [[MMOilViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:oilFormViewController animated:YES];
    
    NSLog(@"This is gaz form.");
    
}

-(void) increaseLitters{
    
    NSString *inputData = self.litersTextField.text;
    float inputLiters = [inputData floatValue];
    if(inputLiters < 10) self.litersTextField.text = [NSString stringWithFormat:@"%.1f", inputLiters + 0.5];
    
}

-(void) decreaseLitters{
    NSString *inputData = self.litersTextField.text;
    float inputLiters = [inputData floatValue];
    if(inputLiters > 0) self.litersTextField.text = [NSString stringWithFormat:@"%.1f", inputLiters - 0.5];
}

-(void)chooseDate:(id)sender{
    
    if (!isDatePickerViewDrop) {
        //[self.datePicker reloadData];
        [UIView animateWithDuration:0.01 animations:^{
            self.datePicker.frame = CGRectMake(0, CGRectGetMaxY(self.dateTextField.frame) + 30, 320, 150);
            self.datePicker.hidden = NO;
            [newOilChangeView addSubview:datePicker];
            self.totalCostLabel.hidden = YES;
             self.totalCostTextField.hidden = YES;
             self.litersLabel.hidden = YES;
             self.litersTextField.hidden = YES;
             self.odometerLabel.hidden = YES;
             self.odometerTextField.hidden = YES;
             self.nextChangeLabel.hidden = YES;
             self.nextChangeTextField.hidden = YES;
             self.increaseButton.hidden = YES;
            self.decreaseButton.hidden = YES;
             [self.view endEditing:YES];
            
        } completion:^(BOOL finished) {
            //[self.view reloadData];
            NSLog(@"poqvi se");
        }];
    }
    else{
        [UIView animateWithDuration:0.01 animations:^{
            self.datePicker.frame = CGRectMake(0, CGRectGetMaxY(self.dateTextField.frame) + 10, 0, 0);
            self.datePicker.hidden = YES;
            self.totalCostLabel.hidden = NO;
            self.totalCostTextField.hidden = NO;
            self.litersLabel.hidden = NO;
            self.litersTextField.hidden = NO;
            self.odometerLabel.hidden = NO;
            self.odometerTextField.hidden = NO;
            self.nextChangeLabel.hidden = NO;
            self.nextChangeTextField.hidden = NO;
            self.increaseButton.hidden = NO;
            self.decreaseButton.hidden = NO;
             NSLog(@"pribra se ");
            
        }];
    }
    isDatePickerViewDrop = !isDatePickerViewDrop;
    
}

-(void)showDatePicker:(id)sender
{
    
    UIDatePicker* picker = [[UIDatePicker alloc] init];
    picker.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    picker.datePickerMode = UIDatePickerModeDate;
    
    [picker addTarget:self action:@selector(dueDateChanged:) forControlEvents:UIControlEventValueChanged];
    CGSize pickerSize = [picker sizeThatFits:CGSizeZero];
    picker.frame = CGRectMake(0.0, 35, pickerSize.width, 150);
    picker.backgroundColor = [UIColor blackColor];
    [self.view addSubview:picker];
    
}

-(void) dueDateChanged:(UIDatePicker *)sender {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"dd' 'MMMM' 'yyyy"];
    [self.datePickerButton setTitle:[NSString stringWithFormat:@"%@", [formatter stringFromDate:self.datePicker.date]] forState:UIControlStateNormal ];
    //return [NSString stringWithFormat:@"Picked the date %@", [dateFormatter stringFromDate:[sender date]]];
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



@end
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------