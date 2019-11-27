//
//  DatePickerPopoverViewController.h
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 22/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DatePickerDelegate <NSObject>

- (void)dateChanged:(NSDate *)date;
- (NSDate *)getDate;

@end

@interface DatePickerPopoverViewController : UIViewController

@property (weak, nonatomic) id <DatePickerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
