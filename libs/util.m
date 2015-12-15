//
//  Util.m
//
//  Created by QetriX on 25/04/14.
//  Copyright (c) 2015 QetriX. All rights reserved.
//

#import "Util.h"

@implementation Util

- (NSString *)UrlEncode:(NSString *)value
{
    CFStringRef safeString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                            (CFStringRef)value,
                                            NULL,
                                            CFSTR("/%&=?$#+~@<>|\\*,.()[]{}^!"),
                                            kCFStringEncodingUTF8);
    NSString *str = [NSString stringWithFormat:@"%@", safeString];
    str = [str stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    str = [str stringByReplacingOccurrencesOfString:@"%2E" withString:@"."];
    return str;
}


- (NSString*)UrlDecode:(NSString*)value
{
    NSString *result = [(NSString *)value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

@end 
