//
//  ClientDetailTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 4/2/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientDetailTableViewController : UITableViewController <UITextFieldDelegate>





{
  UIBarButtonItem *save, *update;
    NSDictionary *jsonDict;
    NSDictionary *jsonData;
    
 //   NSUInteger userProfilePictureID;
 //   UIDatePicker *dp;
 //   UIPickerView *PV;
}


//@property (nonatomic, weak) IBOutlet UIBarButtonItem *saveButton;


@property (weak, nonatomic) IBOutlet NSString *R_First_Name, *R_Last_Name, *R_Street, *R_City, *R_State, *R_Zip_Code, *R_Date, *R_Phone_Number, *R_Number_Of_Residents, *R_Agent_ID, *R_Social_Security_Number, *R_Client_ID;
@property (nonatomic, weak) IBOutlet UITextField *First_Name, *Client_ID;
@property (nonatomic, weak) IBOutlet UITextField *Last_Name;
@property (nonatomic, weak) IBOutlet UITextField *Street;
@property (nonatomic, weak) IBOutlet UITextField *City, *Social_Security_Number;
@property (nonatomic, weak) IBOutlet UITextField *State, *Zip_Code, *Date;
@property (nonatomic, weak) IBOutlet UITextField *Phone_Number, *Number_Of_Residents, *Agent_ID;





@end
