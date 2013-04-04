/* CPDateFormatterTest.j
* Foundation
*
* Created by Alexandre Wilhelm
* Copyright 2012 <alexandre.wilhelmfr@gmail.com>
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

@import <Foundation/CPDateFormatter.j>
@import <Foundation/CPLocale.j>
@import <Foundation/CPDate.j>

@import <OJUnit/OJTestCase.j>

@global CPDateFormatterNoStyle
@global CPDateFormatterShortStyle
@global CPDateFormatterMediumStyle
@global CPDateFormatterLongStyle
@global CPDateFormatterFullStyle

@implementation CPDateFormatterTest : OJTestCase
{
    CPDate _date;
    CPDateFormatter _dateFormatter;
}

- (void)setUp
{
    _date = [[CPDate alloc] initWithString:@"2011-10-05 16:34:38 -0900"];
    _dateFormatter = [[CPDateFormatter alloc] init];
    [_dateFormatter setDateStyle:CPDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];
    [_dateFormatter setLocale:[[CPLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [_dateFormatter setTimeZone:[CPTimeZone timeZoneWithAbbreviation:@"PDT"]];
}

- (void)testLocalizedStringFromDate
{
    var result = [CPDateFormatter localizedStringFromDate:_date dateStyle:CPDateFormatterMediumStyle timeStyle:CPDateFormatterNoStyle];
    [self assert:result equals:@"5 Oct 2011"];
}

- (void)testInit
{
    var dateFormatter = [[CPDateFormatter alloc] init],
        result = [dateFormatter stringFromDate:_date];

    [self assert:result.length equals:@"".length];
}

- (void)testInitWithDateFormat
{
    var dateFormatter = [[CPDateFormatter alloc] initWithDateFormat:@"d EEEE, MMM, Y H:mm:ss a z" allowNaturalLanguage:NO];
    [dateFormatter setLocale:[[CPLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setTimeZone:[CPTimeZone timeZoneWithAbbreviation:@"PDT"]];

    var result = [dateFormatter stringFromDate:_date];

    [self assert:result equals:@"5 Wednesday, Oct, 2011 18:34:38 PM PDT"]
}

- (void)testStringFromDateDateNoStyleTimeNoStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result.length equals:@"".length];
}

- (void)testStringFromDateDateShortStyleTimeNoStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterShortStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"10/5/11"];
}

- (void)testStringFromDateDateMediumStyleTimeNoStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"Oct 5, 2011"];
}

- (void)testStringFromDateDateLongStyleTimeNoStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterLongStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"October 5, 2011"];
}

- (void)testStringFromDateDateFullStyleTimeNoStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterFullStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"Wednesday, October 5, 2011"];
}

- (void)testStringFromDateDateNoStyleTimeShortStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"6:34 PM"];
}

- (void)testStringFromDateDateNoStyleTimeMediumStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterMediumStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"6:34:38 PM"];
}

- (void)testStringFromDateDateNoStyleTimeLongStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterLongStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"6:34:38 PM PDT"];
}

- (void)testStringFromDateDateNoStyleTimeFullStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterFullStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"6:34:38 PM Pacific Daylight Time"];
}

- (void)testStringFromDateDateFullStyleTimeFullStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterFullStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterFullStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"Wednesday, October 5, 2011 6:34:38 PM Pacific Daylight Time"];
}

- (void)testStringForObjectValueWithDate
{
    [_dateFormatter setDateStyle:CPDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];

    var result = [_dateFormatter stringForObjectValue:_date];
    [self assert:result equals:@"Oct 5, 2011 6:34 PM"];
}

- (void)testStringForObjectValueWithString
{
    [_dateFormatter setDateStyle:CPDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];

    var result = [_dateFormatter stringForObjectValue:@"Test String"];
    [self assert:result equals:[CPNull null]];
}

- (void)testEditingStringForObjectValueWithDate
{
    [_dateFormatter setDateStyle:CPDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];

    var result = [_dateFormatter editingStringForObjectValue:_date];
    [self assert:result equals:@"Oct 5, 2011 6:34 PM"];
}

- (void)testDoesRelativeDateFormatting
{
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];
    [_dateFormatter setDoesRelativeDateFormatting:YES];

    var date = [CPDate date];
    date.setDate(date.getDate() + 1);
    date.setHours(11);
    date.setMinutes(10);

    var result = [_dateFormatter editingStringForObjectValue:date];
    [self assert:result equals:@"tomorrow"];

    date.setDate(date.getDate() - 2);

    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];
    result = [_dateFormatter editingStringForObjectValue:date];
    [self assert:result equals:@"yesterday 11:10 AM"];
}

- (void)testTokensYears
{
    [_dateFormatter setDateFormat:@"y yy yyy yyyy Y YY YYY YYYY"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"2011 11 2011 2011 2011 11 2011 2011"];
}

- (void)testTokensQuarters
{
    [_dateFormatter setDateFormat:@"Q QQ QQQ QQQQ q qq qqq qqqq"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"4 04 Q4 4th quarter 4 04 Q4 4th quarter"];
}

- (void)testTokensMonths
{
    [_dateFormatter setDateFormat:@"M MM MMM MMMM MMMMM L LL LLL LLLL LLLLL"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"10 10 Oct October O 10 10 Oct October O"];
}

- (void)testTokensWeeks
{
    [_dateFormatter setDateFormat:@"w ww W"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"41 41 2"];
}

- (void)testTokensDays
{
    [_dateFormatter setDateFormat:@"d dd D DD DDD F"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"5 05 278 278 278 1"];
}

- (void)testTokensWeekDays
{
    [_dateFormatter setDateFormat:@"E EE EEE EEEE EEEEE e ee eee eeee eeeee c cc ccc cccc ccccc"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"Wed Wed Wed Wednesday W 4 04 Wed Wednesday W 4 4 Wed Wednesday W"];
}

- (void)testTokensPeriods
{
    [_dateFormatter setDateFormat:@"a"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"PM"];
}

- (void)testTokensSeconds
{
    [_dateFormatter setDateFormat:@"s ss S SS SSS SSSS A AA AAA AAAA"];
    _date.setSeconds(8);

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"8 08 0 00 000 0000 66848000 66848000 66848000 66848000"];
}

- (void)testTokensMinutes
{
    [_dateFormatter setDateFormat:@"m mm"];
    _date.setMinutes(5);

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"5 05"];
}

- (void)testTokensHours
{
    [_dateFormatter setDateFormat:@"h hh HH k kk K KK"];
    _date.setHours(22);

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"12 12 00 24 24 0 00"];


    [_dateFormatter setDateFormat:@"h hh HH k kk K KK"];
    _date.setHours(6);

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"8 08 08 8 08 8 08"];


    [_dateFormatter setDateFormat:@"h hh HH k kk K KK"];
    _date.setHours(16);

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"6 06 18 18 18 6 06"];
}

- (void)testTokensZones
{
    [_dateFormatter setDateFormat:@"z zz zzz zzzz Z ZZ ZZZ ZZZZ ZZZZ v vvvv V"];

    var result = [_dateFormatter stringFromDate:_date];

    [self assert:result equals:@"PDT PDT PDT Pacific Daylight Time -0700 -0700 -0700 GMT-07:00 GMT-07:00 PT Pacific Time PDT"];
}

@end
