//
//  ViewController.m
//  HelpNow
//
//  Created by Robert Klouda on 3/24/17.
//  Copyright © 2017 Robert Klouda. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    @try {
        
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
 
                NSLog(@"%@",jsonData);
         
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
          //          [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                     NSLog(@"Logged in Successfully");
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
@end
