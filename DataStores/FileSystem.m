//
// FileSystem.m
//
//  Created by QetriX on 25/04/14.
//  Copyright (c) 2015 QetriX. All rights reserved.
//

#import "FileSystem.h"
#import "WikiToHTML.h" // TODO

@interface FileSystem ()

@end

@implementation FileSystem

@synthesize host = _host;
@synthesize db = _db;
@synthesize QUtil = Util;

- (id)Conn: (NSString *)db
{
    Util = [Util alloc];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _host = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
    if (db != nil) _db = [[Util UrlEncode: db] stringByAppendingString:@"/"];
    return self;
}

// Create dir
- (BOOL)AppCreate:(NSString *)name
{
    NSError * error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:[_host stringByAppendingPathComponent:[Util UrlEncode:name]] withIntermediateDirectories:YES attributes:nil error:&error];
    [[NSFileManager defaultManager] createDirectoryAtPath:[_host stringByAppendingPathComponent:[[Util UrlEncode:name] stringByAppendingPathComponent:@"_cache"]] withIntermediateDirectories:YES attributes:nil error:&error];
     return YES;
}


// Delete directory
- (void)AppDelete:(NSString *)name
{
    NSString *filePath = [_host stringByAppendingPathComponent:[Util UrlEncode: name]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:NULL];
    _db = nil;
}

// Read from file
- (NSString *)ParticleRead:(NSString *)name
{
    NSString *filePath = [_host stringByAppendingPathComponent:[_db stringByAppendingPathComponent:[[Util UrlEncode: name] stringByAppendingString:@".txt"]]];
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    return str;
}

// Write to file
- (void)ParticleWrite:(NSString *)name text:(NSString *)text
{
    NSString *filePath = [_host stringByAppendingPathComponent:[_db stringByAppendingPathComponent:[[Util UrlEncode: name] stringByAppendingString:@".txt"]]];
   [text writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

// Delete file
- (void)ParticleDelete:(NSString *)name
{
    NSString *filePath = [_host stringByAppendingPathComponent:[_db stringByAppendingPathComponent:[[Util UrlEncode: name] stringByAppendingString:@".txt"]]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:NULL];
}

// Read cache from file
- (NSString *)ParticleCacheRead:(NSString *)name
{
    NSString *filePath = [_host stringByAppendingPathComponent:[_db stringByAppendingPathComponent:[@"_cache"stringByAppendingPathComponent:[[Util UrlEncode: name] stringByAppendingString:@".html"]]]];
    NSString *str = @"";
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        QetriXWikiToHTML *w2h = [QetriXWikiToHTML alloc];
        str = [w2h parse:[self ParticleRead:name]];
        [self ParticleCacheWrite:name text:str];
        
    } else {
        str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

// Write cache to file
- (void)ParticleCacheWrite:(NSString *)name text:(NSString *)text
{
    NSString *filePath = [_host stringByAppendingPathComponent:[_db stringByAppendingPathComponent:[@"_cache"stringByAppendingPathComponent:[[Util UrlEncode: name] stringByAppendingString:@".html"]]]];
    [text writeToFile:filePath atomically:TRUE encoding:NSUTF8StringEncoding error:NULL];
}

// Delete file
- (void)ParticleCacheDelete:(NSString *)name
{
    NSString *filePath = [_host stringByAppendingPathComponent:[_db stringByAppendingPathComponent:[@"_cache"stringByAppendingPathComponent:[[Util UrlEncode: name] stringByAppendingString:@".html"]]]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:NULL];
}


@end 
