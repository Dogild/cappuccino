/*
 * ThemeDescriptors.j
 * FlatWhite
 *
 * Created by You on January 21, 2015
 * Copyright 2015, Your Company. All rights reserved.
 */

@import <BlendKit/BKThemeDescriptor.j>
@import "FWSkin.j"

var themedTextFieldValues          = nil,
    themedWindowViewValues         = nil,

    regularTextColor               = [CPColor colorWithCalibratedWhite:79.0 / 255.0 alpha:1.0],
    regularTextShadowColor         = [CPColor colorWithCalibratedWhite:1.0 alpha:0.2],
    regularDisabledTextColor       = [CPColor colorWithCalibratedWhite:79.0 / 255.0 alpha:0.6],
    regularDisabledTextShadowColor = [CPColor colorWithCalibratedWhite:240.0 / 255.0 alpha:0.6],

    defaultTextColor               = [CPColor whiteColor],
    defaultTextShadowColor         = [CPColor colorWithCalibratedWhite:0.0 alpha:0.3],
    defaultDisabledTextColor       = regularDisabledTextColor,
    defaultDisabledTextShadowColor = regularDisabledTextShadowColor,

    placeholderColor               = regularDisabledTextColor;

@implementation FlatWhiteThemeDescriptor : BKThemeDescriptor

+ (CPString)themeName
{
    return @"FlatWhite";
}

+ (CPArray)themeShowcaseExcludes
{
    return ["themedAlert",
            "themedMenuView",
            "themedMenuItemStandardView",
            "themedMenuItemMenuBarView",
            "themedToolbarView",
            "themedBorderlessBridgeWindowView",
            "themedWindowView",
            "themedBrowser",
            "themedRuleEditor",
            "themedTableDataView",
            "themedCornerview",
            "themedTokenFieldTokenCloseButton"];
}

+ (CPButton)makeButton
{
    return [[CPButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 75.0, 25)];
}

+ (CPButton)button
{
    var button = [self makeButton],
        themedButtonValues = [
                [@"text-color",                 FWSkinButtonTextColor],
                [@"text-color",                 FWSkinButtonTextColor,                      CPThemeStateBordered],
                [@"text-color",                 FWSkinDefaultButtonDisabledTextColor,       [CPThemeStateDisabled, CPThemeStateDefault]],
                [@"text-color",                 FWSkinDefaultButtonTextColor,               CPThemeStateDefault],
                [@"text-color",                 FWSkinButtonDisabledTextColor,              CPThemeStateDisabled],
                [@"line-break-mode",            CPLineBreakByTruncatingTail],

                [@"bezel-color",                FWSkinButtonBackgroundColor,                CPThemeStateBordered],
                [@"bezel-color",                FWSkinButtonHoverBackgroundColor,           [CPThemeStateBordered, CPThemeStateHighlighted]],
                [@"bezel-color",                FWSkinButtonDisabledBackgroundColor,        [CPThemeStateBordered, CPThemeStateDisabled]],
                [@"bezel-color",                FWSkinDefaultButtonBackgroundColor,         [CPThemeStateBordered, CPThemeStateDefault]],
                [@"bezel-color",                FWSkinDefaultButtonHoverBackgroundColor,    [CPThemeStateBordered, CPThemeStateDefault, CPThemeStateHighlighted]],
                [@"bezel-color",                FWSkinDefaultButtonDisabledBackgroundColor, [CPThemeStateBordered, CPThemeStateDefault, CPThemeStateDisabled]],

                [@"content-inset",              CGInsetMake(0.0, 0.0, 1.0, 0.0),            CPThemeStateBordered],
                [@"image-offset",               CPButtonImageOffset],

                // normal
                [@"nib2cib-adjustment-frame",   CGRectMake(2.0, 10.0, 0.0, 0.0),            CPThemeStateBordered],
                [@"min-size",                   CGSizeMake(-1, 21),                         CPThemeStateBordered],
                [@"max-size",                   CGSizeMake(-1, 21),                         CPThemeStateBordered],

                // small
                [@"nib2cib-adjustment-frame",   CGRectMake(-3.0, 9.0, 0.0, 0.0),            [CPThemeStateControlSizeSmall, CPThemeStateBordered]],
                [@"min-size",                   CGSizeMake(0.0, 18.0),                      CPThemeStateControlSizeSmall, CPThemeStateBordered],
                [@"max-size",                   CGSizeMake(-1.0, 18.0),                     CPThemeStateControlSizeSmall, CPThemeStateBordered],
        ]

    [self registerThemeValues:themedButtonValues forView:button];

    return button;
}

+ (CPButton)themedStandardButton
{
    var button = [self button];
    [button setTitle:@"Cancel"];
    return button;
}

+ (CPButton)themedDefaultButton
{
    var button = [self button];

    [button setTitle:@"OK"];
    [button setThemeState:CPThemeStateDefault];

    return button;
}

+ (CPButton)themedRoundedButton
{
    var button = [self button];
    console.log([CPView _themeAttributes]);
    [button setTitle:@"Save"];
    [button setThemeState:CPButtonStateBezelStyleRounded];

    return button;
}

+ (CPButton)themedDefaultRoundedButton
{
    var button = [self button];

    [button setTitle:@"OK"];
    [button setThemeState:[CPButtonStateBezelStyleRounded, CPThemeStateDefault]];

    return button;
}


@end
