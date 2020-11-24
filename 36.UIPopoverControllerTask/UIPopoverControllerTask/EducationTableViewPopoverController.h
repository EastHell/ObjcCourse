//
//  EducationTableViewPopoverController.h
//  UIPopoverControllerTask
//
//  Created by Aleksandr on 24/11/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EducationDelegate <NSObject>

- (void)educationChanged:(NSString *)education;
- (NSString *)getEducation;

@end

@interface EducationTableViewPopoverController : UITableViewController

@property (weak, nonatomic) id <EducationDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
