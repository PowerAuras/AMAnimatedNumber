//
//  AMAnimatedNumber.m
//
//  Copyright (c) 2015 Mellong Lau
//  https://github.com/MellongLau/AMAnimatedNumber
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "AMAnimatedNumber.h"

@implementation AMAnimatedNumber
{
    AMAnimateNumberDirection _direction;
    NSArray <NSString *> *_allNumbersList;
    NSArray <UILabel *> *_labelsList;
    UIView *_maskView;
    NSString *_numbers;
}


- (void)setup
{
    if (_allNumbersList == nil) {
        _allNumbersList = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor clearColor];
        _maskView.clipsToBounds = YES;
                _maskView.layer.borderColor = [UIColor purpleColor].CGColor;
                _maskView.layer.borderWidth = 1;

        [self addSubview:_maskView];
    }
}

- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated
{
    [self setNumbers:numbers animated:animated direction:AMAnimateNumberDirectionUp alignment:NSTextAlignmentLeft];
}
- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated alignment:(NSTextAlignment)textAlignment
{
    [self setNumbers:numbers animated:animated direction:AMAnimateNumberDirectionUp alignment:textAlignment];
}
- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated direction:(AMAnimateNumberDirection)direction{
    [self setNumbers:numbers animated:animated direction:direction alignment:NSTextAlignmentLeft];
}
- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated direction:(AMAnimateNumberDirection)direction alignment:(NSTextAlignment)textAlignment;
{
    _numbers = numbers;
    _direction = direction;
    
    
    [self setup];
    
    [self setupLabels];
    switch (textAlignment) {
        case NSTextAlignmentLeft:
            
            break;
        case NSTextAlignmentCenter:
            [self centerLabels];
            break;
        case NSTextAlignmentRight:
            [self rightAlignment];
            break;
        default:
            break;
    }
    [self updateLabelsLayoutWithAnimated:animated];
}
-(void)rightAlignment{
    
    UILabel *lastView = _labelsList.lastObject;
    CGFloat offset = (CGRectGetWidth(_maskView.bounds) - CGRectGetMaxX(lastView.frame));
    for (UILabel *each in _labelsList) {
        each.frame = CGRectOffset(each.frame, offset, 0);
    }
    
    _maskView.frame = CGRectOffset(_maskView.bounds, 0, (CGRectGetHeight(self.bounds) - CGRectGetHeight(_maskView.bounds)) / 2);

}
-(void)centerLabels{
    UILabel *lastView = _labelsList.lastObject;
    CGFloat offset = (CGRectGetWidth(_maskView.bounds) - CGRectGetMaxX(lastView.frame)) / 2;
    for (UILabel *each in _labelsList) {
        each.frame = CGRectOffset(each.frame, offset, 0);
    }
    
    _maskView.frame = CGRectOffset(_maskView.bounds, 0, (CGRectGetHeight(self.bounds) - CGRectGetHeight(_maskView.bounds)) / 2);
}
- (void)setupLabels
{
    for (UIView *view in _maskView.subviews) {
        [view removeFromSuperview];
    }
    if (_numbers != nil && _numbers.length > 0) {
        
        _labelsList = [self generateLabels];
        CGRect frame = _maskView.frame;
        {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            label.text = @"1";
            label.font = _textFont == nil ? [UIFont systemFontOfSize:17.f]:_textFont;
            [label sizeToFit];
            frame.size.height = CGRectGetHeight(label.frame);
        }
        _maskView.frame = frame;
        
    }
}

- (NSArray *)generateLabels
{
    NSMutableArray<UILabel *> *labelsList = [NSMutableArray array];
    for (int i = 0; i < _numbers.length; i++) {
        NSString *stringItem = [_numbers substringWithRange:NSMakeRange(i, 1)];
        if ([self isNumberType:stringItem]) {
            NSString *text = [_allNumbersList componentsJoinedByString:@"\n"];
            UILabel *label = [self createLabels:text];
            
            CGRect frame = label.frame;
            frame.origin.x = labelsList.count > 0 ? CGRectGetMaxX(labelsList.lastObject.frame) : 0;
            frame.origin.y = stringItem.integerValue * label.bounds.size.height/_allNumbersList.count;
            label.frame = frame;
            [labelsList addObject:label];
        }else {
            UILabel *label = [self createLabels:stringItem];
            
            CGRect frame = label.frame;
            frame.origin.x = labelsList.count > 0 ? CGRectGetMaxX(labelsList.lastObject.frame) : 0;
            frame.origin.y = label.bounds.size.height;
            label.frame = frame;
            [labelsList addObject:label];
        }
    }
    return labelsList;
}

- (void)updateLabelsLayoutWithAnimated:(BOOL)animated
{
    for (int i = 0; i < _numbers.length; i++) {
        NSString *stringItem = [_numbers substringWithRange:NSMakeRange(i, 1)];
        UILabel *label = _labelsList[i];
        BOOL isNumber = [self isNumberType:stringItem];
       
        
        if (animated) {
            if (_direction == AMAnimateNumberDirectionDown) {
                CGRect frame = label.frame;
                frame.origin.y = -label.bounds.size.height;
                label.frame = frame;
            }
            [UIView animateWithDuration:0.6 delay:0.1+0.02*i options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                CGRect frame = label.frame;
                if (isNumber) {
                    frame.origin.y = -stringItem.integerValue * label.bounds.size.height/_allNumbersList.count;
                    
                }else {
                    frame.origin.y = 0;
                }
                label.frame = frame;
                
            } completion:^(BOOL finished) {
                
            }];
        }else {
            CGRect frame = label.frame;
            frame.origin.y = -stringItem.integerValue * label.bounds.size.height/_allNumbersList.count;
            label.frame = frame;
        }
            
    }
    
}

- (UILabel *)createLabels:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.text = title;
    label.font = _textFont == nil ? [UIFont systemFontOfSize:17.f]:_textFont;
    label.textColor = _textColor == nil ? [UIColor blackColor]:_textColor;
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    [_maskView addSubview:label];
    return label;
}

- (BOOL)isNumberType:(NSString *)string
{
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        return YES;
    }
    return NO;
}

@end
