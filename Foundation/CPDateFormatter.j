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
@import "CPTimeZone.j"
//c@import "CPLocale.j"

@class CPNull

@global CPLocaleLanguageCode
@global CPLocaleCountryCode

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
    CPArray                 _veryShortStandaloneWeekdaySymbols  @accessors(property=veryShortStandaloneWeekdaySymbols);
    CPArray                 _monthSymbols                       @accessors(property=monthSymbols);
    CPArray                 _shortMonthSymbols                  @accessors(property=shortMonthSymbols);
    CPArray                 _veryShortMonthSymbols              @accessors(property=veryShortMonthSymbols);
    CPArray                 _standaloneMonthSymbols             @accessors(property=standaloneMonthSymbols);
    CPArray                 _shortStandaloneMonthSymbols        @accessors(property=shortStandaloneMonthSymbols);
    CPArray                 _veryShortStandaloneMonthSymbols    @accessors(property=veryShortSandaloneMonthSymbols);
    CPArray                 _quarterSymbols                     @accessors(property=quarterSymbols);
    CPArray                 _shortQuarterSymbols                @accessors(property=shortQuarterSymbols);
    CPArray                 _standaloneQuarterSymbols           @accessors(property=standaloneQuarterSymbols);
    CPArray                 _shortStandaloneQuarterSymbols      @accessors(property=shortStandaloneQuarterSymbols);
    CPDate                  _defaultDate                        @accessors(property=defaultDate);
    CPDate                  _twoDigitStartDate                  @accessors(property=twoDigitStartDate);
    CPDateFormatterBehavior _formatterBehavior                  @accessors(property=formatterBehavior);
    CPDateFormatterStyle    _dateStyle                          @accessors(property=dateStyle);
    CPDateFormatterStyle    _timeStyle                          @accessors(property=timeStyle);
    CPLocale                _locale                             @accessors(property=locale);
    CPString                _AMSymbol                           @accessors(property=AMSymbol);
    CPString                _dateFormat                         @accessors(property=dateFormat);
    CPString                _PMSymbol                           @accessors(property=PMSymbol);
    CPTimeZone              _timeZone                           @accessors(property=timeZone);
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
        _formatterBehavior = CPDateFormatterBehavior10_4;

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
    _PMSymbol = [CPString stringWithFormat:@"%s", @"PM"];

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

    _timeZone = [CPTimeZone systemTimeZone];
    _twoDigitStartDate = [[CPDate alloc] initWithString:@"1950-01-01 00:00:00 +0000"];
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

    [aDate _dateWithTimeZone:_timeZone];

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
        return [CPNull null];
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
    var length = [aFormat length],
        currentToken = [CPString new],
        isTextToken = NO,
        result = [CPString new];

    for (var i = 0; i < length; i++)
    {
        var character = [aFormat characterAtIndex:i];

        if (isTextToken)
        {
            if ([character isEqualToString:@"'"])
            {
                isTextToken = NO;
                result += currentToken;
                currentToken = [CPString new];
            }
            else
            {
                currentToken += character;
            }

            continue;
        }

        if ([character isEqualToString:@"'"])
        {
            if (!isTextToken)
            {
                isTextToken = YES;
                result += currentToken;
                currentToken = [CPString new];
            }

            continue;
        }

        if ([character isEqualToString:@","] || [character isEqualToString:@":"] || [character isEqualToString:@"/"] || [character isEqualToString:@"-"] || [character isEqualToString:@" "])
        {
            result += [self _stringFromToken:currentToken date:aDate];
            result += character;
            currentToken = [CPString new];
        }
        else
        {
            if ([currentToken length] && ![[currentToken characterAtIndex:0] isEqualToString:character])
            {
                result += [self _stringFromToken:currentToken date:aDate];
                currentToken = [CPString new];
            }

            currentToken += character;

            if (i == (length - 1))
                result += [self _stringFromToken:currentToken date:aDate];
        }
    }

    return result;
}

