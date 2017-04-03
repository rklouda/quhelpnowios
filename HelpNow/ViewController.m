//
//  ViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 3/24/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"
#import "MainTableViewController.h"
#import "SVProgressHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ _usersTableView setBackgroundView:
     [[UIImageView alloc] initWithImage:
      [UIImage imageNamed:@"helpnowcover.png"]]];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)presentErrorMessage:(NSString *)message title:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"text mssg" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        // Ok action example
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"Other" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        // Other action
    }];
    [alert addAction:okAction];
    [alert addAction:otherAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)login:(id)sender {
   [self performSegueWithIdentifier: @"loggedin" sender: self];
    /*
    @try {
        
        if([[_email text] isEqualToString:@""] || [[_password text] isEqualToString:@""] ) {
         //   [self alertFailed:@"Please enter both Username and Password" :@"Login Failed!"];
    
        }
        else {  [SVProgressHUD showWithStatus:@"Loggin in..."];
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
            
                
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                
                NSLog(@"Jason Parsed:%@",jsonData);
                
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSLog(@"Success Number: %ld",(long)success);
                _first_name = [jsonData objectForKey:@"First_Name"];
                NSLog(@"%@",jsonData);
         
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
        NSLog(@"Variable to pass: %@", _first_name);
                     [self performSegueWithIdentifier: @"loggedin" sender: self];
                     [SVProgressHUD dismiss];
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
       //             [self alertFailed:error_msg :@"Login Failure! Correct your credentials"];
                    NSLog(@"Error %@", error_msg);
                     [SVProgressHUD dismiss];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
       //         [self alertFailed:@"Connection Failed" :@"Login Failed!"];
                 NSLog(@"Error Connection Failed");
                 [SVProgressHUD dismiss];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
       NSLog(@"Login Failed.");
       [SVProgressHUD dismiss];
    }
*/
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    MainTableViewController *vc = [segue destinationViewController];
      NSLog(@"Variable to pass: %@", _first_name);
    
    
    if ([segue.identifier isEqualToString:@"loggedin"])
    {
        // Get reference to the destination view controller
       
        
        // Pass any objects to the view controller here, like...
        NSLog(@"Variable to pass: %@", _first_name);
        vc.userString = _first_name;
    }
}
@end
