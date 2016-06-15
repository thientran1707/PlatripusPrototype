//
//  MoreFilterViewController.h
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/14/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreFilterViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *transportTextField;
@property (weak, nonatomic) IBOutlet UIButton *activityTextField;
@property (weak, nonatomic) IBOutlet UIView *modalView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end
