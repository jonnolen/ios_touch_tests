//
//  DTViewController.h
//  slideviewpoc
//
//  Created by Jonathan Nolen on 10/18/12.
//  Copyright (c) 2012 Developertown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIView *topView;

- (IBAction)viewPanned:(UIPanGestureRecognizer *)pan;
@end
