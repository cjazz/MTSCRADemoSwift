

#import <Foundation/Foundation.h>
#import "HexUtil.h"


@interface MTTLV : NSObject
@property (nonatomic, strong) NSString* tag;
@property (nonatomic) int length;
@property (nonatomic, strong) NSString* value;

@end

@interface NSData (TLVParser)
- (NSMutableDictionary*) parseTLVData;
@end


@interface NSMutableDictionary (MTTLVList)

-(MTTLV*)getTLV;
- (NSString*) dumpTags;
@end
