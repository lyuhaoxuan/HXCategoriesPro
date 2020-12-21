//
//  NSString+HXEncrypt.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSString+HXEncrypt.h"
#import "NSData+HXEncrypt.h"
#import "NSData+HXBase64.h"

@implementation NSString (HXEncrypt)

-(NSString*)hx_encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] hx_encryptedWithAESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted hx_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)hx_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData hx_dataWithBase64EncodedString:self] hx_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)zd_decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData hx_dataWithBase64EncodedString:self] zd_decryptedWithAESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)hx_encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] hx_encryptedWithDESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted hx_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)hx_decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData hx_dataWithBase64EncodedString:self] hx_decryptedWithDESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}

- (NSString*)hx_encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] hx_encryptedWith3DESUsingKey:key andIV:iv];
    NSString *encryptedString = [encrypted hx_base64EncodedString];
    
    return encryptedString;
}

- (NSString*)hx_decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv {
    NSData *decrypted = [[NSData hx_dataWithBase64EncodedString:self] hx_decryptedWith3DESUsingKey:key andIV:iv];
    NSString *decryptedString = [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
    
    return decryptedString;
}
@end
