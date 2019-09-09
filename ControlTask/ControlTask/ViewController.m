//
//  ViewController.m
//  ControlTask
//
//  Created by Aleksandr on 28/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

@property (assign, nonatomic) NSInteger switchOnCounter;
@property (assign, nonatomic) CGFloat angle;
@property (assign, nonatomic) CGFloat size;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.switchOnCounter = 0;
    self.angle = 0;
    self.size = 1.f;
}

- (IBAction)actionTransformSwitches:(UISwitch *)sender {
    if (sender.isOn) {
        if (self.switchOnCounter == 0) {
            [self animate];
        }
        self.switchOnCounter++;
    } else {
        self.switchOnCounter--;
    }
}

- (void)animate {
    CGFloat speed = 0.f;
    
    if (self.translationSwitch.isOn) {
        speed = 20.f;
    }
    if (self.scaleSwitch.isOn) {
        self.size = self.size + 0.2f * (self.speedSlider.value - 1.25);
    }
    if (self.rotationSwitch.isOn) {
        self.angle = self.angle + (M_PI_2 * (self.speedSlider.value - 1.25));
    }
    CGAffineTransform scale = CGAffineTransformMakeScale(self.size, self.size);
    CGAffineTransform rotation = CGAffineTransformMakeRotation(self.angle);
    CGAffineTransform newTransform = CGAffineTransformConcat(scale, rotation);
    
    [UIView animateWithDuration:0.5f
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CGPoint newCenter = CGPointMake(self.imageView.center.x + speed * (self.speedSlider.value - 1.25), self.imageView.center.y);
                         self.imageView.center = newCenter;
                         self.imageView.transform = newTransform;
                     }
                     completion:^(BOOL finished) {
                         if (self.switchOnCounter > 0) {
                             [self animate];
                         }
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
