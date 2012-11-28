//
//  DTViewController.m
//  slideviewpoc
//
//  Created by Jonathan Nolen on 10/18/12.
//  Copyright (c) 2012 Developertown. All rights reserved.
//

#import "DTViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DTViewController (){
    CGFloat lastTranslation;
}
@end

@implementation DTViewController

const CGFloat SNAP_TO_X = 272.0;
const CGFloat SNAP_TO_THRESHOLD = 180.0;
const float SNAP_DURATION = .2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.topView.layer setShadowOffset:CGSizeMake(-8.0, 0)];
    [self.topView.layer setShadowOpacity:0.5];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewPanned:(UIPanGestureRecognizer *)pan{
    CGPoint translation = [pan translationInView:self.topView];
    if (pan.state == UIGestureRecognizerStateBegan){
        lastTranslation = 0.0;
    }
    if (pan.state == UIGestureRecognizerStateChanged){
        NSLog(@"translation: %f, %f", translation.x, translation.y);
        
        CGFloat dx = translation.x - lastTranslation;
        lastTranslation = translation.x;
        
        CGRect newFrame = CGRectOffset(self.topView.frame, dx, 0);
        if (newFrame.origin.x >= 0 && newFrame.origin.x <= SNAP_TO_X){
            self.topView.frame = newFrame;
        }
    }
    if (pan.state == UIGestureRecognizerStateEnded){
        CGFloat currentX = self.topView.frame.origin.x;
        CGFloat targetX = -1.0;
        if (currentX < SNAP_TO_THRESHOLD && currentX > 0.0)
        {
            targetX = 0.0;
        }
        else if (currentX >= SNAP_TO_THRESHOLD && currentX < SNAP_TO_X){
            targetX = SNAP_TO_X;
        }
        
        if (targetX >= 0.0)
        {
            [UIView animateWithDuration:SNAP_DURATION delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(){
                CGRect newFrame = self.topView.frame;
                newFrame.origin.x = targetX;
                self.topView.frame = newFrame;
            }
                             completion:nil];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touches began on view %d", [[touches anyObject] view].tag);
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    UITouch *theTouch = [touches anyObject];
    if (theTouch.view.tag == 2){
        float dx = [theTouch locationInView:self.view].x - [theTouch previousLocationInView:self.view].x;
        CGRect newRect = self.topView.frame;
        newRect.origin.x += dx;
        if (newRect.origin.x >= 0 && newRect.origin.x <= SNAP_TO_X){
            self.topView.frame = newRect;
        }
        
    }
    NSLog(@"touches moved on view %d", [[touches anyObject] view].tag);
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    UITouch *theTouch = [touches anyObject];
    
    if (theTouch.view.tag == 2){
        CGFloat currentX = theTouch.view.frame.origin.x;
        CGFloat targetX = -1.0;
        if (currentX < SNAP_TO_THRESHOLD && currentX > 0.0)
        {
            targetX = 0.0;
        }
        else if (currentX >= SNAP_TO_THRESHOLD && currentX < SNAP_TO_X){
            targetX = SNAP_TO_X;
        }
        
        if (targetX >= 0.0)
        {
            [UIView animateWithDuration:SNAP_DURATION delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(){
                CGRect newFrame = theTouch.view.frame;
                newFrame.origin.x = targetX;
                theTouch.view.frame = newFrame;
            }
                             completion:nil];
        }
    }
    
    NSLog(@"touches ended on view %d", [[touches anyObject] view].tag);
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"touches canceled on view %d", [[touches anyObject] view].tag);
}
@end
