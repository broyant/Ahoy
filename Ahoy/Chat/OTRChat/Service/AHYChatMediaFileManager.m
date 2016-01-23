//
//  ChatMediaFileManager.m
//  TestLeanCloud
//
//  Created by broyant on 15/10/19.
//  Copyright © 2015年 Ahoy. All rights reserved.
//

#import "AHYChatMediaFileManager.h"

#import "OTRMediaItem.h"
#import "OTRMessage.h"
#import "AHYDatabaseManager.h"
#import "OTRConstants.h"

//waiting being replaced
#define userID @"userID"

NSString *const kChatRootDirectory = @"Chat";
NSString *const kChatMediaDirectory = @"Media";

@interface AHYChatMediaFileManager ()

@property (nonatomic) dispatch_queue_t concurrentQueue;

@end

@implementation AHYChatMediaFileManager

- (instancetype)init {
    if (self = [super init]) {
        self.concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
    }
    return self;
}

- (void)setData:(NSData *)data forItem:(OTRMediaItem *)mediaItem buddyUniqueId:(NSString *)buddyUniqueId completion:(void (^)(NSInteger bytesWritten, NSString *filePath,NSError *error))completion completionQueue:(dispatch_queue_t)completionQueue {
    
    if (!completionQueue) {
        completionQueue = dispatch_get_main_queue();
    }
    
    
    dispatch_async(self.concurrentQueue, ^{
        NSString *path = [[self class] pathForMediaItem:mediaItem buddyUniqueId:buddyUniqueId];
        if (![path length]) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:150 userInfo:@{NSLocalizedDescriptionKey:@"Unable to create file path"}];
            dispatch_async(completionQueue, ^{
                completion(-1,nil,error);
            });
            return;
        }
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) NSLog(@"ERROR:%@", error);
        }
        NSString *filePath = [path stringByAppendingPathComponent:mediaItem.filename];
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:NULL];//[self.ioCipher fileExistsAtPath:path isDirectory:NULL];
        
        if (fileExists) {
            
            //            [self.ioCipher removeItemAtPath:path error:&error];
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            if (error) {
                NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:151 userInfo:@{NSLocalizedDescriptionKey:@"Unable to remove existing file"}];
                dispatch_async(completionQueue, ^{
                    completion(-1,nil,error);
                });
                return;
            }
        }
        
        //        NSError *error = nil;
        //        BOOL created = [self.ioCipher createFileAtPath:path error:&error];
        BOOL created = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
        if (!created) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:152 userInfo:@{NSLocalizedDescriptionKey:@"Unable to create file"}];
            dispatch_async(completionQueue, ^{
                completion(-1,nil,error);
            });
            return;
        }
        
        //        __block NSInteger written = [self.ioCipher writeDataToFileAtPath:path data:data offset:0 error:&error];
        
        __block NSInteger written = [data length];
        dispatch_async(completionQueue, ^{
            completion(written, filePath,error);
        });
        
    });
    
}
- (void)dataForItem:(OTRMediaItem *)mediaItem buddyUniqueId:(NSString *)buddyUniqueId completion:(void (^)(NSData *, NSError *))completion completionQueue:(dispatch_queue_t)completionQueue {
    if (!completionQueue) {
        completionQueue = dispatch_get_main_queue();
    }
    
    dispatch_async(self.concurrentQueue, ^{
        NSString *path = [[self class] pathForMediaItem:mediaItem buddyUniqueId:buddyUniqueId];
        if (!path) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:150 userInfo:@{NSLocalizedDescriptionKey:@"Unable to create file path"}];
            dispatch_async(completionQueue, ^{
                completion(nil,error);
            });
            return;
        }
        NSString *filePath = [path stringByAppendingPathComponent:mediaItem.filename];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil];
        //[self.ioCipher fileExistsAtPath:filePath isDirectory:nil];
        
        if (fileExists) {
            
            __block NSError *error;
            
            NSData *fileData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
            
            //            NSDictionary *fileAttributes = [self.ioCipher fileAttributesAtPath:filePath error:&error];
            if (error) {
                dispatch_async(completionQueue, ^{
                    completion(nil,error);
                });
                return;
            }
            
            //            NSNumber *length = fileAttributes[NSFileSize];
            
            //            NSData *data = [self.ioCipher readDataFromFileAtPath:filePath length:[length integerValue] offset:0 error:&error];
            
            dispatch_async(completionQueue, ^{
                completion(fileData,error);
            });
        }
    });
}
- (void)dataForItemID:(NSString *)itemID buddyUniqueId:(NSString *)buddyUniqueId completion:(void (^)(NSData *, NSError *))completion completionQueue:(dispatch_queue_t)completionQueue {
    if (!completionQueue) {
        completionQueue = dispatch_get_main_queue();
    }
    
    dispatch_async(self.concurrentQueue, ^{
        NSString *path = [[self class] pathForMediaItemUniqueId:itemID buddyUniqueId:buddyUniqueId];
        if (!path) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:150 userInfo:@{NSLocalizedDescriptionKey:@"Unable to create file path"}];
            dispatch_async(completionQueue, ^{
                completion(nil,error);
            });
            return;
        }
        NSString *fileName = [itemID stringByAppendingPathExtension:@"jpg"];
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil];
        //[self.ioCipher fileExistsAtPath:filePath isDirectory:nil];
        
        if (fileExists) {
            
            __block NSError *error;
            
            NSData *fileData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
            
            //            NSDictionary *fileAttributes = [self.ioCipher fileAttributesAtPath:filePath error:&error];
            if (error) {
                dispatch_async(completionQueue, ^{
                    completion(nil,error);
                });
                return;
            }
            
            dispatch_async(completionQueue, ^{
                completion(fileData,error);
            });
        }
    });
}

