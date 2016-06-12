//
//  ExploreController.swift
//  Platripus
//
//  Created by Thien Tran on 6/9/16.
//  Copyright © 2016 NVC_2016. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var helloText: UITextView!
    

    @IBOutlet weak var selectionView: UIView!
    
    
    @IBOutlet weak var traveller: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var budget: UITextField!
    
    
    @IBOutlet weak var startDate: UITextField!
    
    
    @IBOutlet weak var endDate: UITextField!
    
    
    let locations = ["San Francisco", "Los Angeles", "Las Vegas", "New York"]
    let travellers = ["1 Traveller", "2 Travellers", "3 Travellers", "4 Travellers"]
    let budgets = ["Below $50", "$50- $100", "$100- $200", "$200- $400", "$400- $700", "Above $700"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        /* Code for location picker */
        let locationPicker: UIPickerView
        locationPicker = UIPickerView(frame: CGRectMake(0, 100, view.frame.width, 300))
        locationPicker.backgroundColor = .whiteColor()
        locationPicker.tag = 1
        locationPicker.delegate = self
        locationPicker.delegate = self
        locationPicker.showsSelectionIndicator = true
        
        let toolBar1 = UIToolbar()
        toolBar1.barStyle = UIBarStyle.Default
        toolBar1.translucent = true
        toolBar1.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar1.sizeToFit()
        
        let doneButton1 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker1")
        let spaceButton1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton1 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker1")
        
        toolBar1.setItems([cancelButton1, spaceButton1, doneButton1], animated: false)
        toolBar1.userInteractionEnabled = true
        
        location.inputView = locationPicker
        location.inputAccessoryView = toolBar1
        
        /* Code for travellers picker */
        let travellerPicker: UIPickerView
        travellerPicker = UIPickerView(frame: CGRectMake(0, 100, view.frame.width, 300))
        travellerPicker.backgroundColor = .whiteColor()
        travellerPicker.tag = 2
        travellerPicker.delegate = self
        travellerPicker.delegate = self
        travellerPicker.showsSelectionIndicator = true
        
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.Default
        toolBar2.translucent = true
        toolBar2.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar2.sizeToFit()
        
        let doneButton2 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker2")
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker2")
        
        toolBar2.setItems([cancelButton2, spaceButton2, doneButton2], animated: false)
        toolBar2.userInteractionEnabled = true

        
        traveller.inputView = travellerPicker
        traveller.inputAccessoryView = toolBar2
        
        
        /* Code for budget picker */
        let budgetPicker: UIPickerView
        budgetPicker = UIPickerView(frame: CGRectMake(0, 100, view.frame.width, 300))
        budgetPicker.backgroundColor = .whiteColor()
        budgetPicker.tag = 3
        budgetPicker.delegate = self
        budgetPicker.delegate = self
        budgetPicker.showsSelectionIndicator = true
        
        let toolBar3 = UIToolbar()
        toolBar3.barStyle = UIBarStyle.Default
        toolBar3.translucent = true
        toolBar3.tintColor = UIColor.blueColor()//UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar3.sizeToFit()
        
        let doneButton3 = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker3")
        let spaceButton3 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton3 = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker3")
        
        toolBar3.setItems([cancelButton3, spaceButton3, doneButton3], animated: false)
        toolBar3.userInteractionEnabled = true
        
        
        budget.inputView = budgetPicker
        budget.inputAccessoryView = toolBar3
        
        helloText.userInteractionEnabled = false
        selectionView.layer.borderWidth = 1
        selectionView.layer.borderColor = UIColor.grayColor().CGColor
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = "revealToggle:"
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be 
        // recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1) {
          return locations.count
        } else if (pickerView.tag == 2){
          return travellers.count
        } else {
          return budgets.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1) {
          return locations[row]
        } else if (pickerView.tag == 2){
            return travellers[row]
        } else {
            return budgets[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1) {
          location.text = locations[row]
        } else if (pickerView.tag == 2){
           traveller.text = travellers[row]
        } else {
           budget.text = budgets[row]
        }
    }
    
    func donePicker1() {
        location.resignFirstResponder()
    }
    
    func donePicker2() {
        traveller.resignFirstResponder()
    }
    
    func donePicker3() {
        budget.resignFirstResponder()
    }
    
    func donePicker4() {
        startDate.resignFirstResponder()
    }
    
    func donePicker5() {
        endDate.resignFirstResponder()
    }

    @IBAction func startDate(sender: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 100, view.frame.width, 300))
        datePickerView.backgroundColor = .whiteColor()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker4")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker4")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        startDate.inputAccessoryView = toolBar
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("handleStartDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    
    }
    
    // 7
    func handleStartDatePicker(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        startDate.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    @IBAction func endDate(sender: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRectMake(0, 100, view.frame.width, 300))
        datePickerView.backgroundColor = .whiteColor()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker5")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker5")
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        endDate.inputAccessoryView = toolBar
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: Selector("handleEndDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func handleEndDatePicker(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        endDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
}