/*! Return a date representation of the given string and format
    @patam aDate
    @param aFormat
    @return a string
*/
- (CPDate)_dateFromString:(CPString)aString format:(CPString)aFormat
{
    if (![aString length])
        return nil;

    // var date = [[CPDate alloc] initWithString:@"2000-01-01 00:00:00 +0000"];
    // date.setSeconds([_timeZone secondsFromGMT]);


    var currentToken = [CPString new],
        isTextToken = NO,
        tokens = [CPArray array],
        dateComponents = [CPArray];

    for (var i = 0; i < [aFormat length]; i++)
    {
        var character = [aFormat characterAtIndex:i];

        if (isTextToken)
        {
            if ([character isEqualToString:@"'"])
                currentToken = [CPString new];

            continue;
        }

        if ([character isEqualToString:@"'"])
        {
            if (!isTextToken)
                isTextToken = YES;

            continue;
        }

        if ([character isEqualToString:@","] || [character isEqualToString:@":"] || [character isEqualToString:@"/"] || [character isEqualToString:@"-"] || [character isEqualToString:@" "])
        {
            [tokens addObject:currentToken];
            currentToken = [CPString new];
        }
        else
        {
            if ([currentToken length] && ![[currentToken characterAtIndex:0] isEqualToString:character])
            {
                [tokens addObject:currentToken];
                currentToken = [CPString new];
            }

            currentToken += character;

            if (i == (length - 1))
                [tokens addObject:currentToken];
        }
    }

    isTextToken = NO;
    currentToken = [CPString new];


    for (var i = 0; i < [aString length]; i++)
    {
        var character = [aString characterAtIndex:i];

        if (isTextToken)
        {
            if ([character isEqualToString:@"'"])
                currentToken = [CPString new];

            continue;
        }

        if ([character isEqualToString:@"'"])
        {
            if (!isTextToken)
                isTextToken = YES;

            continue;
        }

        if ([character isEqualToString:@","] || [character isEqualToString:@":"] || [character isEqualToString:@"/"] || [character isEqualToString:@"-"] || [character isEqualToString:@" "])
        {
            [dateComponents addObject:currentToken];
            currentToken = [CPString new];
        }
        else
        {
            if ([currentToken length] && ![[currentToken characterAtIndex:0] isEqualToString:character])
            {
                [dateComponents addObject:currentToken];
                currentToken = [CPString new];
            }

            currentToken += character;

            if (i == (length - 1))
                [dateComponents addObject:currentToken];
        }
    }

    return date;
}

