/*
 * _CPMenuItemMenuBarView.j
 * AppKit
 *
 * Created by Francisco Tolmasky.
 * Copyright 2009, 280 North, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import "CPControl.j"
@import "_CPImageAndTextView.j"

@class _CPMenuBarWindow
@class _CPMenuView

@implementation _CPMenuItemMenuBarView : CPView
{
    CPMenuItem              _menuItem @accessors(property=menuItem);

    CPFont                  _font;
    CPColor                 _textColor;
    CPColor                 _textShadowColor;

    BOOL                    _isDirty;

    _CPImageAndTextView     _imageAndTextView;
}

+ (CPString)defaultThemeClass
{
    return "menu-item-bar-view";
}

+ (id)themeAttributes
{
    return [CPDictionary dictionaryWithObjects:[[CPNull null], [CPNull null], 12.0, 3.0, 4.0]
                                       forKeys:[    @"menu-item-selection-color",
                                                    @"menu-item-text-shadow-color",
                                                    @"horizontal-margin",
                                                    @"submenu-indicator-margin",
                                                    @"vertical-margin"]];
}

+ (id)view
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];

    if (self)
    {
        _imageAndTextView = [[_CPImageAndTextView alloc] initWithFrame:CGRectMake([self valueForThemeAttribute:@"horizontal-margin"], 0.0, 0.0, 0.0)];

        [_imageAndTextView setImagePosition:CPImageLeft];
        [_imageAndTextView setImageOffset:3.0];
        [_imageAndTextView setTextShadowOffset:CGSizeMake(0.0, 1.0)];
        [_imageAndTextView setAutoresizingMask:CPViewMinYMargin | CPViewMaxYMargin];

        [self addSubview:_imageAndTextView];

        [self setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
    }

    return self;
}

- (CPColor)textColor
{
    if (![_menuItem isEnabled])
        return [CPColor lightGrayColor];

    return _textColor || [CPColor colorWithCalibratedRed:70.0 / 255.0 green:69.0 / 255.0 blue:69.0 / 255.0 alpha:1.0];
}

- (CPColor)textShadowColor
{
    if (![_menuItem isEnabled])
        return [CPColor clearColor];

    return _textShadowColor || [CPColor colorWithWhite:1.0 alpha:0.8];
}

- (void)update
{
    var x = [self valueForThemeAttribute:@"horizontal-margin"],
        height = 0.0;

    [_imageAndTextView setFont:[_menuItem font] || [_CPMenuBarWindow font]];
    [_imageAndTextView setVerticalAlignment:CPCenterVerticalTextAlignment];
    [_imageAndTextView setImage:[_menuItem image]];
    [_imageAndTextView setText:[_menuItem title]];
    [_imageAndTextView setTextColor:[self textColor]];
    [_imageAndTextView setTextShadowColor:[self textShadowColor]];
    [_imageAndTextView setTextShadowOffset:CGSizeMake(0.0, 1.0)];
    [_imageAndTextView sizeToFit];

    var imageAndTextViewFrame = [_imageAndTextView frame];

    imageAndTextViewFrame.origin.x = x;
    x += CGRectGetWidth(imageAndTextViewFrame);
    height = MAX(height, CGRectGetHeight(imageAndTextViewFrame)) + 2.0 * [self valueForThemeAttribute:@"vertical-margin"];

    imageAndTextViewFrame.origin.y = FLOOR((height - CGRectGetHeight(imageAndTextViewFrame)) / 2.0);
    [_imageAndTextView setFrame:imageAndTextViewFrame];

    [self setAutoresizesSubviews:NO];
    [self setFrameSize:CGSizeMake(x + [self valueForThemeAttribute:@"horizontal-margin"], height)];
    [self setAutoresizesSubviews:YES];
}

- (void)highlight:(BOOL)shouldHighlight
{
    // FIXME: This should probably be even throw.
    if (![_menuItem isEnabled])
        shouldHighlight = NO;

    if (shouldHighlight)
    {
        if (![_menuItem _isMenuBarButton])
            [self setBackgroundColor:[[CPTheme defaultTheme] valueForAttributeWithName:@"menu-bar-window-background-selected-color" forClass:_CPMenuView]];

        [_imageAndTextView setImage:[_menuItem alternateImage] || [_menuItem image]];
        [_imageAndTextView setTextColor:[CPColor whiteColor]];
        [_imageAndTextView setTextShadowColor:[self valueForThemeAttribute:@"menu-item-text-shadow-color"]];
    }
    else
    {
        [self setBackgroundColor:nil];

        [_imageAndTextView setImage:[_menuItem image]];
        [_imageAndTextView setTextColor:[self textColor]];
        [_imageAndTextView setTextShadowColor:[self textShadowColor]];
    }
}

@end
