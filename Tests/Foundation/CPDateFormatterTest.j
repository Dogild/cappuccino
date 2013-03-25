/* CPDatePicker.j
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
//@import <Foundation/CPLocale.j>
@import <Foundation/CPDate.j>

@import <OJUnit/OJTestCase.j>

@global CPDateFormatterNoStyle
@global CPDateFormatterShortStyle
@global CPDateFormatterMediumStyle
@global CPDateFormatterLongStyle
@global CPDateFormatterFullStyle

@implementation CPDateFormatter : OJTestCase
{
    CPDate _date;
    CPDateFormatter _dateFormatter;
}

- (void)setUp
{
    _date = [[CPDate alloc] initWithString:@"2011-10-05 16:34:38 +0000"];
    _dateFormatter = [[CPDateFormatter alloc] init];
    //[_dateFormatter setLocale:[[CPLocale alloc] initWithIdentifier:@"en_US"]];
}

- (void)testLocalizedStringFromDate
{
    var result = [CPDateFormatter localizedStringFromDate:_date dateStyle:CPDateFormatterMediumStyle timeStyle:CPDateFormatterLongStyle];
    [self assert:result equals:@"Oct 5, 2011 9:34:38 AM PDT"];
}

- (void)testInit
{
    var dateFormatter = [[CPDateFormatter alloc] init],
        result = [dateFormatter stringFromDate:_date];

    [self assert:result equals:@""]
}

- (void)testInitWithDateFormat
{
    var dateFormatter = [[CPDateFormatter alloc] initWithDateFormat:@"d EEEE, MMM, Y H:mm:ss a z" allowNaturalLanguage:NO],
        result = [dateFormatter stringFromDate:_date];

    [self assert:result equals:@"5 Wednesday, Oct, 2011 9:34:38 AM PDT"]
}

- (void)testStringFromDateDateNoStyleTimeNoStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterNoStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@""];
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
    [self assert:result equals:@"9:34 AM"];
}

- (void)testStringFromDateDateNoStyleTimeMediumStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterMediumStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"9:34:38 AM"];
}

- (void)testStringFromDateDateNoStyleTimeLongStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterLongStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"9:34:38 AM PDT"];
}

- (void)testStringFromDateDateNoStyleTimeFullStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterNoStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterFullStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"9:34:38 AM Pacific Daylight Time"];
}

- (void)testStringFromDateDateFullStyleTimeFullStyle
{
    [_dateFormatter setDateStyle:CPDateFormatterFullStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterFullStyle];

    var result = [_dateFormatter stringFromDate:_date];
    [self assert:result equals:@"Wednesday, October 5, 2011 9:34:38 AM Pacific Daylight Time"];
}

- (void)testStringForObjectValueWithDate
{
    [_dateFormatter setDateStyle:CPDateFormatterMediumStyle];
    [_dateFormatter setTimeStyle:CPDateFormatterShortStyle];

    var result = [_dateFormatter stringForObjectValue:_date];
    [self assert:result equals:@"Oct 5, 2011 9:34:38 AM PDT"];
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
    [self assert:result equals:@"Oct 5, 2011 9:34:38 AM PDT"];
}

@end
