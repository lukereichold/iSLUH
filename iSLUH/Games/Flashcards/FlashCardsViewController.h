#import <UIKit/UIKit.h>
#import "FlashCard.h"
#import "CreateCardViewController.h"

@interface FlashCardsViewController : UIViewController <CreateCardDelegate> {}

@property (nonatomic, strong) IBOutlet UILabel *cardCount;
@property (nonatomic, strong) IBOutlet UILabel *wrongCount;
@property (nonatomic, strong) IBOutlet UILabel *rightCount;
@property (nonatomic, strong) IBOutlet UILabel *question;
@property (nonatomic, strong) IBOutlet UILabel *answer;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *deleteButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *wrongButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *resetRightWrongCountButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *actionButton;
@property (nonatomic ,strong) IBOutlet UIToolbar *lowerToolbar;

@property (nonatomic, strong) NSMutableArray *flashCards;
@property (nonatomic, assign) NSUInteger currentCardCounter;
@property (weak, nonatomic, readonly) FlashCard *currentCard;

-(IBAction) markWrong;
-(IBAction) markRight;
-(IBAction) nextAction;
-(IBAction) resetRightWrongCount;
-(IBAction) addCard;
-(IBAction) deleteCard;

-(void)showNextCard;
-(void)updateRightWrongCounters;
-(NSString *)archivePath;
-(void)archiveFlashCards;

@end