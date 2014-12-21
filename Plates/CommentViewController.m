//
//  CommentViewController.m
//  Plates
//
//  Created by Jason Humphries on 12/21/14.
//  Copyright (c) 2014 Jason Humphries. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UILabel *plateLabel;
@property (weak, nonatomic) IBOutlet UITextField *commentField;
@property (weak, nonatomic) IBOutlet UITextField *emoticonField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)submitAction:(id)sender
{
    //
}

@end
