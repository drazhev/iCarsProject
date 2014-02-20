//
//  MMChartsViewController.m
//  iCars
//
//  Created by Emilian Parvanov on 2/15/14.
//  Copyright (c) 2014 MMA. All rights reserved.
//

#import "MMChartsViewController.h"


@interface MMChartsViewController ()<UITableViewDataSource, UITableViewDelegate>{
    int numFuels;
    float a95qty;
    float a95PLUSqty;
    float a98qty;
    float a98PLUSqty;
    float dieselQty;
    float lpgQty;
    float cngQty;
}

@property(nonatomic, strong)Car* carToEdit;

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) NSArray* viewControllersContainer;

@property(nonatomic, strong)UITableView *colorStatsTableView;





@end

@implementation MMChartsViewController
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@synthesize optionIndices, viewControllersContainer;
@synthesize carToEdit;
@synthesize colorStatsTableView;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithCar:(Car*)car
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"Диаграми";
        carToEdit = car;
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - ConfigureTableView
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numFuels;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row selected");
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 22;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"color";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"color" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSArray* colorContainer = [[NSArray alloc] initWithObjects:[UIColor lightGrayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor yellowColor], [UIColor purpleColor], [UIColor  brownColor], nil];
    
    NSArray* qties = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%f", a95qty], [NSString stringWithFormat:@"%f", a95PLUSqty], [NSString stringWithFormat:@"%f", a98qty],
                      [NSString stringWithFormat:@"%f", a98PLUSqty], [NSString stringWithFormat:@"%f", dieselQty], [NSString stringWithFormat:@"%f", lpgQty], [NSString stringWithFormat:@"%f", cngQty], nil];
    

    
    if (![[qties objectAtIndex:indexPath.row] isEqualToString:@"0.000000"]) {
        cell.backgroundColor = [colorContainer objectAtIndex:indexPath.row];
        cell.textLabel.text = [qties objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(NSArray*)refuelingEntities{
    
    MMAppDelegate* appDelegate = (MMAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSFetchRequest* requestRefuelings = [[NSFetchRequest alloc] initWithEntityName:@"Refueling"];
    requestRefuelings.predicate = [NSPredicate predicateWithFormat: @"car = %@", carToEdit];
    NSSortDescriptor* sortByDate = [[NSSortDescriptor alloc] initWithKey:@"refuelingDate" ascending:NO];
    requestRefuelings.sortDescriptors = @[sortByDate];
    NSError *errorRefuelings;
    return [[appDelegate.managedObjectContext executeFetchRequest:requestRefuelings error:&errorRefuelings] mutableCopy];
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)loadView{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIScrollView *newCarView = [[RDVKeyboardAvoidingScrollView alloc] initWithFrame:applicationFrame];
    [newCarView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [newCarView setBackgroundColor:[UIColor whiteColor]];
    [newCarView setAlwaysBounceVertical:YES];
    [newCarView setAlwaysBounceHorizontal:NO];
    [newCarView setScrollEnabled:YES];
    
    NSMutableArray* a95 = [[NSMutableArray alloc] init];
    NSMutableArray* a95plus = [[NSMutableArray alloc] init];
    NSMutableArray* a98 = [[NSMutableArray alloc] init];
    NSMutableArray* a98plus = [[NSMutableArray alloc] init];
    NSMutableArray* diesel = [[NSMutableArray alloc] init];
    NSMutableArray* lpg = [[NSMutableArray alloc] init];
    NSMutableArray* cng = [[NSMutableArray alloc] init];
    
    numFuels = 0;
    
    for (Refueling* refueling in self.refuelingEntities) {
        
        if ([refueling.fuelType isEqualToString:@"A95"]) {
            [a95 addObject: refueling];
            a95qty += [refueling.refuelingQantity integerValue];
            
        }
        else if ([refueling.fuelType isEqualToString:@"A95+"]){
            [a95plus addObject: refueling];
            a95PLUSqty += [refueling.refuelingQantity integerValue];
        }
        else if ([refueling.fuelType isEqualToString:@"A98"]){
            [a98 addObject: refueling];
            a98qty += [refueling.refuelingQantity integerValue];
        }
        else if ([refueling.fuelType isEqualToString:@"A98+"]){
            [a98plus addObject: refueling];
            a98PLUSqty += [refueling.refuelingQantity integerValue];
        }
        else if ([refueling.fuelType isEqualToString:@"Diesel"]){
            [diesel addObject: refueling];
            dieselQty += [refueling.refuelingQantity integerValue];
        }
        else if ([refueling.fuelType isEqualToString:@"LPG"]){
            [lpg addObject: refueling];
            lpgQty += [refueling.refuelingQantity integerValue];
        }
        else if ([refueling.fuelType isEqualToString:@"CNG"]){
            [cng addObject: refueling];
            cngQty += [refueling.refuelingQantity integerValue];
        }
    }
    if([a95 count] != 0) numFuels++;
    if([a95plus count] != 0) numFuels++;
    if([a98 count] != 0) numFuels++;
    if([a98plus count] != 0) numFuels++;
    if([diesel count] != 0) numFuels++;
    if([lpg count] != 0) numFuels++;
    if([cng count] != 0) numFuels++;
    
    NSLog(@"A95: %lu", (unsigned long)[a95 count]);
    NSLog(@"A95+: %lu", (unsigned long)[a95plus count]);
    NSLog(@"A98: %lu", (unsigned long)[a98 count]);
    NSLog(@"A98+: %lu", (unsigned long)[a98plus count]);
    NSLog(@"diesel: %lu", (unsigned long)[diesel count]);
    NSLog(@"lpg: %lu", (unsigned long)[lpg count]);
    NSLog(@"cng: %lu", (unsigned long)[cng count]);
    
    NSLog(@"broi goriva %d", numFuels);
    
    
    
    

    
    CGFloat obshtoRefuelings = a95qty + a95PLUSqty + a98qty + a98PLUSqty + dieselQty + lpgQty + cngQty;
    
    CGFloat a95percent = a95qty / obshtoRefuelings * 100;
    CGFloat a95plusPercent = a95PLUSqty / obshtoRefuelings * 100;
    CGFloat a98Perc = a98qty / obshtoRefuelings * 100;
    CGFloat a98plusPerc = a98PLUSqty / obshtoRefuelings * 100;
    CGFloat dieselPerc = dieselQty / obshtoRefuelings * 100;
    CGFloat lpgPerc = lpgQty / obshtoRefuelings * 100;
    CGFloat cngPerc = cngQty / obshtoRefuelings * 100;
    
    
    
    
    PieView* pieView = [[PieView alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height/2)];
    pieView.sliceValues = [NSArray arrayWithObjects:@(a95percent), @(a95plusPercent), @(a98Perc), @(a98plusPerc), @(dieselPerc),  @(lpgPerc), @(cngPerc), nil];
    
    [newCarView addSubview:pieView];
    
    self.colorStatsTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, applicationFrame.size.height/2, applicationFrame.size.width, applicationFrame.size.height/2)];
    [self.colorStatsTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.colorStatsTableView setBackgroundColor:[UIColor clearColor]];
    [self.colorStatsTableView setDataSource: self];
    [self.colorStatsTableView setDelegate: self];
    [self.colorStatsTableView registerClass:[MMCarCustomCellTableView class] forCellReuseIdentifier:@"color"];
    
    [newCarView addSubview: self.colorStatsTableView];
    
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *hamburger = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger_logo"]style: UIBarButtonItemStyleBordered target:self action:@selector(showHamburger:)];
    [self.navigationItem setLeftBarButtonItem:hamburger];
    
    self.view = newCarView;
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void)showHamburger:(id)sender{
    NSLog(@"menu");
    NSArray *images = @[
                        [UIImage imageNamed:@"back_logo.jpg"],
                        [UIImage imageNamed:@"refueling_logo.png"],
                        [UIImage imageNamed:@"refueling-pin_logo.png"],
                        [UIImage imageNamed:@"oilChange_logo.jpg"],
                        [UIImage imageNamed:@"services_logo.jpg"],
                        [UIImage imageNamed:@"services-pin_logo.jpg"],
                        [UIImage imageNamed:@"reminders_logo.jpg"],
                        [UIImage imageNamed:@"expenses_logo.png"],
                        [UIImage imageNamed:@"insurance_logo.png"],
                        [UIImage imageNamed:@"insurance-pin_logo.png"],
                        [UIImage imageNamed:@"summary_logo.png"],
                        [UIImage imageNamed:@"charts_logo.png"]];
    
    //RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //callout.showFromRight = YES;
    [callout show];
    
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - RNFrostedSidebarDelegate
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    //NSLog(@"Tapped item at index %i",index);
    Class vcClass = NSClassFromString([self.viewControllersContainer objectAtIndex:index]);
    id someVC = [[vcClass alloc] initWithCar:carToEdit];
    [self.navigationController pushViewController:someVC animated:YES];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Data CONFIG
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[[self navigationController] navigationBar] setTranslucent:NO];
    self.optionIndices = [NSMutableIndexSet indexSetWithIndex:1];
    
    self.viewControllersContainer = [NSArray arrayWithObjects: @"MMCarMenuViewController",
                                     @"MMGasolineViewController",
                                     @"MMGasStationsViewController",
                                     @"MMOilViewController",
                                     @"MMServicesViewController",
                                     @"MMServicesMapViewController",
                                     @"MMRemindersViewController",
                                     @"MMExpensesViewController",
                                     @"MMInsurancesViewController",
                                     @"MMInsuranceOfficesViewController",
                                     @"MMSummaryViewController",
                                     @"MMChartsViewController",nil];
}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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