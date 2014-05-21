//
//  NumberPadViewController.m
//  NumberPad
//
//  Created by Skylar Peterson on 7/30/13.
//  Copyright (c) 2013 Skylar Peterson. All rights reserved.
//

#import "NumberPadViewController.h"
#import "NumberPadBrain.h"

@interface NumberPadViewController ()

@end

@implementation NumberPadViewController{
    UILabel *_mainLabel;
    NumberPadBrain *_brain;
}

#define DIVISOR 4

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    CGFloat buttonWidth = self.view.bounds.size.width / DIVISOR;
    NSInteger startingY = (self.view.bounds.size.height - 4 * (buttonWidth)) - 1;
    for (NSInteger i = 0; i < 9; i++) {
        NSInteger multiplierX = i % 3;
        NSInteger multiplierY = i / 3;
        [self initButtonWithLabel:[NSString stringWithFormat:@"%i", i + 1] inFrame:CGRectMake(multiplierX * (buttonWidth) + 0.5, startingY + multiplierY * (buttonWidth), buttonWidth, buttonWidth)];
    }
    
    [self initButtonWithLabel:@"0" inFrame:CGRectMake(0.5, startingY + 3 * (buttonWidth), 2 * buttonWidth, buttonWidth)];
    [self initButtonWithLabel:@"." inFrame:CGRectMake(2 * buttonWidth + 0.5, startingY + 3 * (buttonWidth), buttonWidth, buttonWidth)];
    
    [self initOperationButtonWithLabel:@"\u00f7" inFrame:CGRectMake(3 * buttonWidth + 0.5, startingY - buttonWidth, buttonWidth, buttonWidth)];
    [self initOperationButtonWithLabel:@"x" inFrame:CGRectMake(3 * buttonWidth + 0.5, startingY, buttonWidth, buttonWidth)];
    [self initOperationButtonWithLabel:@"–" inFrame:CGRectMake(3 * buttonWidth + 0.5, startingY + buttonWidth, buttonWidth, buttonWidth)];
    [self initOperationButtonWithLabel:@"+" inFrame:CGRectMake(3 * buttonWidth + 0.5, startingY + 2 * buttonWidth, buttonWidth, buttonWidth)];
    [self initOperationButtonWithLabel:@"=" inFrame:CGRectMake(3 * buttonWidth + 0.5, startingY + 3 * buttonWidth, buttonWidth, buttonWidth)];
    
    [self initTopButtonWithLabel:@"C" inFrame:CGRectMake(0.5, startingY - buttonWidth, buttonWidth, buttonWidth)];
    [self initTopButtonWithLabel:@"\u00b1" inFrame:CGRectMake(0.5 + buttonWidth, startingY - buttonWidth, buttonWidth, buttonWidth)];
    [self initTopButtonWithLabel:@"%" inFrame:CGRectMake(0.5 + 2 * buttonWidth, startingY - buttonWidth, buttonWidth, buttonWidth)];
    
    _mainLabel = [[UILabel alloc] init];
    _mainLabel.textColor = [UIColor whiteColor];
    _mainLabel.text = @"0";
    _mainLabel.textAlignment = NSTextAlignmentRight;
    _mainLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:54.0];
    _mainLabel.frame = CGRectMake(5, 30, self.view.bounds.size.width - 10, self.view.bounds.size.height - 40 - 4 * buttonWidth);
    [self.view addSubview:_mainLabel];
}

- (void)addBorderToButton:(UIButton *)button
{
    CALayer *borderLayer = [button layer];
    [borderLayer setMasksToBounds:YES];
    [borderLayer setCornerRadius:0.0];
    [borderLayer setBorderWidth:0.25];
    [borderLayer setBorderColor:[[UIColor blackColor] CGColor]];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)initButtonWithLabel:(NSString *)label inFrame:(CGRect)frame
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:36.0];
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:216.0/255.0 green:217.0/255.0 blue:220.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:216.0/255.0 green:217.0/255.0 blue:220.0/255.0 alpha:0.9]] forState:UIControlStateHighlighted];
    [self addBorderToButton:button];
    button.frame = frame;
    [self.view addSubview:button];
}

- (void)initOperationButtonWithLabel:(NSString *)label inFrame:(CGRect)frame
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:36.0];
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:247.0/255.0 green:143.0/255.0 blue:18.0/255.0 alpha:1.0]] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:247.0/255.0 green:143.0/255.0 blue:18.0/255.0 alpha:0.9]] forState:UIControlStateHighlighted];
    [self addBorderToButton:button];
    button.frame = frame;
    [self.view addSubview:button];
}

- (void)initTopButtonWithLabel:(NSString *)label inFrame:(CGRect)frame
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:24.0];
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:216.0/255.0 green:217.0/255.0 blue:220.0/255.0 alpha:0.95]] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:216.0/255.0 green:217.0/255.0 blue:220.0/255.0 alpha:0.9]] forState:UIControlStateHighlighted];
    [self addBorderToButton:button];
    button.frame = frame;
    [self.view addSubview:button];
}

@end
