//
//  ViewController.m
//  UIButtonTask
//
//  Created by Aleksandr on 22/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableString *number;
@property (assign, nonatomic) double firstNumber;
@property (assign, nonatomic) NSString *commandPressed;
@property (assign, nonatomic) BOOL dotSetted;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.number = [NSMutableString string];
    self.commandPressed = @"";
    [self resetSettings];
}

- (void)resetSettings {
    [self.number setString:@""];
    self.commandPressed = @"";
    self.firstNumber = 0;
    self.dotSetted = false;
    [self.indicatorLabel setText:@"0"];
}

- (double)calculateWithSecondValue:(double)value {
    if ([self.commandPressed isEqualToString:@"+"]) {
        double result = self.firstNumber + value;
        self.firstNumber = result;
        return result;
    } else if ([self.commandPressed isEqualToString:@"-"]) {
        double result = self.firstNumber - value;
        self.firstNumber = result;
        return result;
    } else if ([self.commandPressed isEqualToString:@"*"]) {
        double result = self.firstNumber * value;
        self.firstNumber = result;
        return result;
    } else if ([self.commandPressed isEqualToString:@"/"]) {
        double result = self.firstNumber / value;
        self.firstNumber = result;
        return result;
    }
    return 0;
}

- (IBAction)action:(UIButton *)sender {
    switch (sender.tag) {
        case 1: //1-9
            [self.number appendString:[sender currentTitle]];
            [self.indicatorLabel setText:self.number];
            break;
        case 2: //0
            if (![self.number  isEqualToString:@"0"]) {
                [self.number appendString:[sender currentTitle]];
                [self.indicatorLabel setText:self.number];
            }
            break;
        case 3: //.
            if (!self.dotSetted) {
                if ([self.number isEqualToString:@""])
                    [self.number appendString:[NSString stringWithFormat:@"0%@", [sender currentTitle]]];
                else
                    [self.number appendString:[sender currentTitle]];
                [self.indicatorLabel setText:self.number];
                self.dotSetted = true;
            }
            break;
        case 4: //C
            [self resetSettings];
            break;
        case 5:
            self.firstNumber = [self.number doubleValue];
            [self.number setString:@""];
            self.commandPressed = [sender currentTitle];
            self.dotSetted = false;
            break;
        case 6:
        {
            double secondNumber = [self.number doubleValue];
            @try {
                [self.indicatorLabel setText:[NSString stringWithFormat:@"%g", [self calculateWithSecondValue:secondNumber]]];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
            break;
        }
        default:
            break;
    }
}

@end