/*! Return a string representation of the given token and date
    @param aToken
    @param aDate
    @return a string
*/
- (CPString)_stringFromToken:(CPString)aToken date:(CPDate)aDate
{
    if (![aToken length])
        return aToken;

    var character = [aToken characterAtIndex:0],
        length = [aToken length],
        abbreviation = [[CPTimeZone new] abbreviationForDate:aDate],
        timeZone = [CPTimeZone timeZoneWithAbbreviation:abbreviation];

    switch (character)
    {
        case @"G":
            // TODO
            CPLog.warn(@"Token not yet implemented " + aToken);
            return [CPString new];

        case @"y":
            return [self _stringValueForValue:aDate.getFullYear() length:length];

        case @"Y":
            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getFullYear()] length];
            return [self _stringValueForValue:aDate.getFullYear() length:MAX(currentLength,length)];

        case @"u":
            // TODO
            CPLog.warn(@"Token not yet implemented " + aToken);
            return [CPString new];

        case @"U":
            // TODO
            CPLog.warn(@"Token not yet implemented " + aToken);
            return [CPString new];

        case @"Q":
            var quarter = 1;

            if (aDate.getMonth() < 6 && aDate.getMonth() > 2)
                quarter = 2;

            if (aDate.getMonth() > 5 && aDate.getMonth() < 9)
                quarter = 3;

            if (aDate.getMonth() >= 9)
                quarter = 4;

            if (length <= 2)
                return [self _stringValueForValue:quarter length:MIN(2,length)];

            if (length == 3)
                return [[self shortQuarterSymbols] objectAtIndex:(quarter - 1)];

            if (length >= 4)
                return [[self quarterSymbols] objectAtIndex:(quarter - 1)];

        case @"q":
            var quarter = 1;

            if (aDate.getMonth() < 6 && aDate.getMonth() > 2)
                quarter = 2;

            if (aDate.getMonth() > 5 && aDate.getMonth() < 9)
                quarter = 3;

            if (aDate.getMonth() >= 9)
                quarter = 4;

            if (length <= 2)
                return [self _stringValueForValue:quarter length:MIN(2,length)];

            if (length == 3)
                return [[self shortStandaloneQuarterSymbols] objectAtIndex:(quarter - 1)];

            if (length >= 4)
                return [[self standaloneQuarterSymbols] objectAtIndex:(quarter - 1)];

        case @"M":
            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getMonth() + 1] length];

            if (length <= 2)
                return [self _stringValueForValue:(aDate.getMonth() + 1) length:MAX(currentLength,length)];

            if (length == 3)
                return [[self shortMonthSymbols] objectAtIndex:aDate.getMonth()];

            if (length == 4)
                return [[self monthSymbols] objectAtIndex:aDate.getMonth()];

            if (length >= 5)
                return [[self veryShortMonthSymbols] objectAtIndex:aDate.getMonth()];

        case @"L":
            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getMonth() + 1] length];

            if (length <= 2)
                return [self _stringValueForValue:(aDate.getMonth() + 1) length:MAX(currentLength,length)];

            if (length == 3)
                return [[self shortStandaloneMonthSymbols] objectAtIndex:aDate.getMonth()];

            if (length == 4)
                return [[self standaloneMonthSymbols] objectAtIndex:aDate.getMonth()];

            if (length >= 5)
                return [[self veryShortSandaloneMonthSymbols] objectAtIndex:aDate.getMonth()];

        case @"I":
            // Deprecated
            CPLog.warn(@"Depreacted - Token not yet implemented " + aToken);
            return [CPString new];

        case @"w":

            var d = new Date(aDate);
            d.setHours(0,0,0);
            d.setDate(d.getDate() + 4 - (d.getDay() || 7));

            var yearStart = new Date(d.getFullYear(), 0, 1),
                weekOfYear = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);

            return [self _stringValueForValue:weekOfYear length:MIN(2, length)];

        case @"W":

            var firstDay = new Date(aDate.getFullYear(), aDate.getMonth(), 1).getDay(),
                weekOfMonth =  Math.ceil((aDate.getDate() + firstDay) / 7);

            return [self _stringValueForValue:weekOfMonth length:1];

        case @"d":
            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getDate()] length];

            return [self _stringValueForValue:aDate.getDate() length:MIN(currentLength, MIN(2, length))];

        case @"D":

            var oneJan = new Date(aDate.getFullYear(),0,1),
                dayOfYear = Math.ceil((aDate - oneJan) / 86400000),
                currentLength = [[CPString stringWithFormat:@"%i", dayOfYear] length];

            return [self _stringValueForValue:dayOfYear length:MAX(currentLength, MIN(3, length))];

        case @"F":
            var dayOfWeek = 1,
                day = aDate.getDate();

            if (day > 7 && day < 15)
                dayOfWeek = 2;

            if (day > 14 && day < 22)
                dayOfWeek = 3;

            if (day > 21 && day < 29)
                dayOfWeek = 4;

            if (day > 28)
                dayOfWeek = 5;

            return [self _stringValueForValue:dayOfWeek length:1];

        case @"g":
            CPLog.warn(@"Token not yet implemented " + aToken);
            return [CPString new];

        case @"E":
            var day = aDate.getDay();

            if (length <= 3)
                return [[self shortWeekdaySymbols] objectAtIndex:day];

            if (length == 4)
                return [[self weekdaySymbols] objectAtIndex:day];

            if (length >= 5)
                return [[self veryShortWeekdaySymbols] objectAtIndex:day];

        case @"e":

            var day = aDate.getDay();

            if (length <= 2)
                [self _stringValueForValue:(day + 1) length:MIN(2, length)];

            if (length == 3)
                return [[self shortWeekdaySymbols] objectAtIndex:day];

            if (length == 4)
                return [[self weekdaySymbols] objectAtIndex:day];

            if (length >= 5)
                return [[self veryShortWeekdaySymbols] objectAtIndex:day];

        case @"c":

            var day = aDate.getDay();

            if (length <= 2)
                [self _stringValueForValue:(day + 1) length:MIN(2, length)];

            if (length == 3)
                return [[self shortStandaloneWeekdaySymbols] objectAtIndex:day];

            if (length == 4)
                return [[self standaloneWeekdaySymbols] objectAtIndex:day];

            if (length >= 5)
                return [[self veryShortStandaloneWeekdaySymbols] objectAtIndex:day];

        case @"a":

            if (aDate.getHours() > 11)
                return [self PMSymbol];
            else
                return [self AMSymbol];

        case @"h":

            var hours = aDate.getHours();

            if (hours == 0)
                hours = 12;
            else if (hours > 12)
                hours -= 12;

            var currentLength = [[CPString stringWithFormat:@"%i", hours] length];

            return [self _stringValueForValue:aDate.getHours() length:MAX(currentLength, MIN(2, length))];

        case @"H":
            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getHours()] length];

            return [self _stringValueForValue:aDate.getHours() length:MAX(currentLength,MIN(2, length))];

        case @"K":

            var hours = aDate.getHours();

            if (hours > 12)
                hours -= 12;

            var currentLength = [[CPString stringWithFormat:@"%i", hours] length];

            return [self _stringValueForValue:aDate.getHours() length:MAX(currentLength,MIN(2, length))];

        case @"k":

            var hours = aDate.getHours();
            hours += 1;

            var currentLength = [[CPString stringWithFormat:@"%i", hours] length];

            return [self _stringValueForValue:aDate.getHours() length:MAX(currentLength,MIN(2, length))];

        case @"j":
            CPLog.warn(@"Token not yet implemented " + aToken);
            return [CPString new];

        case @"m":
            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getMinutes()] length];

            return [self _stringValueForValue:aDate.getMinutes() length:MAX(currentLength,MIN(2, length))];

        case @"s":

            var currentLength = [[CPString stringWithFormat:@"%i", aDate.getMinutes()] length];

            return [self _stringValueForValue:aDate.getSeconds() length:MAX(currentLength,MIN(2, length))];

        case @"S":
            return [self _stringValueForValue:aDate.getMilliseconds() length:length];

        case @"A":
            var date = [aDate copy];
            date.setHours(0);
            date.setMinutes(0);
            date.setSeconds(0);
            date.setMilliseconds(0);

            return [self _stringValueForValue:[aDate timeIntervalSinceDate:date] length:length];

        case @"z":

            if (length <= 3)
                return [timeZone localizedName:CPTimeZoneNameStyleShortDaylightSaving locale:_locale];
            else
                return [timeZone localizedName:CPTimeZoneNameStyleDaylightSaving locale:_locale];

        case @"Z":

            var seconds = [timeZone secondsFromGMTForDate:aDate],
                minutes = seconds / 60,
                hours = minutes / 60,
                result,
                diffMinutes =  (hours - parseInt(hours)) * 100 * 60 / 100;

            if (length <= 3)
            {
                result = diffMinutes.toString();

                while ([result length] < 2)
                    result = @"0" + result;

                result = ABS(parseInt(hours)) + result;

                while ([result length] < 4)
                    result = @"0" + result;

                if (seconds > 0)
                    result = @"+" + result;
                else
                    result = @"-" + result;

                return result;
            }
            else if (length == 4)
            {
                result = diffMinutes.toString();

                while ([result length] < 2)
                    result = @"0" + result;

                result = @":" + result;
                result = ABS(parseInt(hours)) + result;

                if (seconds > 0)
                    result = @"+" + result;
                else
                    result = @"-" + result;

                return @"HPG" + result;
            }
            else
            {
                result = diffMinutes.toString();

                while ([result length] < 2)
                    result = @"0" + result;

                result = @":" + result;
                result = ABS(parseInt(hours)) + result;

                while ([result length] < 5)
                    result = @"0" + result;

                if (seconds > 0)
                    result = @"+" + result;
                else
                    result = @"-" + result;

                return result;
            }

        case @"v":

            if (length <= 3)
                return [timeZone localizedName:CPTimeZoneNameStyleShortGeneric locale:_locale];
            else
                return [timeZone localizedName:CPTimeZoneNameStyleGeneric locale:_locale];

        case @"V":

            if (length <= 3)
                return [timeZone localizedName:CPTimeZoneNameStyleShortStandard locale:_locale];
            else
                return [timeZone localizedName:CPTimeZoneNameStyleStandard locale:_locale];


        default:
            CPLog.warn(@"No pattern found for " + aToken);
            return aToken;
    }

    return [CPString new];

}

