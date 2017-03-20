//
//  AMAnimatedNumber.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AMAnimateNumberDirection)
{
    AMAnimateNumberDirectionUp = 0,
    AMAnimateNumberDirectionDown
};

@interface AMAnimatedNumber : UIView

@property (nonatomic, strong) UIColor *textColor; // Label text color, default text color is black color.
@property (nonatomic, strong) UIFont *textFont; // Label text font, default text font is [UIFont systemFontOfSize:17.f].


/**
 *  Set numbers with default direction type AMAnimateNumberDirectionUp.
 *
 *  @param numbers  numbers string.
 *  @param animated animation.
 */
- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated;

/**
 *  Set numbers.
 *
 *  @param numbers   numbers string.
 *  @param animated  animation.
 *  @param direction direction type AMAnimateNumberDirectionUp or AMAnimateNumberDirectionDown.
 */
- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated direction:(AMAnimateNumberDirection)direction;

- (void)setNumbers:(NSString *)numbers animated:(BOOL)animated alignment:(NSTextAlignment)textAlignment;

@end
