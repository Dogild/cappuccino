/*
 * CPDateFormatter.j
 * Foundation
 *
 * Created by Alexander Ljungberg.
 * Copyright 2012, SlevenBits Ltd.
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

@import "CPDate.j"
@import "CPString.j"
@import "CPFormatter.j"
@import "CPLocale.j"

CPDateFormatterNoStyle     = 0;
CPDateFormatterShortStyle  = 1;
CPDateFormatterMediumStyle = 2;
CPDateFormatterLongStyle   = 3;
CPDateFormatterFullStyle   = 4;

CPDateFormatterBehaviorDefault = 0;
CPDateFormatterBehavior10_0    = 1000;
CPDateFormatterBehavior10_4    = 1040;

var defaultDateFormatterBehavior = CPDateFormatterBehaviorDefault;

/*!
    @ingroup foundation
    @class CPDateFormatter

    * Not yet implemented. This is a stub class. *

    CPDateFormatter takes a CPDate value and formats it as text for
    display. It also supports the converse, taking text and interpreting it as a
    CPDate by configurable formatting rules.
*/
@implementation CPDateFormatter : CPFormatter
{
    BOOL                    _allowNaturalLanguage;              @accessors(property=allowNaturalLanguage, readonly);
    BOOL                    _doesRelativeDateFormatting         @accessors(property=doesRelativeDateFormatting);
    CPArray                 _weekdaySymbols                     @accessors(property=weekdaySymbols);
    CPArray                 _shortWeekdaySymbols                @accessors(property=shortWeekdaySymbols);
    CPArray                 _veryShortWeekdaySymbols            @accessors(property=veryShortWeekdaySymbols);
    CPArray                 _standaloneWeekdaySymbols           @accessors(property=standaloneWeekdaySymbols);
    CPArray                 _shortStandaloneWeekdaySymbols      @accessors(property=shortStandaloneWeekdaySymbols);
    CPArray                 _veryShortStandaloneWeekdaySymbols  @accessors(property=veryShortSandaloneWeekdaySymbols);
    CPArray                 _monthSymbols                       @accessors(property=monthSymbols);
    CPArray                 _shortMonthSymbols                  @accessors(property=shortMonthSymbols);
    CPArray                 _veryShortMonthSymbols              @accessors(property=veryShortMonthSymbols);
    CPArray                 _standaloneMonthSymbols             @accessors(property=standaloneMonthSymbols);
    CPArray                 _shortStandaloneMonthSymbols        @accessors(property=shortStandaloneMonthSymbols);
    CPArray                 _veryShortStandaloneMonthSymbols    @accessors(property=veryShortSandaloneMonthSymbols);
    CPArray                 _quarterSymbols                     @accessors(property=quarterSymbols);
    CPArray                 _shortQuarterSymbols                @accessors(property=shortQuarterSymbols);
    CPArray                 _standaloneQuarterSymbols           @accessors(property=standaloneQuarterSymbols);
    CPArray                 _shortSandaloneQuarterSymbols       @accessors(property=shortStandaloneQuarterSymbols);
    CPDate                  _defaultDate                        @accessors(property=defaultDate);
    CPDate                  _twoDigitStartDate                  @accessors(property=twoDigitStartDate);
    CPDateFormatterBehavior _formatterBehavior                  @accessors(property=formatterBehavior);
    CPDateFormatterStyle    _dateStyle                          @accessors(property=dateStyle);
    CPDateFormatterStyle    _timeStyle                          @accessors(property=timeStyle);
    CPLocale                _locale                             @accessors(property=locale);
    CPString                _AMSymbol                           @accessors(property=AMSymbol);
    CPString                _dateFormat                         @accessors(property=dateFormat);
    CPString                _PMSymbol                           @accessors(property=PMSymbol);
}

+ (CPString)localizedStringFromDate:(CPDate)aDate dateStyle:(CPDateFormatterStyle)dateStyle timeStyle:(CPDateFormatterStyle)timeStyle
{
    var formatter = [[CPDateFormatter alloc] init];

    [formatter setFormatterBehavior:CPDateFormatterBehavior10_4];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];

    return [formatter stringForObjectValue:date];
}

+ (CPString)dateFormatFromTemplate:(CPString)template options:(CPUInteger)opts locale:(CPLocale)locale
{

}

+ (CPDateFormatterBehavior)defaultFormatterBehavior
{
    return defaultDateFormatterBehavior;
}

+ (void)setDefaultFormatterBehavior:(CPDateFormatterBehavior)behavior
{
    defaultDateFormatterBehavior = behavior;
}

- (id)init
{
    if (self = [super init])
    {
        _dateStyle = CPDateFormatterShortStyle;
        _timeStyle = CPDateFormatterShortStyle;
        _AMSymbol = @"AM";
        _PMSymbole = @"PM";
    }

    return self;
}

- (id)initWithDateFormat:(CPString)format allowNaturalLanguage:(BOOL)flag
{
    if (self = [self init])
    {
        _dateFormat = format;
        _allowNaturalLanguage = flag;
    }

    return self
}

- (CPString)stringFromDate:(CPDate)aDate
{
    // TODO Add locale support.
    switch (_dateStyle)
    {
        case CPDateFormatterShortStyle:
            var format = "d/m/Y";
            return aDate.dateFormat(format);

        default:
            return [aDate description];
    }
}

- (CPDate)dateFromString:(CPString)aString
{
    if (!aString)
        return nil;

    switch (_dateStyle)
    {
        case CPDateFormatterShortStyle:
            var format = "d/m/Y";
            return Date.parseDate(aString, format);

        default:
            return Date.parseDate(aString);
    }
}

- (CPString)stringForObjectValue:(id)anObject
{
    if ([anObject isKindOfClass:[CPDate class]])
        return [self stringFromDate:anObject];
    else
        return [anObject description];
}

- (CPString)editingStringForObjectValue:(id)anObject
{
    return [self stringForObjectValue:anObject];
}

- (BOOL)getObjectValue:(id)anObject forString:(CPString)aString errorDescription:(CPString)anError
{
    // TODO Error handling.
    var value = [self dateFromString:aString];
    @deref(anObject) = value;

    return YES;
}

@end

var CPDateFormatterStyleKey = @"CPDateFormatterStyle",
    CPDateFormatterLocaleKey = @"CPDateFormatterLocaleKey";

@implementation CPDateFormatter (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder
{
    self = [super initWithCoder:aCoder];

    if (self)
    {
        _dateStyle = [aCoder decodeIntForKey:CPDateFormatterStyleKey];
        _locale = [aCoder decodeObjectForKey:CPDateFormatterLocaleKey];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeInt:_dateStyle forKey:CPDateFormatterStyleKey];
    [aCoder encodeInt:_locale forKey:CPDateFormatterLocaleKey];
}

@end
