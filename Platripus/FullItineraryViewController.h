//
//  FullItineraryViewController.h
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/12/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullItineraryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end
