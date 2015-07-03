//
//  ViewController.m
//  加密方式
//
//  Created by zhougj on 15/6/8.
//  Copyright (c) 2015年 iiseeuu. All rights reserved.
//

/**
 *  常用加密方式
 *  1.MD5
 *  2.AES
 *  3.3DES
 *  4.BASE64
 */
#import "ViewController.h"
#import "zlib.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "SecurityUtil.h"

#define AES_KEY  @"ABCDE"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testMD5];
    [self testAES];
    [self testBase64];
}


#pragma mark - MD5
/**
 *  MD5 
 *  MD5只是根据数据生个一个校验码，然后对于数据接受者接受到内容后同样的在通过md5来生成校验码于之前的校验码对比是否一致，从而来判断数据在传送过程中是否被截取篡改过。是不可逆性
 *
 */
- (void)testMD5
{
    
    //1
    NSString *md5Code = [self md5WithString:@"hello world"];
    //5EB63BBBE01EEED093CB22BB8F5ACDC3
    NSString *md5Code1 = [self md5withString:@"hello world"];
}

//NSData
- (NSString *)md5:(NSData *)data
{
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x", result[i]];
    }
    
    return ret;
}

//5eb63bbbe01eeed093cb22bb8f5acdc3
- (NSString *)md5withString:(NSString *)str
{
    const char *original_str = [str UTF8String];//string为摘要内容，转成char

    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);//调通系统md5加密
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < 16; i++)
        [ret appendFormat:@"%02x", result[i]]; //02x 和02X 大小写区分
    return ret ;//校验码
}

//5eb63bbbe01eeed093cb22bb8f5acdc3
- (NSString *)md5WithString:(NSString *)str
{
    NSData *keyData = [str dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5([keyData bytes], (int)[keyData length], result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - AES
- (void)testAES
{
//    <8765fc04 cae50286 3436bfa4 c2a138f3>
    NSData *encData = [SecurityUtil encryptAESData:@"我是谁谁" app_key:AES_KEY];
    NSString *decStr = [SecurityUtil decryptAESData:encData app_key:AES_KEY];

}

- (void)testBase64
{
//    5oiR5piv5aSn56We
    NSString *baseStr = [SecurityUtil encodeBase64String:@"我是大神"];
    NSString *desStr = [SecurityUtil decodeBase64String:baseStr];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
