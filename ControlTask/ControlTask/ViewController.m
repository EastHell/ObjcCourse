//
//  ViewController.m
//  ControlTask
//
//  Created by Aleksandr on 28/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self animateView];
}

- (void)animateView {
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGAffineTransform t = self.imageView.transform;
                         
                         if (self.rotationSwitch.on) {
                             CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI * 0.5 * self.speedSlider.value);
                             t = CGAffineTransformConcat(t, rotation);
                         }
                         
                         if (self.scaleSwitch.on) {
                             CGAffineTransform scale = CGAffineTransformMakeScale(1.f + 0.1f * self.speedSlider.value,
                                                                                  1.f + 0.1f * self.speedSlider.value);
                             t = CGAffineTransformConcat(t, scale);
                         }
                         
                         if (self.scaleSwitch.on) {
                             CGAffineTransform translation = CGAffineTransformMakeTranslation(10.f * self.speedSlider.value,
                                                                                              10.f * self.speedSlider.value);
                             t = CGAffineTransformConcat(t, translation);
                         }
                         
                         self.imageView.transform = t;
                     } completion:^(BOOL finished) {
                         [self animateView];
                     }];
}

- (IBAction)actionSegmentedControl:(UISegmentedControl *)sender {
    UIImage *image;
    switch (sender.selectedSegmentIndex) {
        case 0:
            image = [UIImage imageNamed:@"1.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"2.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"3.png"];
            break;
        default:
            image = [UIImage imageNamed:@"1.png"];
            break;
    }
    [self.imageView setImage:image];
}
@end
