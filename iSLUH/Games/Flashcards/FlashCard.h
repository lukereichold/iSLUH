#import <Foundation/Foundation.h>

#define kQuestion @"Question"
#define kAnswer @"Answer"
#define kRightCount @"RightCount"
#define kWrongCount @"WrongCount"

@interface FlashCard : NSObject <NSCoding> {}

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, assign) NSUInteger rightCount;
@property (nonatomic, assign) NSUInteger wrongCount;

- (id)initWithQuestion:(NSString *)thisQuestion answer:(NSString *)thisAnswer;

@end