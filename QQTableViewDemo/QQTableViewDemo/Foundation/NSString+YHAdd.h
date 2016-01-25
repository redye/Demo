//
//  NSString+YHAdd.h
//  QQTableViewDemo
//
//  Created by hu on 16/1/18.
//  Copyright © 2016年 redye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YHAdd)

#pragma mark - Hash
- (NSString *)md2String;

- (NSString *)md4String;

- (NSString *)md5String;

- (NSString *)sha1String;

- (NSString *)sha224String;

- (NSString *)sha256String;

- (NSString *)sha384String;

- (NSString *)sha512String;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;

- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

- (NSString *)crc32String;

#pragma mark - Encode and decode
- (NSString *)base64EncodedString;

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

- (NSString *)stringByURLEncode;

- (NSString *)stringByURLDecode;

- (NSString *)stringByEscapingHTML;

#pragma mark - Drawing
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

- (CGSize)sizeWithFont:(UIFont *)font;

- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;

#pragma mark - Util

- (NSString *)stringByTrim;

+ (NSString *)stringWithUUID;

@end
