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
    
    _fieldView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, MIN(self.view.frame.size.width, self.view.frame.size.height), MIN(self.view.frame.size.width, self.view.frame.size.height))];
    _fieldView.backgroundColor = [UIColor blueColor];
    _fieldView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    [self.view addSubview:_fieldView];
    
    const CGFloat SQUAD_SIZE = MIN(_fieldView.frame.size.height, _fieldView.frame.size.width) / 8;
    
    _fieldSquads = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 32; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(((i / 4) % 2) * SQUAD_SIZE + SQUAD_SIZE * 2 * (i % 4), (i / 4) * SQUAD_SIZE, SQUAD_SIZE, SQUAD_SIZE)];
        view.backgroundColor = [UIColor blackColor];
        [_fieldView addSubview:view];
        [_fieldSquads addObject:view];
    }
    
    _checkers = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 12; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SQUAD_SIZE * 0.2 + ((i / 4) % 2) * SQUAD_SIZE + SQUAD_SIZE * 2 * (i % 4), SQUAD_SIZE * 0.2 + (i / 4) * SQUAD_SIZE, SQUAD_SIZE*0.6, SQUAD_SIZE*0.6)];
        view.backgroundColor = [UIColor whiteColor];
        [_fieldView addSubview:view];
        [_checkers addObject:view];
    }
    
    for (NSInteger i = 31; i >= 20; i--) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SQUAD_SIZE * 0.2 + ((i / 4) % 2) * SQUAD_SIZE + SQUAD_SIZE * 2 * (i % 4), SQUAD_SIZE * 0.2 + (i / 4) * SQUAD_SIZE, SQUAD_SIZE*0.6, SQUAD_SIZE*0.6)];
        view.backgroundColor = [UIColor redColor];
        [_fieldView addSubview:view];
        [_checkers addObject:view];
    }
}

- (void)dealloc
{
    <#statements#>
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    for (UIView *view in _fieldSquads) {
        view.backgroundColor = [UIColor greenColor];
    }
}

@end
