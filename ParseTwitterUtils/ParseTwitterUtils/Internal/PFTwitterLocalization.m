//
//  PFTwitterLocalization.m
//  
//
//  Created by Ulaş Sancak on 20.11.2022.
//

#import "PFTwitterLocalization.h"

@implementation PFTwitterLocalization

+ (NSString *)localizedStringForKey:key {
    return [[self resourcesBundle] localizedStringForKey:key value:nil table:@"ParseTwitterUtils"];
}

+ (NSBundle *)resourcesBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *classBundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [classBundle URLForResource:@"ParseTwitterUtils" withExtension:@"bundle"];
        
        if (bundleURL) {
            bundle = [NSBundle bundleWithURL:bundleURL];
        } else {
            bundleURL = [classBundle URLForResource:@"ParseObjC_ParseTwitterUtils" withExtension:@"bundle"];
            if (bundleURL) {
                bundle = [NSBundle bundleWithURL:bundleURL];
            }
            else {
                bundle = [NSBundle mainBundle];
            }
        }
    });
    return bundle;
}

@end
