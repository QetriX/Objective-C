//
//  FileSystem.h
//
//  Created by QetriX on 25/04/14.
//  Copyright (c) 2015 QetriX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

@interface FileSystem : NSObject

@property (strong, nonatomic) NSString *host;
@property (strong, nonatomic) NSString *db;

@property (strong, nonatomic) Util *QUtil;

- (id)Conn: (NSString *)db;

- (BOOL)AppCreate:(NSString *)name;
- (void)AppDelete:(NSString *)name;

- (NSString *)ParticleRead:(NSString *)name;
- (void)ParticleWrite:(NSString *)name text:(NSString *)text;
- (void)ParticleDelete:(NSString *)name;

- (NSString *)ParticleCacheRead:(NSString *)name;
- (void)ParticleCacheWrite:(NSString *)name text:(NSString *)text;
- (void)ParticleCacheDelete:(NSString *)name;

@end
