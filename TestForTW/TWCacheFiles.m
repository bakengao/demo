//
//  TWCacheFiles.m
//  TestForTW
//
//  Created by Mac on 14-9-18.
//  Copyright (c) 2014年 MyApp. All rights reserved.
//

#import "TWCacheFiles.h"

@interface TWCacheFiles(){
    NSCache *_cache;
    NSFileManager *_manager;
    NSString *cacheDir;
    
}

@end

@implementation TWCacheFiles

static TWCacheFiles *_cacheFiles;
+ (TWCacheFiles *)sharedHelper{
    if (_cacheFiles == nil) {
        _cacheFiles = [[TWCacheFiles alloc] init];
    }
    return _cacheFiles;
}

-(id)init{
    _manager = [NSFileManager defaultManager];
    _cache = [[NSCache alloc] init];
    _cache.name = @"image_cache";
    
    return self;
}

-(void)cacheImage:(UIImage*)image forKey:(NSURL*)url{
    if (image) {
        NSString *fileName = [self getFileName:url];
        [_cache setObject:image forKey:fileName];
    }
}

-(UIImage*)getImageFromCache:(NSURL*)url{
    NSString *fileName = [self getFileName:url];
    return [_cache objectForKey:fileName];
}

-(void)writeDataToFileByURL:(NSURL *)url imageData:(NSData *)imageData{
    
    NSString *filePath = [self getFilePath];
    NSString *filename = [self getFileName:url];
    NSString *tmpFileName = [filePath stringByAppendingPathComponent:filename];
    [imageData writeToFile:tmpFileName atomically:YES];
}

-(UIImage *)getImageFromDocuments:(NSURL *)url
{
    UIImage *image ;
    NSString *filename = [self getFileName:url];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = [self getFilePath];
    NSLog(@"[filePath stringByAppendingPathComponent:filename] %@",[filePath stringByAppendingPathComponent:filename]) ;
    if ([manager fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:[filePath stringByAppendingPathComponent:filename]];
        return image;
    }
    
    return image;
}


-(NSString *)getFilePath{
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *doc = [documents[0] stringByAppendingPathComponent:@"images"];
    
    if (![_manager fileExistsAtPath:doc]) {
        [_manager createDirectoryAtPath:doc withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return doc;
}


-(NSString *)getFileName:(NSURL *)fileName{
    NSString *imageUrl = [fileName absoluteString];
    NSRange range = [imageUrl rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *filename = [imageUrl substringFromIndex:range.location+1];
    return filename;
}
@end
