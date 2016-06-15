//
//  FullItineraryViewController.m
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/12/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

#import "FullItineraryViewController.h"

@interface FullItineraryViewController()

@property (nonatomic, strong) NSDictionary *fullItineraryData;
@property (nonatomic, strong) NSDictionary *itineraryPictures;

@property (nonatomic, strong) UILabel *totalExpenditureLabel;
@property (nonatomic, strong) UIButton *updateExpenditureButton;

@end

@implementation FullItineraryViewController

- (NSDictionary *)itineraryPictures {
    if (!_itineraryPictures) {
        _itineraryPictures = @{@"4 Days Trip in San Francisco": @"trip1"};
    }
    return _itineraryPictures;
}

- (float) totalExpenditure {
    if (!_totalExpenditure) {
        _totalExpenditure = 0.0f;
    }
    return _totalExpenditure;
}

- (NSDictionary *)fullItineraryData {
    if (!_fullItineraryData) {
        _fullItineraryData = @{@"4 Days Trip in San Francisco":
                                   @[
                                       @{@"Day 1: Golden Gate Bridge":@[
                                                 @"0900 - 1100 : 🌿 Golden Gate Park",
                                                 @"1200 - 1300 : 🎢 Golden Gate Bridge",
                                                 @"1300 - 1500 : 🏃 Sutro Baths",
                                                 @"1500 - 1700 : 🌅 Ocean Beach",
                                                 @"1900 - 2000 : 🍽 Cliff House"
                                                 ]},
                                       @{@"Day 2: San Francisco":@[
                                                 @"0900 - 1100 : 🎢 Lombard Street",
                                                 @"1200 - 1300 : 👜 Fisherman's Wharf",
                                                 @"1300 - 1500 : 🌿 Golden Gate Park",
                                                 @"1500 - 1700 : 🏛 Academy of Sciences",
                                                 @"1900 - 2000 : 🖼 Painted Ladies"
                                                 ]},
                                       @{@"Day 3: Yosemite":@[
                                                 @"0900 - 1100 : 🖼 Tunnel View",
                                                 @"1200 - 1300 : 🌿 Bridalveil Falls",
                                                 @"1300 - 1500 : 🏃 Yosemite Falls",
                                                 @"1500 - 1700 : 🏃 Vernal Falls Trail",
                                                 @"1900 - 2000 : 🖼 Valley View"
                                                 ]}
                                    ]
                               };
    }
    return _fullItineraryData;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"Full Itinerary";
    
    // setup tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    
    [self.view addSubview:self.tableView];
    
    // setup total expenditure view
    self.totalExpenditureLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, self.view.frame.size.height - 120 + 20, 320-16-16, 24)];
    self.totalExpenditureLabel.text = [NSString stringWithFormat:@"Current Total Spending: $%.02f", self.totalExpenditure];
    self.totalExpenditureLabel.textAlignment = NSTextAlignmentCenter;
    self.totalExpenditureLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:17.0];
    
    self.updateExpenditureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.updateExpenditureButton setFrame:CGRectMake(0, self.totalExpenditureLabel.frame.size.height + self.totalExpenditureLabel.frame.origin.y + 16, 220, 30)];
    self.updateExpenditureButton.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:44.0/255.0 blue:67.0/255.0 alpha:1.0];
    [self.updateExpenditureButton setTitle:@"Record New Expenditure" forState:UIControlStateNormal];
    CGPoint centerPoint = self.view.center;
    [self.updateExpenditureButton setCenter:CGPointMake(centerPoint.x, self.updateExpenditureButton.center.y)];
    [self.updateExpenditureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.updateExpenditureButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.updateExpenditureButton.layer.shadowOffset = CGSizeZero;
    self.updateExpenditureButton.layer.shadowOpacity = 0.6;
    self.updateExpenditureButton.layer.shadowRadius = 3.0;
    
    [self.view addSubview:self.totalExpenditureLabel];
    [self.view addSubview:self.updateExpenditureButton];
}

#pragma mark tableview datasource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.fullItineraryData[self.tripTitle] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.fullItineraryData[self.tripTitle][section] allValues] firstObject] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [[self.fullItineraryData[self.tripTitle][indexPath.section] allValues] firstObject][indexPath.row];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 175+20+8+8+45+8; // red header plus title + picture
    } else {
        return 45+8; // red header
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView;
    if (section == 0) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 175+20+8+8+45+8)];
        // setup itinerary title and picture
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 320-8-8, 20)];
        titleLabel.text = self.tripTitle;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont fontWithName:@"AvenirNext-Bold" size:17.0];
        
        [headerView addSubview:titleLabel];
        
        UIImageView *tripImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height + titleLabel.frame.origin.y + 8, self.view.frame.size.width, 175)];
        [tripImage setImage:[UIImage imageNamed:self.itineraryPictures[self.tripTitle]]];
        
        [headerView addSubview:tripImage];
    } else {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45+8)];
    }
    
    UILabel *sectionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height - (45+8), 320, 45+8)];
    NSString *paddedString = [NSString stringWithFormat:@"   %@",[[self.fullItineraryData[self.tripTitle][section] allKeys] firstObject]];
    sectionHeader.text = paddedString;
    sectionHeader.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:44.0/255.0 blue:67.0/255.0 alpha:1.0];
    sectionHeader.textColor = [UIColor whiteColor];
    sectionHeader.font = [UIFont fontWithName:@"AvenirNext-Bold" size:15.0];
    
    [headerView addSubview:sectionHeader];
    return headerView;
}

@end