- (CPString)_stringValueForValue:(id)aValue length:(int)length
{
    var string = [CPString stringWithFormat:@"%i", aValue];

    if ([string length] == length)
        return string;

    if ([string length] > length)
        return [string substringFromIndex:([string length] - length)];

    while ([string length] < length)
        string = [CPString stringWithFormat:@"0%s", string];

    return string;
}

/*! Check if we are in the american format or not. Depending on the locale
*/
- (BOOL)_isAmericanFormat
{
    return YES; //[[_locale objectForKey:CPLocaleCountryCode] isEqualToString:@"US"];
}

/*! Check if we are in the english format or not. Depending on the locale
*/
- (BOOL)_isEnglishFormat
{
    return YES; //[[_locale objectForKey:CPLocaleLanguageCode] isEqualToString:@"en"];
}

@end

var CPDateFormatterDateStyleKey = @"CPDateFormatterDateStyle",
    CPDateFormatterTimeStyleKey = @"CPDateFormatterTimeStyleKey",
    CPDateFormatterFormatterBehaviorKey = @"CPDateFormatterFormatterBehaviorKey",
    CPDateFormatterDoseRelativeDateFormattingKey = @"CPDateFormatterDoseRelativeDateFormattingKey",
    CPDateFormatterDateFormatKey = @"CPDateFormatterDateFormatKey",
    CPDateFormatterAllowNaturalLanguageKey = @"CPDateFormatterAllowNaturalLanguageKey",
    CPDateFormatterLocaleKey = @"CPDateFormatterLocaleKey";

