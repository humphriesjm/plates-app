//
//  CommentViewController.m
//  Plates
//
//  Created by Jason Humphries on 12/21/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "AppClient.h"
#import "CommentContext.h"
#import "CommentViewController.h"

@interface CommentViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *plateLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (weak, nonatomic) IBOutlet UITextField *emoticonField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self populatePlateLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)populatePlateLabel
{
    self.plateLabel.text = [NSString stringWithFormat:@"Plate: %@", self.commentContext.plateString];
}

- (IBAction)submitAction:(id)sender
{
    // POST
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
