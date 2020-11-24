//
//  InfoPopoverViewController.m
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 20/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "InfoPopoverViewController.h"

@interface InfoPopoverViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation InfoPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.modalPresentationStyle = UIModalPresentationPopover;
    self.popoverPresentationController.delegate = self;
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
