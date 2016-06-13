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

@end

@implementation FullItineraryViewController


- (NSDictionary *)fullItineraryData {
    if (!_fullItineraryData) {
        _fullItineraryData = @{};
    }
    return _fullItineraryData;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Full Itinerary";
    
    // setup tableview
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 120) style:UITableViewStyleGrouped];
    
    
}

#pragma mark tableview datasource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
