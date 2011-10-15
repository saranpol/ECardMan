
#import <Foundation/Foundation.h>


@interface TimeUtil : NSObject {
}

+(NSDate*)parseServerDate:(NSString*)serverDateString;
+(NSString*)formatDateForDisplay:(NSString*)serverDateString;

@end
