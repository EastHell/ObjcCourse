//
//  ViewController.h
//  UIButtonTask
//
//  Created by Aleksandr on 22/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

- (IBAction)action:(UIButton *)sender;

@end

