#import <UIKit/UIKit.h>

@protocol CreateCardDelegate <NSObject>

-(void) didCancelCardCreation;
-(void) didCreateCardWithQuestion:(NSString *)question
                           answer:(NSString *)answer;
@end


@interface CreateCardViewController : UIViewController  {
    id __weak cardDelegate;
}

@property (nonatomic, strong) IBOutlet UITextField *question;
@property (nonatomic, strong) IBOutlet UITextField *answer;
@property (nonatomic, weak) id<CreateCardDelegate> cardDelegate;

- (IBAction) save;
- (IBAction) cancel;

@end