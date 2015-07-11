//
//  UINavigationBar+ExtendedPrompt.m
//  NavBarTopReminder
//
//  Created by Nic on 15/7/11.
//  Copyright (c) 2015年 imnic. All rights reserved.
//

#import "UINavigationBar+ExtendedPrompt.h"
#import "objc/runtime.h"

static NSTimeInterval DefaultAnimationDuration  = 0.5f;
static NSTimeInterval DefaultDisplayDuration    = 0.6f;
static float DefaultTextFontSize                = 16.0f;
static CGFloat DefaultBackgroundHeight          = 44.0f;
static BOOL animating                           = NO;

@implementation UINavigationBar (ExtendedPrompt)

- (UILabel *)extendedPromptLabel {
    
    UILabel *label = objc_getAssociatedObject(self, @selector(extendedPromptLabel));
    
    if (!label) {
        label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        objc_setAssociatedObject(self, @selector(extendedPromptLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }

    return label;
}

- (void)showExtendedPromptWithText:(NSString *)text {
    [self showExtendedPromptWithText:text
                           textColor:[UIColor whiteColor]
                            textFont:[UIFont systemFontOfSize:DefaultTextFontSize]
                     backgroundColor:[UIColor orangeColor]
                    backgroundHeight:DefaultBackgroundHeight
                   animationDuration:DefaultAnimationDuration
                     displayDuration:DefaultDisplayDuration];
}

- (void)showExtendedPromptWithText:(NSString *)text
                         textColor:(UIColor *)textColor
                          textFont:(UIFont *)textFont
                   backgroundColor:(UIColor *)backgroundColor
                  backgroundHeight:(CGFloat)backgroundHeight
                 animationDuration:(NSTimeInterval)animationDuration
                   displayDuration:(NSTimeInterval)displayDuration {
    
    if (animating) {
        return;
    }
    
    animating = YES;
    
    textColor = textColor?textColor:[UIColor whiteColor];
    textFont = textFont?textFont:[UIFont systemFontOfSize:DefaultTextFontSize];
    backgroundColor = backgroundColor?backgroundColor:[UIColor orangeColor];
    animationDuration = (animationDuration > 0.0)?animationDuration:DefaultAnimationDuration;
    displayDuration = (displayDuration > 0.0)?displayDuration:DefaultDisplayDuration;
    
    //  calculate the fit height for the prompt text
    NSDictionary *attributes = @{NSFontAttributeName: textFont};
    CGFloat fitTextHeight = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    backgroundHeight = (backgroundHeight > 0.0)?backgroundHeight:DefaultBackgroundHeight;
    backgroundHeight = (backgroundHeight < fitTextHeight)?fitTextHeight:DefaultBackgroundHeight;
        
    CGRect originFrame = CGRectMake(0, CGRectGetHeight(self.frame) - backgroundHeight, CGRectGetWidth(self.frame), backgroundHeight);
    
    UILabel *label = self.extendedPromptLabel;
    label.text = text;
    label.textColor = textColor;
    label.font = textFont;
    label.numberOfLines = 0;
    label.backgroundColor = backgroundColor;
    label.frame = originFrame;
    [self addSubview:label];
    [self sendSubviewToBack:label];
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        label.frame = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), backgroundHeight);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:animationDuration delay:displayDuration options:UIViewAnimationOptionCurveLinear animations:^{
            
            label.frame = originFrame;
            
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
            
            animating = NO;
        }];
        
    }];
}

@end
