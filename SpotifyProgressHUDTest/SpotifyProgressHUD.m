//
//  ProgressView.m
//  testdel
//
//  Created by Paolo Boschini on 8/8/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import "SpotifyProgressHUD.h"
#import <QuartzCore/QuartzCore.h>

@interface CircleView : UIView
@end

@implementation CircleView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(context, rect);
}
@end

@interface SpotifyProgressHUD () {
    CircleView *leftCircle;
    CircleView *middleCircle;
    CircleView *rightCircle;
}

@property float interval;
@property int pointDiameter;

@end

@implementation SpotifyProgressHUD

- (id)initWithFrame:(CGRect)frame withPointDiameter:(int)diameter withInterval:(float)interval {
    if ((self = [super initWithFrame:frame])) {

        self.interval = interval;
        self.pointDiameter = diameter;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.layer.cornerRadius = 15;

        leftCircle = [self addCircleViewWithXOffsetFromCenter:-35];
        middleCircle = [self addCircleViewWithXOffsetFromCenter:0];
        rightCircle = [self addCircleViewWithXOffsetFromCenter:35];

        self.animating = YES;
        NSArray *circles = @[leftCircle, middleCircle, rightCircle];
        [self animateWithViews:circles index:0 delay:self.interval*2 offset:self.pointDiameter];
        [self animateWithViews:circles index:1 delay:self.interval*3 offset:self.pointDiameter];
        [self animateWithViews:circles index:2 delay:self.interval*4 offset:self.pointDiameter];
    }
    return self;
}

- (CircleView*)addCircleViewWithXOffsetFromCenter:(float)offset {
    CGRect rect = CGRectMake(0, 0, self.pointDiameter, self.pointDiameter);
    CircleView *circle = [[CircleView alloc] initWithFrame:rect];
    circle.center = self.center;
    circle.frame = CGRectOffset(circle.frame, offset, 0);
    [self addSubview:circle];
    return circle;
}

- (void)animateWithViews:(NSArray*)circles index:(int)index delay:(float)delay offset:(float)offset {
    UIView *view = ((CircleView*)[circles objectAtIndex:index]);
    [UIView animateWithDuration:0.2 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        view.frame = CGRectMake(view.frame.origin.x - offset/2,
                                view.frame.origin.y - offset/2,
                                view.frame.size.width + offset,
                                view.frame.size.height + offset);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.frame = CGRectMake(view.frame.origin.x + offset/2,
                                    view.frame.origin.y + offset/2,
                                    view.frame.size.width - offset,
                                    view.frame.size.height - offset);
        } completion:^(BOOL finished) {
            if (self.animating) {
                if (index == 2) {
                    [self animateWithViews:circles index:0 delay:self.interval*2 offset:self.pointDiameter];
                    [self animateWithViews:circles index:1 delay:self.interval*3 offset:self.pointDiameter];
                    [self animateWithViews:circles index:2 delay:self.interval*4 offset:self.pointDiameter];
                }
            }
        }];
    }];
}

@end