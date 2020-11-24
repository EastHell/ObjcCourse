//
//  ViewController.h
//  UIViewDrawingsTask
//
//  Created by Aleksandr on 10/08/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawingView;
@class PaintingView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet DrawingView *drawingView;
@property (weak, nonatomic) IBOutlet PaintingView *paintingView;

@end

