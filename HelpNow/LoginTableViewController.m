//
//  LoginTableViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 3/30/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "LoginTableViewController.h"
#import "MainTableViewController.h"
@interface LoginTableViewController ()

@end

@implementation LoginTableViewController
@synthesize first_name, last_name;

- (void)viewDidLoad {
    [super viewDidLoad];
     NSLog(@"loginTVC");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
 */
- (IBAction)login:(id)sender {

    NSLog(@"login");
    @try {
        UIApplication.sharedApplication.networkActivityIndicatorVisible = true;
        if([[_email text] isEqualToString:@""] || [[_password text] isEqualToString:@""] ) {
            //   [self alertFailed:@"Please enter both Username and Password" :@"Login Failed!"];
            
        }
        else {
            NSString *post =[[NSString alloc] initWithFormat:@"Agent_Email=%@&Password=%@",[_email text],[_password text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"https://quhelpnow-raklouda.c9users.io/service.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                NSError *error = nil;
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                
                if(error) {
                    NSLog(@"%@", error);
                }
                NSLog(@"Jason Parsed:%@",jsonData);
                
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSLog(@"Success Number: %ld",(long)success);
                
                
              //  first_name = [NSString stringWithFormat:@"%@ %@", [jsonData objectForKey:@"First_Name"], [jsonData objectForKey:@"Last_Name"]];
                first_name = [NSString stringWithFormat:@"%@ %@",[jsonData objectForKey:@"First_Name"], [jsonData objectForKey:@"Last_Name"]];
                
                first_name = [jsonData objectForKey:@"First_Name"];
                last_name = [jsonData objectForKey:@"Last_Name"];
                
                NSLog(@"%@",jsonData);
                
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
        UIApplication.sharedApplication.networkActivityIndicatorVisible = false;
                    [self performSegueWithIdentifier: @"loggedin" sender: self];
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    //             [self alertFailed:error_msg :@"Login Failure! Correct your credentials"];
                    NSLog(@"Error %@", error_msg);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error. Try Again"
                                                                    message:[error_msg description]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                    
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                //         [self alertFailed:@"Connection Failed" :@"Login Failed!"];
                NSLog(@"Error Connection Failed");
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSLog(@"Login Failed.");
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
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MainTableViewController *vc = [segue destinationViewController];
    NSLog(@"Variable to pass: %@", first_name);
    
    
    if ([segue.identifier isEqualToString:@"loggedin"])
    {
        // Get reference to the destination view controller
        
        
        // Pass any objects to the view controller here, like...
        NSLog(@"Variable to pass: %@", first_name);
        vc.userString = first_name;
        vc.userStringLast = last_name;
    }
}
@end
