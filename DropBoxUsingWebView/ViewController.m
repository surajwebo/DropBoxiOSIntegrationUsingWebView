//
//  ViewController.m
//  DropBoxUsingWebView
//
//  Created by Suraj Mirajkar on 30/01/13.
//  Copyright (c) 2013 suraj. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webViewForDropBox.backgroundColor = [UIColor clearColor];
    self.webViewForDropBox.opaque = NO;
    [self.webViewForDropBox setHidden:YES];
    [self.txtFieldForLink setEnabled:NO];
    self.arrayOfLinks = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadDropBoxFromUrl:(id)sender {
    [self.webViewForDropBox loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: @"https://www.dropbox.com/"]]];
	self.busyIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.busyIndicator setFrame:CGRectMake(150, 180, 20, 20)];
    [self.view addSubview: self.busyIndicator];
}

- (IBAction)dismissWebView:(id)sender {
  //  [[[UIAlertView alloc] initWithTitle:@"Warning !!!" message:@"Please logout DropBox Account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    self.webViewForDropBox.backgroundColor = [UIColor clearColor];
    self.webViewForDropBox.opaque = NO;
    [self.webViewForDropBox setHidden:YES];
    
    self.customView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 285)];
    self.customView.alpha = 0.0;
    self.customView.layer.cornerRadius = 5;
    self.customView.layer.borderWidth = 1.5f;
    self.customView.layer.masksToBounds = YES;
    
    NSMutableString *strLinks = [[NSMutableString alloc] init];
    for (int i=0; i<[self.arrayOfLinks count]; i++) {
        [strLinks appendString: [self.arrayOfLinks objectAtIndex:i]];
        [strLinks appendString: @"\n"];
    }
    
    UILabel *lblURLs = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 280, 280)];
    [lblURLs setLineBreakMode:NSLineBreakByWordWrapping];
    [lblURLs setTextAlignment:NSTextAlignmentLeft];
    [lblURLs setNumberOfLines:0];
    [lblURLs setText: strLinks];
    [lblURLs setBackgroundColor:[UIColor clearColor]];
    
    [self.customView setBackgroundColor:[UIColor lightGrayColor]];
    [self.customView addSubview:lblURLs];
    [self.view addSubview:self.customView];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    [self.customView setAlpha:1.0];
    [UIView commitAnimations];
    [UIView setAnimationDuration:0.0];
    
    self.tapgestureOnInfoView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeInfoViewFromScreen)];
    [self.customView addGestureRecognizer: self.tapgestureOnInfoView];
    [self.view addGestureRecognizer: self.tapgestureOnInfoView];
    self.customView.userInteractionEnabled = YES;
}

-(void)removeInfoViewFromScreen {
    [self.customView removeFromSuperview];
    [self.view removeGestureRecognizer: self.tapgestureOnInfoView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.busyIndicator startAnimating];
    self.webViewForDropBox.layer.cornerRadius = 8.0f;
    self.webViewForDropBox.layer.masksToBounds = YES;
    self.webViewForDropBox.layer.borderWidth = 2.0f;
    self.webViewForDropBox.layer.borderColor = [UIColor greenColor].CGColor;
    [self.webViewForDropBox setHidden:NO];
    [self.txtFieldForLink setEnabled:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.busyIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.busyIndicator stopAnimating];
    [[[UIAlertView alloc] initWithTitle:@"Error !!!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

#pragma UITextField Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self validateURL]) {
        [self.arrayOfLinks addObject:self.txtFieldForLink.text];
        [self.txtFieldForLink setText:@""];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Error !!!" message:@"Please check url before submitting" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /*if (textField == self.txtFieldForLink)
        [self animateTextField:self.txtFieldForLink up:YES];*/
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /*if (textField == self.txtFieldForLink)
        [self animateTextField:self.txtFieldForLink up:NO];*/
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 60;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame,0, movement);
    [UIView commitAnimations];
}

#pragma mark Validate Email Id using Regular Expression
-(BOOL)validateURL {
    BOOL isValid = NO;
    if (self.txtFieldForLink.text.length > 0 )  {
        NSURL *myURL = [NSURL URLWithString: self.txtFieldForLink.text];
        if (myURL && myURL.scheme && myURL.host) {
            isValid = YES;
        }
    }
    return isValid;
}

@end
