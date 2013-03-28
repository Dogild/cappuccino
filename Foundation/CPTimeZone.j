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

var abbreviationDictionary,
    timeDifferenceFromUTC,
    knownTimeZoneNames,
    defaultTimeZone,
    localTimeZone,
    systemTimeZone,
    timeZoneDataVersion;

@implementation CPTimeZone : CPObject
{
    CPData      _data           @accessors(property=data, readonly);
    CPInteger   _secondsFromGMT @accessors(property=secondFromGMT);
    CPString    _abbreviation   @accessors(property=abbreviation, readonly);
    CPString    _name           @accessors(property=name, readonly);
}

+ (void)initialize
{
    knownTimeZoneNames = [
        @"America/Halifax",
        @"America/Juneau",
        @"America/Juneau",
        @"America/Argentina/Buenos_Aires",
        @"America/Halifax",
        @"Asia/Dhaka",
        @"America/Sao_Paulo",
        @"America/Sao_Paulo",
        @"Europe/London",
        @"Africa/Harare",
        @"America/Chicago",
        @"Europe/Paris",
        @"Europe/Paris",
        @"America/Santiago",
        @"America/Santiago",
        @"America/Bogota",
        @"America/Chicago",
        @"Africa/Addis_Ababa",
        @"America/New_York",
        @"Europe/Istanbul",
        @"Europe/Istanbul",
        @"America/New_York",
        @"GMT",
        @"Asia/Dubai",
        @"Asia/Hong_Kong",
        @"Pacific/Honolulu",
        @"Asia/Bangkok",
        @"Asia/Tehran",
        @"Asia/Calcutta",
        @"Asia/Tokyo",
        @"Asia/Seoul",
        @"America/Denver",
        @"Europe/Moscow",
        @"Europe/Moscow",
        @"America/Denver",
        @"Pacific/Auckland",
        @"Pacific/Auckland",
        @"America/Los_Angeles",
        @"America/Lima",
        @"Asia/Manila",
        @"Asia/Karachi",
        @"America/Los_Angeles",
        @"Asia/Singapore",
        @"UTC",
        @"Africa/Lagos",
        @"Europe/Lisbon",
        @"Europe/Lisbon",
        @"Asia/Jakarta"
     ];

    abbreviationDictionary = @{
        @"ADT" :   @"America/Halifax",
        @"AKDT" :  @"America/Juneau",
        @"AKST" :  @"America/Juneau",
        @"ART" :   @"America/Argentina/Buenos_Aires",
        @"AST" :   @"America/Halifax",
        @"BDT" :   @"Asia/Dhaka",
        @"BRST" :  @"America/Sao_Paulo",
        @"BRT" :   @"America/Sao_Paulo",
        @"BST" :   @"Europe/London",
        @"CAT" :   @"Africa/Harare",
        @"CDT" :   @"America/Chicago",
        @"CEST" :  @"Europe/Paris",
        @"CET" :   @"Europe/Paris",
        @"CLST" :  @"America/Santiago",
        @"CLT" :   @"America/Santiago",
        @"COT" :   @"America/Bogota",
        @"CST" :   @"America/Chicago",
        @"EAT" :   @"Africa/Addis_Ababa",
        @"EDT" :   @"America/New_York",
        @"EEST" :  @"Europe/Istanbul",
        @"EET" :   @"Europe/Istanbul",
        @"EST" :   @"America/New_York",
        @"GMT" :   @"GMT",
        @"GST" :   @"Asia/Dubai",
        @"HKT" :   @"Asia/Hong_Kong",
        @"HST" :   @"Pacific/Honolulu",
        @"ICT" :   @"Asia/Bangkok",
        @"IRST" :  @"Asia/Tehran",
        @"IST" :   @"Asia/Calcutta",
        @"JST" :   @"Asia/Tokyo",
        @"KST" :   @"Asia/Seoul",
        @"MDT" :   @"America/Denver",
        @"MSD" :   @"Europe/Moscow",
        @"MSK" :   @"Europe/Moscow",
        @"MST" :   @"America/Denver",
        @"NZDT" :  @"Pacific/Auckland",
        @"NZST" :  @"Pacific/Auckland",
        @"PDT" :   @"America/Los_Angeles",
        @"PET" :   @"America/Lima",
        @"PHT" :   @"Asia/Manila",
        @"PKT" :   @"Asia/Karachi",
        @"PST" :   @"America/Los_Angeles",
        @"SGT" :   @"Asia/Singapore",
        @"UTC" :   @"UTC",
        @"WAT" :   @"Africa/Lagos",
        @"WEST" :  @"Europe/Lisbon",
        @"WET" :   @"Europe/Lisbon",
        @"WIT" :   @"Asia/Jakarta"
    };

    timeDifferenceFromUTC = @{
        @"ADT" :    -180,
        @"AKDT" :   -480,
        @"AKST" :   -540,
        @"ART" :    -180,
        @"AST" :    -240,
        @"BDT" :    360,
        @"BRST" :   -120,
        @"BRT" :    -180,
        @"BST" :    60,
        @"CAT" :    120,
        @"CDT" :    -300,
        @"CEST" :   120,
        @"CET" :    60,
        @"CLST" :   -180,
        @"CLT" :    -240,
        @"COT" :    -300,
        @"CST" :    -360,
        @"EAT" :    180,
        @"EDT" :    -240,
        @"EEST" :   180,
        @"EET" :    120,
        @"EST" :    -300,
        @"GMT" :    0,
        @"GST" :    240,
        @"HKT" :    480,
        @"HST" :    -600,
        @"ICT" :    420,
        @"IRST" :   210,
        @"IST" :    330,
        @"JST" :    540,
        @"KST" :    540,
        @"MDT" :    -300,
        @"MSD" :    240,
        @"MSK" :    240,
        @"MST" :    -420,
        @"NZDT" :   900,
        @"NZST" :   900,
        @"PDT" :    -420,
        @"PET" :    -300,
        @"PHT" :    480,
        @"PKT" :    300,
        @"PST" :    -480,
        @"SGT" :    480,
        @"UTC" :    0,
        @"WAT" :    -540,
        @"WEST" :   60,
        @"WET" :    0,
        @"WIT" :    540
    };
}

