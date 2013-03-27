/* CPTimeZone.j
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

@import "CPObject.j"
@import "CPString.j"
@import "CPDate.j"
//@import "CPLocale.j"

CPTimeZoneNameStyleStandard = 0;
CPTimeZoneNameStyleShortStandard = 1;
CPTimeZoneNameStyleDaylightSaving = 2;
CPTimeZoneNameStyleShortDaylightSaving = 3;
CPTimeZoneNameStyleGeneric = 4;
CPTimeZoneNameStyleShortGeneric = 5;

CPSystemTimeZoneDidChangeNotification = @"CPSystemTimeZoneDidChangeNotification";

@implementation CPTimeZone : CPObject
{
    CPData      _data           @accessors(property=data, readonly);
    CPInteger   _secondsFromGMT @accessors(property=secondFromGMT);
    CPString    _abbreviation   @accessors(property=abbreviation, readonly);
    CPString    _name           @accessors(property=name, readonly);
}

+ (id)timeZoneWithAbbreviation:(CPString)abbreviation
{

}

+ (id)timeZoneWithName:(CPString)tzName
{

}

+ (id)timeZoneWithName:(CPString)tzName date:(CPData)data
{

}

+ (id)timeZoneForSecondsFromGMT:(CPInteger)seconds
{

}

+ (CPString)timeZoneDataVersion
{

}

+ (CPTimeZone)localTimeZone
{

}

+ (CPTimeZone)defaultTimeZone
{

}

+ (void)setDefaultTimeZone:(CPTimeZone)aTimeZone
{

}

+ (void)resetSystemTimeZone
{

}

+ (CPTimeZone)systemTimeZone
{

}

+ (CPDictionary)abbreviationDictionary
{

}

+ (void)setAbbreviationDictionary:(CPDictionary)dict
{

}

+ (CPArray)knownTimeZoneNames
{

}

- (id)initWithName:(CPString)name
{

}

- (id)initWithName:(CPString)name date:(CPData)data
{

}

- (CPString)abbreviationForDate:(CPDate)date
{

}

- (CPInteger)secondsFromGMTForDate:(CPDate)date
{

}

- (BOOL)isEqualToTimeZone:(CPTimeZone)aTimeZone
{

}

- (CPString)description
{

}

- (CPString)localizedName:(NSTimeZoneNameStyle)style locale:(CPLocale)locale
{

}

- (BOOL)isDaylightSavingTime
{

}

- (CPTimeInterval)daylightSavingTimeOffset
{

}

- (BOOL)isDaylightSavingTimeForDate:(CPDate)date
{

}

- (CPTimeInterval)daylightSavingTimeOffsetForDate:(CPDate)date
{

}

- (CPTimeInterval)nextDaylightSavingTimeTransition
{

}

- (CPTimeInterval)nextDaylightSavingTimeTransitionAfterDate::(CPDate)date
{

}

@end
