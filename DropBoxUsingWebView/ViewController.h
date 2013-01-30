//
//  ViewController.h
//  DropBoxUsingWebView
//
//  Created by Suraj Mirajkar on 30/01/13.
//  Copyright (c) 2013 suraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController  <UIWebViewDelegate, UITextFieldDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnDropBox;
@property (weak, nonatomic) IBOutlet UIButton *btnQuit;
@property (weak, nonatomic) IBOutlet UIWebView *webViewForDropBox;
@property (nonatomic,retain) UIActivityIndicatorView *busyIndicator;
@property (weak, nonatomic) IBOutlet UITextField *txtFieldForLink;
@property (strong, nonatomic) NSMutableArray *arrayOfLinks;
@property (retain, nonatomic) UIView *customView;
@property (retain, nonatomic) UITapGestureRecognizer *tapgestureOnInfoView;

- (IBAction)loadDropBoxFromUrl:(id)sender;
- (IBAction)dismissWebView:(id)sender;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;
-(BOOL)validateURL;
-(void)removeInfoViewFromScreen;

@end
