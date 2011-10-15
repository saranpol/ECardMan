#import "NSDictionary+Merge.h"

@implementation NSDictionary (Merge)

+ (NSDictionary *) dictionaryByMerging: (NSDictionary *) dict1 with: (NSDictionary *) dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
	
	[dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
		if ([obj isKindOfClass: [NSDictionary class]] && [dict1 objectForKey: key]) {
			NSDictionary * newVal = [[dict1 objectForKey: key] dictionaryByMergingWith: (NSDictionary *) obj];
			[result setObject: newVal forKey: key];
		} else if (![dict1 objectForKey: key]) {
			[result setObject: obj forKey: key];
		} 
	}];
	
    return (NSDictionary *) [[result mutableCopy] autorelease];
}
- (NSDictionary *) dictionaryByMergingWith: (NSDictionary *) dict {
    return [[self class] dictionaryByMerging: self with: dict];
}

@end