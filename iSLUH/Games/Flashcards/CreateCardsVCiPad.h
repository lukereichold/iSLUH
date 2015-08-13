#import <UIKit/UIKit.h>

@protocol CreateCardDelegates <NSObject>

-(void) didCancelCardCreation;
-(void) didCreateCardWithQuestion:(NSString *)question
                           answer:(NSString *)answer;

@end

@interface CreateCardsVCiPad: UIViewController  {
    id __weak cardDelegates;
}

@property (nonatomic, strong) IBOutlet UITextField *question;
@property (nonatomic, strong) IBOutlet UITextField *answer;
@property (nonatomic, weak) id<CreateCardDelegates> cardDelegates;

- (IBAction)save;
- (IBAction)cancel;

@end