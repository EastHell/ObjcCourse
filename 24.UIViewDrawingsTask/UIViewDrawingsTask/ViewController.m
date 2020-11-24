//
//  ViewController.m
//  UIViewDrawingsTask
//
//  Created by Antipharmakon Aeolis  on 10/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import "DrawingView.h"
#import "PaintingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.drawingView setNeedsDisplay];
    [self.paintingView setNeedsDisplay];
}

@end
