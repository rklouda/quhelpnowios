//
//  AidRequestDetailTableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 4/3/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "AidRequestDetailTableViewController.h"
#import "SVProgressHUD.h"

@interface AidRequestDetailTableViewController ()

@end

@implementation AidRequestDetailTableViewController
@synthesize AidjsonData, agentjsonData;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"AidRequestjsondate in AidRequest Detail: %@", self.AidjsonData);
    NSLog(@"Agentjsondate in AidRequest Detail: %@", self.agentjsonData);
     NSLog(@"Edit Aid Request: %@", self.R_Request_ID);
    
    self.R_Agent_ID = [NSString stringWithFormat:@"Agent: %@ %@ ID=%@", [self.agentjsonData valueForKey:@"First_Name"], [self.agentjsonData valueForKey:@"Last_Name"], [self.agentjsonData  valueForKey:@"Agent_ID"]];
    
   
    
    _Date_Requested.delegate = self;
    _Amount_Requested.delegate = self;
    _Client_Notes.delegate = self;
    _Client_ID.delegate =self;
    _Decision.delegate = self;
    _Documentation_Provided.delegate = self;
    _Aid_ID.delegate = self;
    _Award_ID.delegate = self;
 //   _Request_ID.delegate = self;

    
    self.Date_Requested.tag = 1;
    self.Date_Requested.inputView = dp;
    
    save= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    update= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(update1)];
    
    if (self.R_Request_ID) {
    NSLog(@"Edit Aid Request: %@", self.R_Request_ID);
        
        
        self.navigationItem.rightBarButtonItem = update;
        update.enabled = NO;
        
        self.Request_ID.text = self.R_Request_ID;
        self.Amount_Requested.text = [NSString stringWithFormat:@"$%@", self.R_Amount_Requested];
        self.Date_Requested.text = self.R_Date_Requested;
        self.Documentation_Provided.text = self.R_Documentation_Provided;
        self.Decision.text = self.R_Decision;
      //  self.Award_ID.text = self.R_Award_ID;
        self.Client_ID.text = self.R_Client_ID;
         self.Agent_ID.text = self.R_Agent_ID;
        self.Client_Notes.text = self.R_Client_Notes;
        
   //  self.Client_Notes.text = [self.AidjsonData valueForKey:@"Client_Notes"];
    //  self.Documentation_Provided.text = [Aidjsondata valueForKey:@"Documentation_Provided"];
  //    self.R_Amount_Requested = [self.AidjsonData valueForKey:@"Amount_Requested"];
  //      self.Amount_Requested.text = self.R_Date_Requested;
        
    //    self.Request_ID.text =[Aidjsondata valueForKey:@"Request_ID"];
    //  self.Decision.text = [Aidjsondata valueForKey:@"Decision"];
 
    }
    else
    {
        NSLog(@"Create New Aid Request");
        self.navigationItem.rightBarButtonItem = save;
        save.enabled = NO;
        _R_Aid_ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"AidTypeSelected"];
        self.Agent_ID.text = self.R_Agent_ID;
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        self.R_Date_Requested = [dateFormat stringFromDate:today];
         self.Date_Requested.text = self.R_Date_Requested;
        NSLog(@"date: %@", self.R_Date_Requested);
        self.Decision.text = @"Pending";
    }

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



#pragma mark - Text Delegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    save.enabled = YES;
    update.enabled = YES;
    
    if (textField.tag == 1)
    {
        // Create a date picker for the date field.
        UIDatePicker *datePicker = [[UIDatePicker alloc]init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.backgroundColor = [UIColor whiteColor];
        datePicker.maximumDate = [NSDate date];
        
      /*  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
        NSDate *dateT = [dateFormatter dateFromString:self.R_Date_Requested];
        [datePicker setDate:dateT];
     */   
        
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        self.Date_Requested.inputView = datePicker;
        self.R_Date_Requested = [self formatDate:datePicker.date];
    }
    
}
// Called when the date picker changes.
- (void)updateDateField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.Date_Requested.inputView;
    self.Date_Requested.text = [self formatDate:picker.date];
    save.enabled = YES;
}


// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

-(void)save{
    
    NSLog(@"Save in AidRequest pressed in ADD aidrequest detail");
    
    NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/addAidRequestIOS.php"];
    // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    //NSString *post =[[NSString alloc] initWithFormat:@"name=%@&last=%@",[_First_Name text],[_Last_Name text]];
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    self.R_Date_Requested = [dateFormat stringFromDate:today];
    self.Date_Requested.text = self.R_Date_Requested;
    NSLog(@"date: %@", self.R_Date_Requested);
    
    NSDate *dte = [dateFormat dateFromString:self.Date_Requested.text];
    
    NSString *post =[[NSString alloc] initWithFormat:@"Amount_Requested=%@&Decision=%@&Date_Requested=%@&Documentation_Provided=%@&Client_Notes=%@&Client_ID=%@&Aid_ID=%@",[_Amount_Requested text],[_Decision text],dte,[_Documentation_Provided text],[_Client_Notes text], [_Client_ID text],[_Aid_ID text]];
    
    
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      
                                      NSLog(@"Response ==>%@", responseData);
                                      
                                      if(error) {
                                          NSLog(@"ERROR Saving new Client:%@", error);
                                      }
                                      
                                      if([responseData isEqual:@"true"])
                                      {
                                          NSLog(@"Client ADD SUCCESS");
                                          
                                          
                                      } else {
                                          
                                          NSLog(@"Error %@", error);
                                          
                                      }
                                      
                                  }
                                  ];
 
    [task resume];
  //  [self.navigationController popViewControllerAnimated:YES];

}


-(void)update1
{
    NSLog(@"Update Aid Request pressed in EDIT AidRequest detail");
    
    //  UIApplication.sharedApplication.networkActivityIndicatorVisible = true;
    //  [SVProgressHUD showWithStatus:@"Updating Client..."];
    // [SVProgressHUD dismiss];
    
    NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/updateAidRequestIOS.php"];
    // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
  
     NSString *post =[[NSString alloc] initWithFormat:@"Request_ID=%@&Amount_Requested=%@&Decision=%@&Date_Requested=%@&Documentation_Provided=%@&Client_Notes=%@&Client_ID%@&Aid_ID%@",self.R_Request_ID,[_Amount_Requested text],[_Decision text],[_Date_Requested text],[_Documentation_Provided text],[_Client_Notes text],[_Client_ID text],[_Aid_ID text]];
    
    NSLog(@"HELP: %@", self.R_Request_ID);
    
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      NSString *responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                      
                                      NSLog(@"Response ==>%@", responseData);
                                      
                                      if(error) {
                                          NSLog(@"ERROR Saving new Client:%@", error);
                                      }
                                      
                                      if([responseData isEqual:@"true"])
                                      {
                                          NSLog(@"Client Modified SUCCESS");
                                          //  [self Alert:@"Successful"];
                                          UIApplication.sharedApplication.networkActivityIndicatorVisible = false;
                                          [SVProgressHUD dismiss];
                                      } else {
                                          
                                         NSLog(@"Error %@", error);
                                          
                                      }
                                      
                                  }
                                  ];
    [task resume];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)Alert:(NSString*)msg{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Client Modified"
                                                                   message:msg                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - Table view data source
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 #warning Incomplete implementation, return the number of sections
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 #warning Incomplete implementation, return the number of rows
 return 9;
 }
 */
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