-(void)deleteMediaFileOfBuddy:(NSString *)buddyUniqueId completion:(void (^)(BOOL successed, NSError *error))completion completionQueue:(dispatch_queue_t)completionQueue {
    dispatch_async(self.concurrentQueue, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString pathWithComponents:@[@"/",documentsDirectory,kChatRootDirectory,userID,kChatMediaDirectory,buddyUniqueId]];
        
        if (!filePath) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:150 userInfo:@{NSLocalizedDescriptionKey:@"file path is not exist!"}];
            dispatch_async(completionQueue, ^{
                completion(NO,error);
            });
            return;
        }
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (fileExists) {
            __block NSError *error;
            
            //            NSString *fileName = nil;
            //            BOOL remove = NO;
            //            NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
            //            while (fileName = [dirEnum nextObject]) {
            //                remove = [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName] error:&error];
            //
            //            }
            //            if (remove) {
            BOOL remove = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            //            }
            if (error) {
                dispatch_async(completionQueue, ^{
                    completion(remove,error);
                });
                return;
            }
            dispatch_async(completionQueue, ^{
                completion(remove,error);
            });
        }
    });
    
}

-(void)deleteAllMediaFileOfAccount:(NSString *)accountId completion:(void (^)(BOOL successed, NSError *error))completion completionQueue:(dispatch_queue_t)completionQueue {
    dispatch_async(self.concurrentQueue, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [NSString pathWithComponents:@[@"/",documentsDirectory,kChatRootDirectory,accountId,kChatMediaDirectory]];
        
        if (!filePath) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:150 userInfo:@{NSLocalizedDescriptionKey:@"file path is not exist!"}];
            dispatch_async(completionQueue, ^{
                completion(NO,error);
            });
            return;
        }
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (fileExists) {
            __block NSError *error;
            
            BOOL remove = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            
            if (error) {
                dispatch_async(completionQueue, ^{
                    completion(remove,error);
                });
                return;
            }
            dispatch_async(completionQueue, ^{
                completion(remove,error);
            });
        }
    });
    
}

-(void)deleteMessage:(NSString *)mediaUniqueId buddyUniqueId:(NSString *)buddyUniqueId completion:(void (^)(BOOL successed, NSError *error))completion
     completionQueue:(dispatch_queue_t)completionQueue {
    dispatch_async(self.concurrentQueue, ^{
        
        NSString *filePath = [[self class] pathForMediaItemUniqueId:mediaUniqueId buddyUniqueId:buddyUniqueId];
        if (!filePath) {
            NSError *error = [NSError errorWithDomain:kOTRErrorDomain code:150 userInfo:@{NSLocalizedDescriptionKey:@"file path is not exist!"}];
            dispatch_async(completionQueue, ^{
                completion(NO,error);
            });
            return;
        }
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        
        if (fileExists) {
            __block NSError *error;
            
            //            NSString *fileName = nil;
            //            BOOL remove = NO;
            //            NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:filePath];
            //                while (fileName = [dirEnum nextObject]) {
            //                    remove = [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",filePath,fileName] error:&error];
            //
            //                }
            //            if (remove) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            //            }
            if (error) {
                dispatch_async(completionQueue, ^{
                    completion(NO,error);
                });
                return;
            }
            dispatch_async(completionQueue, ^{
                completion(YES,error);
            });
        }
    });
}


- (void)emoticonName:(NSString *)imageName subName:(NSString *)subName completion:(void (^)(UIImage *image))completion {
    NSString *imagePath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Images/%@",subName]]  stringByAppendingPathComponent:imageName];
    UIImage *emoticon = [UIImage imageWithContentsOfFile:imagePath];
    
    completion(emoticon);
    
}

#pragma - mark Class Methods

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (NSString *)pathForMediaItem:(OTRMediaItem *)mediaItem buddyUniqueId:(NSString *)buddyUniqueId {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"/%@/%@/%@",kChatRootDirectory,userID,kChatMediaDirectory];
    NSString *mediaDirectory =  [documentsDirectory stringByAppendingString:path];
    
    if ([buddyUniqueId length] && [mediaItem.uniqueId length] && [mediaItem.filename length]) {
        return [NSString pathWithComponents:@[@"/",mediaDirectory,buddyUniqueId,mediaItem.uniqueId]];
    }
    return nil;
}

+ (NSString *)pathForMediaItemUniqueId:(NSString *)uniqueId buddyUniqueId:(NSString *)buddyUniqueId {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"/%@/%@/%@",kChatRootDirectory,userID,kChatMediaDirectory];
    NSString *mediaDirectory =  [documentsDirectory stringByAppendingString:path];
    
    if ([buddyUniqueId length] && [uniqueId length]) {
        return [NSString pathWithComponents:@[@"/",mediaDirectory,buddyUniqueId,uniqueId]];
    }
    return nil;
}


@end
