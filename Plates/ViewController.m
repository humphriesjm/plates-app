//
//  ViewController.m
//  Plates
//
//  Created by Jason Humphries on 12/20/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "AppClient.h"
#import "CommentContext.h"
#import "CommentViewController.h"
#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *licencePlateField;
@property (weak, nonatomic) IBOutlet UITextField *stateField;
@property (weak, nonatomic) IBOutlet UITextField *colorField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)viewCarsAction:(id)sender
{
    [[AppClient sharedClient] getCars:^(NSArray *carArray) {
        NSLog(@"SERVER GET RESPONSE: %@", carArray);
    } failure:^(NSError *error) {
        NSLog(@"SERVER GET FAIL: %@", error.localizedDescription);
    }];
}

- (IBAction)nextAction:(id)sender
{
    NSString *plateString = self.licencePlateField.text;
    NSString *stateString = self.stateField.text;
    NSString *colorString = self.colorField.text;
    self.commentContext.plateString = plateString;
    self.commentContext.stateString = stateString;
    self.commentContext.colorString = colorString;
    
    [self performSegueWithIdentifier:@"toCommentSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toCommentSegue"]) {
        CommentViewController *cvc = (CommentViewController*)segue.destinationViewController;
        cvc.commentContext = self.commentContext;
    }
}

#pragma mark - CommentContext

- (CommentContext *)commentContext
{
    if (!_commentContext) {
        _commentContext = [CommentContext new];
    }
    return _commentContext;
}

@end
