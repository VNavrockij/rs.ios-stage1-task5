#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    // good luck
    
    NSMutableString *muttInnerString = [[NSMutableString alloc] initWithString:string];
    // NSMutableString *result = [NSMutableString new];
    
    
    NSDictionary *countriesDic = @{
        @"7": @"RU",
        @"77": @"KZ",
        @"373": @"MD",
        @"374": @"AM",
        @"375": @"BY",
        @"380": @"UA",
        @"992": @"TJ",
        @"993": @"TM",
        @"994": @"AZ",
        @"996": @"KG",
        @"998": @"UZ"
    };
    
        
            if ([string length] > 0) {
                NSString *firstCharacter = [string substringToIndex:1];
            
            if ([muttInnerString length] > 12) {
                           muttInnerString = [muttInnerString substringToIndex:12];
                       }
            
            if ([firstCharacter isEqualToString:@"+"]) {
                muttInnerString = [muttInnerString substringFromIndex:1];
            }
            
           
            
            firstCharacter = [muttInnerString substringToIndex:1];
            if (([string length] == 1) && ([countriesDic objectForKey:firstCharacter])) {
                //country detected
                NSString *value = [countriesDic objectForKey:firstCharacter];
                
                return @{KeyPhoneNumber: [self getFormatted:muttInnerString For:value],
                KeyCountry: value};
                
            } else {
                
                if ([muttInnerString length] > 1) {
                    NSString *fistTwoChar = [muttInnerString substringToIndex:2];
                    if ([countriesDic objectForKey:fistTwoChar]) {
                        NSString *value = [countriesDic objectForKey:fistTwoChar];
                        
                        return @{KeyPhoneNumber: [self getFormatted:muttInnerString For:value],
                        KeyCountry: value};
                        
                    } else {
                        
                        if ([muttInnerString length] > 2) {
                            NSString *fistThreeCha = [muttInnerString substringToIndex:3];
                            if ([countriesDic objectForKey:fistThreeCha]) {
                                NSString *value = [countriesDic objectForKey:fistThreeCha];
                                
                                return @{KeyPhoneNumber: [self getFormatted:muttInnerString For:value],
                                KeyCountry: value};
                            }
                        }
                    }
                }
            }
            
        }
        
        return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", muttInnerString],
                 KeyCountry: @""};
    }

    -(NSString *)getFormatted:(NSString *)string For:(NSString *)codify {
        NSDictionary *formatsDic = @{
            @"RU" : @"+x (xxx) xxx-xx-xx",
            @"KZ" : @"+x (xxx) xxx-xx-xx",
            @"MD" : @"+xxx (xx) xxx-xxx",
            @"AM" : @"+xxx (xx) xxx-xxx",
            @"TM" : @"+xxx (xx) xxx-xxx",
            @"BY" : @"+xxx (xx) xxx-xx-xx",
            @"UA" : @"+xxx (xx) xxx-xx-xx",
            @"TJ" : @"+xxx (xx) xxx-xx-xx",
            @"AZ" : @"+xxx (xx) xxx-xx-xx",
            @"KG" : @"+xxx (xx) xxx-xx-xx",
            @"UZ" : @"+xxx (xx) xxx-xx-xx"
        };
        
        if ([formatsDic objectForKey:codify]) {
            
            NSString *boundFormat = [formatsDic objectForKey:codify];
            unichar repl;
            NSString *replacedString = [boundFormat copy];
            
            for (NSInteger i = 0; i < string.length; i++) {
                repl = [string characterAtIndex:i];
                NSRange rangeFound = [replacedString rangeOfString:@"x"];
                
                if (NSNotFound != rangeFound.location) {
                    
                    NSString* replacementChar = [NSString stringWithCharacters:&repl length:1];
                    replacedString = [replacedString stringByReplacingCharactersInRange:rangeFound withString:replacementChar];
                    
                }
                
            }
            
            
           
            NSString *lot = @"x";
            NSString *preLot;

            NSScanner *scanner = [NSScanner scannerWithString:replacedString];
            [scanner scanUpToString:lot intoString:&preLot];
            
            NSCharacterSet *chset = [NSCharacterSet
            characterSetWithCharactersInString:@")(- "];
            return [preLot stringByTrimmingCharactersInSet:chset];
        }
        
        return @"";
    }
@end
