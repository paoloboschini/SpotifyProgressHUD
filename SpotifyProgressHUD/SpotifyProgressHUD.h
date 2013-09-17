//
//  ProgressView.h
//  testdel
//
//  Created by Paolo Boschini on 8/8/13.
//  Copyright (c) 2013 Paolo Boschini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpotifyProgressHUD : UIView

@property BOOL animating;

- (id)initWithFrame:(CGRect)frame
  withPointDiameter:(int)diameter
       withInterval:(float)interval;

@end