@implementation CPDateFormatter (CPCoding)

- (id)initWithCoder:(CPCoder)aCoder
{
    self = [super initWithCoder:aCoder];

    if (self)
    {
        _allowNaturalLanguage = [aCoder decodeBoolForKey:CPDateFormatterAllowNaturalLanguageKey];
        _dateFormat = [aCoder decodeStringForKey:CPDateFormatterDateFormatKey];
        _dateStyle = [aCoder decodeIntForKey:CPDateFormatterDateStyleKey];
        _doesRelativeDateFormatting = [aCoder decodeBoolForKey:CPDateFormatterDoseRelativeDateFormattingKey];
        _formatterBehavior = [aCoder decodeIntForKey:CPDateFormatterFormatterBehaviorKey];
        _locale = [aCoder decodeObjectForKey:CPDateFormatterLocaleKey];
        _timeStyle = [aCoder decodeIntForKey:CPDateFormatterTimeStyleKey];
    }

    return self;
}

- (void)encodeWithCoder:(CPCoder)aCoder
{
    [super encodeWithCoder:aCoder];

    [aCoder encodeBool:_allowNaturalLanguage forKey:CPDateFormatterAllowNaturalLanguageKey];
    [aCoder encodeInt:_dateStyle forKey:CPDateFormatterDateStyleKey];
    [aCoder encodeString:_dateFormat forKey:CPDateFormatterDateFormatKey];
    [aCoder encodeBool:_doesRelativeDateFormatting forKey:CPDateFormatterDoseRelativeDateFormattingKey];
    [aCoder encodeInt:_formatterBehavior forKey:CPDateFormatterFormatterBehaviorKey];
    [aCoder encodeInt:_locale forKey:CPDateFormatterLocaleKey];
    [aCoder encodeInt:_timeStyle forKey:CPDateFormatterTimeStyleKey];
}

@end