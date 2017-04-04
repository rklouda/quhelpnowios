//
//  AgentDetailTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 4/2/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentDetailTableViewController : UITableViewController<UITextFieldDelegate>
{

    UIBarButtonItem *save, *update;
    NSDictionary *jsonDict;
    NSDictionary *jsonData;
    
    //   NSUInteger userProfilePictureID;
    //   UIDatePicker *dp;
    //   UIPickerView *PV;
}
@property (weak, nonatomic) IBOutlet NSString *agentInfo;
@property (weak, nonatomic) IBOutlet UILabel *firstName;


@property (weak, nonatomic) IBOutlet NSString *R_First_Name, *R_Last_Name, *R_Street, *R_City, *R_State, *R_Zip_Code, *R_Date, *R_Phone_Number, *R_Date_Hired, *R_Agent_Email, *R_Agent_ID;
@property (nonatomic, weak) IBOutlet UITextField *First_Name, *Agent_ID, *Agent_Email;
@property (nonatomic, weak) IBOutlet UITextField *Last_Name;
@property (nonatomic, weak) IBOutlet UITextField *Street;
@property (nonatomic, weak) IBOutlet UITextField *City;
@property (nonatomic, weak) IBOutlet UITextField *State, *Zip_Code;
@property (nonatomic, weak) IBOutlet UITextField *Phone_Number, *Date_Hired;

@end
