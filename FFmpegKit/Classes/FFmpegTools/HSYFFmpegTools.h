//
//  HSYFFmpegTools.h
//  FFmpegKit
//
//  Created by anmin on 2019/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSYFFmpegTools : NSObject

@property (nonatomic, strong, readonly) UIView *video;
- (instancetype)initWithFilePath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
