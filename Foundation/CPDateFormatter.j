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

@import "CPArray.j"
@import "CPDate.j"
@import "CPString.j"
@import "CPFormatter.j"
//@import "CPLocale.j"

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
    BOOL                    _allowNaturalLanguage               @accessors(property=allowNaturalLanguage, readonly);
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
    //CPLocale                _locale                             @accessors(property=locale);
    CPString                _AMSymbol                           @accessors(property=AMSymbol);
    CPString                _dateFormat                         @accessors(property=dateFormat);
    CPString                _PMSymbol                           @accessors(property=PMSymbol);
}

/*! Return a string representation of the given date, dateStyle and timeStyle
    @param date the given date
    @param dateStyle the dateStyle
    @param timeStyle the timeStyle
    @return a CPString reprensenting the given date
*/
+ (CPString)localizedStringFromDate:(CPDate)date dateStyle:(CPDateFormatterStyle)dateStyle timeStyle:(CPDateFormatterStyle)timeStyle
{
    var formatter = [[CPDateFormatter alloc] init];

    [formatter setFormatterBehavior:CPDateFormatterBehavior10_4];
    [formatter setDateStyle:dateStyle];
    [formatter setTimeStyle:timeStyle];

    return [formatter stringForObjectValue:date];
}

/*! Return a string representation of the given template, opts and locale
    @param template the template
    @param opts, pass 0
    @param locale the locale
    @return a CPString representing the givent template
*/
+ (CPString)dateFormatFromTemplate:(CPString)template options:(CPUInteger)opts locale:(CPLocale)locale
{

}

/*! Return the defaultFormatterBehavior
    @return a CPDateFormatterBehavior
*/
+ (CPDateFormatterBehavior)defaultFormatterBehavior
{
    return defaultDateFormatterBehavior;
}

/*! Set the defaultFormatterBehavior
    @param behavior
*/
+ (void)setDefaultFormatterBehavior:(CPDateFormatterBehavior)behavior
{
    defaultDateFormatterBehavior = behavior;
}

/*! Init a dateFormatter
    @return a new CPDateFormatter
*/
- (id)init
{
    if (self = [super init])
    {
        _dateStyle = CPDateFormatterShortStyle;
        _timeStyle = CPDateFormatterShortStyle;

        [self _init];
    }

    return self;
}

/*! Init a dateFormatter with a format and the naturalLanguage
    @param format the format
    @param flag flag representation of allowNaturalLanguage
    @return a new CPDateFormatter
*/
- (id)initWithDateFormat:(CPString)format allowNaturalLanguage:(BOOL)flag
{
    if (self = [self init])
    {
        _dateFormat = format;
        _allowNaturalLanguage = flag;
    }

    return self
}

