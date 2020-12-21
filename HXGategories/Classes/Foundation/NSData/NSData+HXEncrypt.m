//
//  NSData+HXEncrypt.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSData+HXEncrypt.h"
#import "NSData+HXBase64.h"

@implementation NSData (HXEncrypt)
static void hx_FixKeyLengths(CCAlgorithm algorithm, NSMutableData * keyData, NSMutableData * ivData)
{
    NSUInteger keyLength = [keyData length];
    switch ( algorithm )
    {
        case kCCAlgorithmAES128:
        {
            if (keyLength <= 16)
            {
                [keyData setLength:16];
            }
            else if (keyLength>16 && keyLength <= 24)
            {
                [keyData setLength:24];
            }
            else
            {
                [keyData setLength:32];
            }
            
            break;
        }
            
        case kCCAlgorithmDES:
        {
            [keyData setLength:8];
            break;
        }
            
        case kCCAlgorithm3DES:
        {
            [keyData setLength:24];
            break;
        }
            
        case kCCAlgorithmCAST:
        {
            if (keyLength <5)
            {
                [keyData setLength:5];
            }
            else if ( keyLength > 16)
            {
                [keyData setLength:16];
            }
            
            break;
        }
            
        case kCCAlgorithmRC4:
        {
            if ( keyLength > 512)
                [keyData setLength:512];
            break;
        }
            
        default:
            break;
    }
    
    [ivData setLength:[keyData length]];
}

/**
 AES加密
 
 @param key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 @param iv IV
 @return 加密后数据
 */
- (NSData*)hx_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self hx_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCEncrypt key:key iv:iv];
}

/**
 AES解密
 
 @param key 长度一般为16 （AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 @param iv IV
 @return 解密后数据
 */
- (NSData*)hx_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self hx_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCDecrypt key:key iv:iv];
}

- (NSData*)zd_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSInteger k = key.length % 8;
    for (int i = 0; i < 8 - k; i++) {
        key = [key stringByAppendingString:@"="];
    }
    
    NSData *keyData = [NSData hx_dataWithBase64EncodedString:key];
    return [self hx_CCCryptData:self algorithm:kCCAlgorithmAES128 operation:kCCDecrypt keyData:keyData iv:iv];
}

/**
 3DES加密
 
 @param key 长度一般为24
 @param iv IV
 @return 加密后数据
 */
- (NSData*)hx_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self hx_CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCEncrypt key:key iv:iv];
}

/**
 3DES解密
 
 @param key 长度一般为24
 @param iv IV
 @return 解密后数据
 */
- (NSData*)hx_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self hx_CCCryptData:self algorithm:kCCAlgorithm3DES operation:kCCDecrypt key:key iv:iv];
}

/**
 DES加密
 
 @param key 长度一般为8
 @param iv IV
 @return 加密后数据
 */
- (NSData *)hx_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self hx_CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCEncrypt key:key iv:iv];
}

/**
 DES解密
 
 @param key 长度一般为8
 @param iv IV
 @return 解密后数据
 */
- (NSData *)hx_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    return [self hx_CCCryptData:self algorithm:kCCAlgorithmDES operation:kCCDecrypt key:key iv:iv];
}

- (NSData *)hx_CCCryptData:(NSData *)data
                 algorithm:(CCAlgorithm)algorithm
                 operation:(CCOperation)operation
                       key:(NSString *)key
                        iv:(NSData *)iv {
    
    NSMutableData *keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    return [self hx_CCCryptData:data algorithm:algorithm operation:operation keyData:keyData iv:iv];
}

- (NSData *)hx_CCCryptData:(NSData *)data
                 algorithm:(CCAlgorithm)algorithm
                 operation:(CCOperation)operation
                   keyData:(NSData *)key
                        iv:(NSData *)iv {
    
    NSMutableData *keyData = [key mutableCopy];
    NSMutableData *ivData = [iv mutableCopy];
    
    size_t dataMoved;
    
    int size = 0;
    if (algorithm == kCCAlgorithmAES128 ||algorithm == kCCAlgorithmAES) {
        size = kCCBlockSizeAES128;
    }else if (algorithm == kCCAlgorithmDES) {
        size = kCCBlockSizeDES;
    }else if (algorithm == kCCAlgorithm3DES) {
        size = kCCBlockSize3DES;
    }if (algorithm == kCCAlgorithmCAST) {
        size = kCCBlockSizeCAST;
    }
    
    NSMutableData *decryptedData = [NSMutableData dataWithLength:data.length + size];
    
    int option = kCCOptionPKCS7Padding | kCCOptionECBMode;
    if (iv) {
        option = kCCOptionPKCS7Padding;
    }
    hx_FixKeyLengths(algorithm, keyData,ivData);
    CCCryptorStatus result = CCCrypt(operation,                    // kCCEncrypt or kCCDecrypt
                                     algorithm,
                                     option,                        // Padding option for CBC Mode
                                     keyData.bytes,
                                     keyData.length,
                                     iv.bytes,
                                     data.bytes,
                                     data.length,
                                     decryptedData.mutableBytes,    // encrypted data out
                                     decryptedData.length,
                                     &dataMoved);                   // total data moved
    
    if (result == kCCSuccess) {
        decryptedData.length = dataMoved;
        return decryptedData;
    }
    return nil;
}

@end
