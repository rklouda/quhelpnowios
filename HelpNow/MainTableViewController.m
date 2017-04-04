//
//  MainTableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 4/1/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "MainTableViewController.h"
#import "SVProgressHUD.h"
#import "AgentDetailTableViewController.h"
@interface MainTableViewController ()

@end

@implementation MainTableViewController
@synthesize userLabel, userString, userStringLast, jsonData;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationItem.hidesBackButton = YES;
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.userString, self.userStringLast];
   self.userLabel.text = fullName;
  //  self.jsonData = self.jsonData;
    
    NSLog(@"Passed Variable in Main: %@", self.jsonData);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 */
- (IBAction)logOut:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil                                                           preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *logOut = [UIAlertAction actionWithTitle:@"Log Out"
                                                           style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                                                               NSLog(@"Log out");
                                                                [self logOutfunction];
                                                           }]; // 2
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                                                               NSLog(@"Log out - Cancel");
                                                              
                                                           }]; // 2
    [alert addAction:logOut];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil]; // 6
    
    
    
    
}
-(void)logOutfunction{
  [SVProgressHUD showWithStatus:@"Logging out..."];
      UIApplication.sharedApplication.networkActivityIndicatorVisible = true;
    NSURL *url = [NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/logoutIOS.php"];
   // NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSString *post =[[NSString alloc] initWithFormat:@"logOut"];
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
                                 
                                          SBJsonParser *jsonParser = [SBJsonParser new];
                                          jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                                          
                                          if(error) {
                                              NSLog(@"%@", error);
                                          }
                                          NSLog(@"Jason Parsed:%@",jsonData);
                                          
                                          NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                                          NSLog(@"Success Number: %ld",(long)success);
                                          
                                          NSLog(@"%@",jsonData);
                                          
                                          if(success == 1)
                                          {
                                              NSLog(@"logOut SUCCESS");
                                    
                                              [self performSegueWithIdentifier: @"logOut" sender: self];
                                                UIApplication.sharedApplication.networkActivityIndicatorVisible = false;
                                              [SVProgressHUD dismiss];
                                          } else {
                                              
                                              NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                                              //             [self alertFailed:error_msg :@"Login Failure! Correct your credentials"];
                                              NSLog(@"Error %@", error_msg);
                                            
                                          }
    
                                  }
                                  ];
    [task resume];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    
    
    if ([[segue identifier] isEqualToString:@"editAgent2"]) {
        
        AgentDetailTableViewController *destinationViewController = (AgentDetailTableViewController*)segue.destinationViewController;
        destinationViewController.self.R_First_Name= [jsonData valueForKey:@"First_Name"];
        destinationViewController.self.R_Last_Name = [jsonData valueForKey:@"Last_Name"];
        destinationViewController.self.R_Street = [jsonData valueForKey:@"Street"];
        destinationViewController.self.R_City= [jsonData valueForKey:@"City"];
        destinationViewController.self.R_State = [jsonData valueForKey:@"State"];
        destinationViewController.self.R_Zip_Code= [jsonData valueForKey:@"Zip_Code"];
        destinationViewController.self.R_Phone_Number = [jsonData valueForKey:@"Phone_Number"];
        destinationViewController.self.R_Date_Hired= [jsonData valueForKey:@"Date_Hired"];
       destinationViewController.self.R_Agent_Email= [jsonData valueForKey:@"Agent_Email"];
  destinationViewController.self.R_Agent_ID= [jsonData valueForKey:@"Agent_ID"];
    
      //  destinationViewController.title = @"Edit Agent";
        //  destinationViewController.toolbarItems = nil;
        
    }
    
}




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
