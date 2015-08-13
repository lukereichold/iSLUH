#import "FlashCard.h"

@implementation FlashCard

- (id)initWithQuestion:(NSString *)thisQuestion answer:(NSString *)thisAnswer {
    
    if (self == [super init]) {
        self.question = thisQuestion;
        self.answer = thisAnswer;
        self.rightCount = 0;
        self.wrongCount = 0;
    }
    return self;
}

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    
    if (self == [super init]) {
        self.question = [decoder decodeObjectForKey:kQuestion];
        self.answer = [decoder decodeObjectForKey:kAnswer];
        self.rightCount = [decoder decodeIntForKey:kRightCount];
        self.wrongCount = [decoder decodeIntForKey:kWrongCount];
    }
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.question forKey:kQuestion];
    [encoder encodeObject:self.answer forKey:kAnswer];
    [encoder encodeInt:self.rightCount forKey:kRightCount];
    [encoder encodeInt:self.wrongCount forKey:kWrongCount];
    
}

#pragma mark -

@end