+ (id)timeZoneWithAbbreviation:(CPString)abbreviation
{
    if (![abbreviationDictionary containsKey:abbreviation])
        return nil;

    return [[CPTimeZone alloc] _initWithName:[abbreviationDictionary valueForKey:abbreviation] abbreviation:abbreviation];
}

+ (id)timeZoneWithName:(CPString)tzName
{
    return [[CPTimeZone alloc] initWithName:tzName];
}

+ (id)timeZoneWithName:(CPString)tzName date:(CPData)data
{
    return [[CPTimeZone alloc] initWithName:tzName data:data];
}

+ (id)timeZoneForSecondsFromGMT:(CPInteger)seconds
{
    if (seconds % 3600)
        return nil;

    var minutes = seconds / 60,
        keys = [timeDifferenceFromUTC keyEnumerator],
        key,
        abbreviation = nil;

    while (key = [keys nextObject])
    {
        var value = [timeDifferenceFromUTC valueForKey:key];

        if (value == minutes)
        {
            abbreviation = key;
            break;
        }
    }

    if (!abbreviation)
        return nil;

    return [[self class] timeZoneWithAbbreviation:abbreviation];
}

+ (CPString)timeZoneDataVersion
{
    return timeZoneDataVersion;
}

+ (CPTimeZone)localTimeZone
{
    return localTimeZone;
}

+ (CPTimeZone)defaultTimeZone
{
    return defaultTimeZone;
}

+ (void)setDefaultTimeZone:(CPTimeZone)aTimeZone
{
    defaultTimeZone = aTimeZone;
}

+ (void)resetSystemTimeZone
{

}

+ (CPTimeZone)systemTimeZone
{
    return systemTimeZone;
}

+ (CPDictionary)abbreviationDictionary
{
    return abbreviationDictionary;
}

+ (void)setAbbreviationDictionary:(CPDictionary)dict
{
    abbreviationDictionary = dict;
}

+ (CPArray)knownTimeZoneNames
{
    return knownTimeZoneNames;
}

- (id)_initWithName:(CPString)tzName abbreviation:(CPString)abbreviation
{
    if (!tzName)
        [CPException raise:CPInvalidArgumentException reason:"Invalid value provided for tzName"];

    if (![knownTimeZoneNames containsObject:tzName])
        return nil;

    if (self = [super init])
    {
        _name = tzName;
        _abbreviation = abbreviation;
    }

    return self;
}

- (id)initWithName:(CPString)tzName
{
    if (!tzName)
        [CPException raise:CPInvalidArgumentException reason:"Invalid value provided for tzName"];

    if (![knownTimeZoneNames containsObject:tzName])
        return nil;

    if (self = [super init])
    {
        _name = tzName;

        var keys = [abbreviationDictionary keyEnumerator],
            key;

        while (key = [keys nextObject])
        {
            var value = [abbreviationDictionary valueForKey:key];

            if ([value isEqualToString:_name])
            {
                _abbreviation = key;
                break;
            }
        }
    }

    return self;
}

- (id)initWithName:(CPString)tzName date:(CPData)data
{
    if (self = [super initWithName:tzName])
    {
        _data = data;
    }

    return self;
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
    return [CPString stringWithFormat:@"%s (%s) offset %i", _name, _abbreviation, [timeDifferenceFromUTC valueForKey:_abbreviation]];
}

- (CPString)localizedName:(NSTimeZoneNameStyle)style locale:(CPLocale)locale
{

}

@end
