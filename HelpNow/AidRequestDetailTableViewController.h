//
//  AidRequestDetailTableViewController.h
//  HelpNow
//
//  Created by Robert Klouda on 4/3/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AidRequestDetailTableViewController : UITableViewController <UITextFieldDelegate, UITextViewDelegate>
{
      UIBarButtonItem *save, *update;
   NSDictionary *Aidjsondata, *agentjsonData;
    
    UIDatePicker *dp;
}
@property(nonatomic,retain) NSDictionary *AidjsonData, *agentjsonData;
@property (weak, nonatomic) IBOutlet NSString *R_Agent_ID;
@property (weak, nonatomic) IBOutlet UITextField *Agent_ID;
@property (weak, nonatomic) IBOutlet NSString *R_Date_Requested, *R_Amount_Requested, *R_Client_Notes, *R_Decision, *R_Documentation_Provided, *R_Aid_ID, *R_Award_ID, *R_Client_ID, *R_Request_ID;
@property (nonatomic, weak) IBOutlet UITextField *Date_Requested, *Amount_Requested;// *Client_Notes;
@property (nonatomic, weak) IBOutlet UITextField *Decision, *Documentation_Provided, *Aid_ID;
@property (nonatomic, weak) IBOutlet UITextField *Award_ID;
@property (nonatomic, weak) IBOutlet UITextField *Client_ID, *Request_ID;
@property (nonatomic, weak) IBOutlet UITextView *Client_Notes;

@end
