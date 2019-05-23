//
//  ViewController.h
//  OutletsTask
//
//  Created by Aleksandr on 27/04/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *fieldViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *redChessViews;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *whiteChessViews;

@end

