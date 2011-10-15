
#import "TimeUtil.h"


@implementation TimeUtil


+(NSDate*)parseServerDate:(NSString *)serverDateString
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setCalendar:calendar];

    NSDate* result = [formatter dateFromString:serverDateString];
    [formatter release];
    [calendar release];
    
    return result;
}

+(NSString*)formatDateForDisplay:(NSString*)serverDateString {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDate* now = [NSDate date];
    NSDate* date = [self parseServerDate:serverDateString];
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    
    NSString *result;
    if (interval > 432000.0) { // 5 days
        int nowYear = [[calendar components:NSYearCalendarUnit fromDate:now] year];
        int dateYear = [[calendar components:NSYearCalendarUnit fromDate:date] year];
        
        if (nowYear == dateYear) {
            [formatter setDateFormat: @"MMM d HH:mm"];
        } else {
            [formatter setDateFormat: @"MMM d yyyy HH:mm"];
        }
        
        result = [formatter stringFromDate:date];
    } else if (interval > 86400.0) { // 1 day
        int days = (int)round(interval / 86400.0);
        result = [NSString stringWithFormat:@"%d days ago", days];
    } else if (interval > 3600.0) { // 1 hour
        int hours = (int)round(interval / 3600.0);
        result = [NSString stringWithFormat:@"%d hours ago", hours];
    } else if (interval > 60.0) { // 1 minute
        int mins = (int)round(interval / 60.0);
        result = [NSString stringWithFormat:@"%d minutes ago", mins];
    } else {
        int seconds = (int)round(interval);
        result = [NSString stringWithFormat:@"%d seconds ago.", seconds];
    }
    
    [formatter release];
    return result;
}


@end
