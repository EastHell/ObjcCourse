//
//  ViewController.m
//  ViewsTask
//
//  Created by Aleksandr on 21/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *fieldView;
@property (strong, nonatomic) NSMutableArray<UIView *> *fieldSquads;
@property (strong, nonatomic) NSMutableArray<UIView *> *checkers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, MIN(self.view.frame.size.width, self.view.frame.size.height), MIN(self.view.frame.size.width, self.view.frame.size.height))];
    self.fieldView.backgroundColor = [UIColor blueColor];
    self.fieldView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:self.fieldView];
    
    const CGFloat SQUAD_SIZE = MIN(self.fieldView.frame.size.height, self.fieldView.frame.size.width) / 8;
    
    self.fieldSquads = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 32; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(((i / 4) % 2) * SQUAD_SIZE + SQUAD_SIZE * 2 * (i % 4), (i / 4) * SQUAD_SIZE, SQUAD_SIZE, SQUAD_SIZE)];
        view.backgroundColor = [UIColor blackColor];
        [self.fieldView addSubview:view];
        [self.fieldSquads addObject:view];
    }
    
    self.checkers = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 12; i++) {
        UIView *view = [self createCheckerColor:[UIColor whiteColor] AtIndex:i withSize:SQUAD_SIZE];
        [self.fieldView addSubview:view];
        [self.checkers addObject:view];
    }
    
    for (NSInteger i = 31; i >= 20; i--) {
        UIView *view = [self createCheckerColor:[UIColor redColor] AtIndex:i withSize:SQUAD_SIZE];
        [self.fieldView addSubview:view];
        [self.checkers addObject:view];
    }
}

-(UIView *)createCheckerColor:(UIColor *)color AtIndex:(NSInteger)index withSize:(CGFloat)squadSize {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(squadSize * 0.2 + ((index / 4) % 2) * squadSize + squadSize * 2 * (index % 4), squadSize * 0.2 + (index / 4) * squadSize, squadSize*0.6, squadSize*0.6)];
    view.backgroundColor = color;
    return view;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    for (UIView *view in self.fieldSquads) {
        view.backgroundColor = [UIColor greenColor];
    }
}

@end
