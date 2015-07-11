//
//  UINavigationBar+ExtendedPrompt.h
//  NavBarTopReminder
//
//  Created by Nic on 15/7/11.
//  Copyright (c) 2015年 imnic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ExtendedPrompt)

- (void)showExtendedPromptWithText:(NSString *)text;

- (void)showExtendedPromptWithText:(NSString *)text
                         textColor:(UIColor *)textColor
                          textFont:(UIFont *)textFont
                   backgroundColor:(UIColor *)backgroundColor
                  backgroundHeight:(CGFloat)backgroundHeight
                 animationDuration:(NSTimeInterval)animationDuration
                   displayDuration:(NSTimeInterval)displayDuration;

@end