/*! Private init
*/
- (void)_init
{
    // TODO :  these datas have to be in CPUserDefault
    _AMSymbol = [CPString stringWithFormat:@"%s", @"AM"];
    _PMSymbole = [CPString stringWithFormat:@"%s", @"PM"];

    _weekdaySymbols = [CPArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
    _shortWeekdaySymbols = [CPArray arrayWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
    _veryShortWeekdaySymbols = [CPArray arrayWithObjects:@"S", @"M", @"T", @"W", @"T", @"F", @"S"];
    _standaloneWeekdaySymbols = [CPArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
    _shortStandaloneWeekdaySymbols = [CPArray arrayWithObjects:@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];
    _veryShortStandaloneWeekdaySymbols = [CPArray arrayWithObjects:@"S", @"M", @"T", @"W", @"T", @"F", @"S"];

    _monthSymbols = [CPArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    _shortMonthSymbols = [CPArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    _veryShortMonthSymbols = [CPArray arrayWithObjects:@"J", @"F", @"M", @"A", @"M", @"J", @"J", @"A", @"S", @"O", @"N", @"D"];
    _standaloneMonthSymbols = [CPArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    _shortStandaloneMonthSymbols = [CPArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    _veryShortStandaloneMonthSymbols = [CPArray arrayWithObjects:@"J", @"F", @"M", @"A", @"M", @"J", @"J", @"A", @"S", @"O", @"N", @"D"];

    _quarterSymbols = [CPArray arrayWithObjects:@"1st quarter", @"2nd quarter", @"3rd quarter", @"4th quarter"];
    _shortQuarterSymbols = [CPArray arrayWithObjects:@"Q1", @"Q2", @"Q3", @"Q4"];
    _standaloneQuarterSymbols = [CPArray arrayWithObjects:@"1st quarter", @"2nd quarter", @"3rd quarter", @"4th quarter"];
    _shortStandaloneQuarterSymbols = [CPArray arrayWithObjects:@"Q1", @"Q2", @"Q3", @"Q4"];
}

/*! Return a string representation of a given date.
    This method returns (if possible) a representation of the given date with the dateFormat of the CPDateFormatter, otherwise it takes the dateStyle and timeStyle
    @param aDate the given date
    @return CPString the string representation
*/
- (CPString)stringFromDate:(CPDate)aDate
{
    if (!aDate)
        return;

    var format;

    if (_dateFormat)
        return [self _stringFromDate:aDate format:_dateFormat];

    switch (_dateStyle)
    {
        case CPDateFormatterNoStyle:
            format = @"";
            break;

        case CPDateFormatterShortStyle:

            if ([self _isAmericanFormat])
                format = @"M/d/yy";
            else
                format = @"dd/MM/yy";

            break;

        case CPDateFormatterMediumStyle:

            if ([self _isAmericanFormat])
                format = @"MMM d, Y";
            else
                format = @"d MMM Y";
            break;

        case CPDateFormatterLongStyle:

            if ([self _isAmericanFormat])
                format = @"MMMM d, Y";
            else
                format = @"d MMMM Y";
            break;

        case CPDateFormatterFullStyle:

            if ([self _isAmericanFormat])
                format = @"EEEE, MMMM d, Y";
            else
                format = @"EEEE d MMMM Y";
            break;

        default:
            format = @"";
    }

    switch (_timeStyle)
    {
        case CPDateFormatterNoStyle:
            format += @"";
            break;

        case CPDateFormatterShortStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm a";
            else
                format += @" H:mm";
            break;

        case CPDateFormatterMediumStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm:ss a";
            else
                format += @" H:mm:ss"
            break;

        case CPDateFormatterLongStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm:ss a z";
            else
                format += @" H:mm:ss z";
            break;

        case CPDateFormatterFullStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm:ss a zzzz";
            else
                format += @" h:mm:ss zzzz";
            break;

        default:
            format += @"";
    }

    return [self _stringFromDate:aDate format:format];
}

/*! Return a date of the given string
    This method returns (if possible) a representation of the given string with the dateFormat of the CPDateFormatter, otherwise it takes the dateStyle and timeStyle
    @param aString
    @return CPDate the date
*/
- (CPDate)dateFromString:(CPString)aString
{
    if (!aString)
        return nil;

    var format;

    if (_dateFormat)
        return [self _dateFromString:aString format:_dateFormat];

    switch (_dateStyle)
    {
        case CPDateFormatterNoStyle:
            format = @"";
            break;

        case CPDateFormatterShortStyle:

            if ([self _isAmericanFormat])
                format = @"M/d/yy";
            else
                format = @"dd/MM/yy";

            break;

        case CPDateFormatterMediumStyle:

            if ([self _isAmericanFormat])
                format = @"MMM d, Y";
            else
                format = @"d MMM Y";
            break;

        case CPDateFormatterLongStyle:

            if ([self _isAmericanFormat])
                format = @"MMMM d, Y";
            else
                format = @"d MMMM Y";
            break;

        case CPDateFormatterFullStyle:

            if ([self _isAmericanFormat])
                format = @"EEEE, MMMM d, Y";
            else
                format = @"EEEE d MMMM Y";
            break;

        default:
            format = @"";
    }

    switch (_timeStyle)
    {
        case CPDateFormatterNoStyle:
            format += @"";
            break;

        case CPDateFormatterShortStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm a";
            else
                format += @" H:mm";
            break;

        case CPDateFormatterMediumStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm:ss a";
            else
                format += @" H:mm:ss"
            break;

        case CPDateFormatterLongStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm:ss a z";
            else
                format += @" H:mm:ss z";
            break;

        case CPDateFormatterFullStyle:

            if ([self _isEnglishFormat])
                format += @" h:mm:ss a zzzz";
            else
                format += @" h:mm:ss zzzz";
            break;

        default:
            format += @"";
    }

    return [self _dateFromString:aString format:format];
}

/*! Return a string representation of the given objectValue.
    This method call the method stringFromDate if possible, otherwise it returns the description of the object
    @param anObject
    @return a string
*/
- (CPString)stringForObjectValue:(id)anObject
{
    if ([anObject isKindOfClass:[CPDate class]])
        return [self stringFromDate:anObject];
    else
        return [anObject description];
}

/*! Return a string
    This method call the method stringForObjectValue
    @param anObject
    @return a string
*/
- (CPString)editingStringForObjectValue:(id)anObject
{
    return [self stringForObjectValue:anObject];
}

/*! Returns a boolean if the given object has been changed or not depending of the given string (use of ref)
    @param anObject the given object
    @param aString
    @param anError, if it returns NO the describe error will be in anError (use of ref)
    @return aBoolean for the success or fail of the method
*/
- (BOOL)getObjectValue:(id)anObject forString:(CPString)aString errorDescription:(CPString)anError
{
    // TODO Error handling.
    var value = [self dateFromString:aString];
    @deref(anObject) = value;

    return YES;
}

/*! Return a string representation of the given date and format
    @patam aDate
    @param aFormat
    @return a string
*/
- (CPString)_stringFromDate:(CPDate)aDate format:(CPString)aFormat
{

}

/*! Return a date representation of the given string and format
    @patam aDate
    @param aFormat
    @return a string
*/
- (CPDate)_dateFromString:(CPString)aString format:(CPString)aFormat
{

}

/*! Check if we are in the american format or not. Depending on the locale
*/
- (BOOL)_isAmericanFormat
{
    return ;//[[_locale objectForKey:CPLocaleCountryCode] isEqualToString:@"US"];
}

/*! Check if we are in the english format or not. Depending on the locale
*/
- (BOOL)_isEnglishFormat
{
    return ;//[[_locale objectForKey:CPLocaleLanguageCode] isEqualToString:@"en"];
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
