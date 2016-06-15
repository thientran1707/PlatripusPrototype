//
//  MoreFilterViewController.m
//  Platripus
//
//  Created by Leonardo Sjahputra on 6/14/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

#import "MoreFilterViewController.h"

@implementation MoreFilterViewController


NSArray *activityChoices;
NSArray *transportChoices;
BOOL transportTapped;

- (void) viewDidLoad {
    [super viewDidLoad];
    
    transportChoices = @[@"Drive", @"Walk", @"Transit"];
    [self.transportTextField setTitle:[transportChoices firstObject] forState:UIControlStateNormal];
    self.transportTextField.layer.borderWidth = 1.0;
    self.transportTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.transportTextField.layer.cornerRadius = 4.0;
    self.transportTextField.clipsToBounds = YES;
    [self.transportTextField addTarget:self action:@selector(transportTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    activityChoices = @[@"🖼 Sightseeing", @"🌿 Nature", @"🍽 Food", @"🏃 Hiking", @"🏛 Museums", @"🚴 Sports", @"👯 Shows", @"🎢 Tourist Attractions", @"👜 Shopping"];
    [self.activityTextField setTitle:[activityChoices firstObject] forState:UIControlStateNormal];
    self.activityTextField.layer.borderWidth = 1.0;
    self.activityTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.activityTextField.layer.cornerRadius = 4.0;
    self.activityTextField.clipsToBounds = YES;
    [self.activityTextField addTarget:self action:@selector(activityTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    self.modalView.alpha = 0.0;
    [self.modalView setHidden:YES];
}

- (void) transportTapped: (id)sender {
    transportTapped = YES;
    [self.pickerView reloadAllComponents];
    [self showModalView];
}

- (void) activityTapped: (id)sender {
    transportTapped = NO;
    [self.pickerView reloadAllComponents];
    [self showModalView];
}

- (void) showModalView {
    [self.modalView setHidden:NO];
    [UIView animateWithDuration:0.2 animations:^{
        [self.modalView setAlpha:0.6];
    } completion:^(BOOL finished) {
        [self.transportTextField setUserInteractionEnabled:NO];
        [self.activityTextField setUserInteractionEnabled:NO];
    }];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (transportTapped) {
        return transportChoices.count;
    } else {
        return activityChoices.count;
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (transportTapped) {
        return transportChoices[row];
    } else {
        return activityChoices[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *text;
    if (transportTapped) {
        text = transportChoices[row];
        [self.transportTextField setTitle:text forState:UIControlStateNormal];
    } else {
        text = activityChoices[row];
        [self.activityTextField setTitle:text forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.modalView setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self.modalView setHidden:YES];
        [self.transportTextField setUserInteractionEnabled:YES];
        [self.activityTextField setUserInteractionEnabled:YES];
    }];
}

@end
