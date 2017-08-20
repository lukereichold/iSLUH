#import "FlashCardsVCiPad.h"
#import "CreateCardsVCiPad.h"
#import "UIColor+SLUHCustom.h"


@implementation FlashCardsVCiPad

- (FlashCard *) currentCard {
    
    if (self.currentCardCounter < 0) {
        return nil;
    }
    return [self.flashCards objectAtIndex:self.currentCardCounter];
}

- (void)showNextCard {
    
    self.rightButton.enabled = NO;
    self.wrongButton.enabled = NO;
    
    NSUInteger numberOfCards = [self.flashCards count];
    
    if (numberOfCards == 0) {
        // UI State for no cards
        self.question.text = @"";
        self.answer.text = @"";
        self.cardCount.text = @"Add a flash card to get started!";
        self.wrongCount.text = @"";
        self.rightCount.text = @"";
        self.deleteButton.enabled = NO;
        self.actionButton.enabled = NO;
    } else {
        self.currentCardCounter += 1;
        if (self.currentCardCounter >= numberOfCards) {
            // Loop back to the first card
            self.currentCardCounter = 0;
        }
        self.cardCount.text =
        [NSString stringWithFormat:@"%i of %i",
         (self.currentCardCounter + 1), numberOfCards];
        self.question.text = self.currentCard.question;
        self.answer.hidden = YES;
        self.answer.text = [NSString stringWithFormat:@"Answer: %@" , self.currentCard.answer];
        [self updateRightWrongCounters];
        self.deleteButton.enabled = YES;
        self.actionButton.enabled = YES;
    }
}

- (void) updateRightWrongCounters {
    self.wrongCount.text =
    [NSString stringWithFormat:@"Wrong: %i",
     self.currentCard.wrongCount];
    self.rightCount.text =
    [NSString stringWithFormat:@"Right: %i",
     self.currentCard.rightCount];
}

- (IBAction) nextAction {
    if (self.answer.hidden) {
        self.answer.hidden = NO;
        self.rightButton.enabled = YES;
        self.wrongButton.enabled = YES;
    } else {
        [self showNextCard];
    }
}

- (IBAction) markWrong {
    
    // Update the flash card
    self.currentCard.wrongCount += 1;
    if (!self.rightButton.enabled) {
        // They had previously marked the card right
        self.currentCard.rightCount -= 1;
    }
    // Update the UI
    self.wrongButton.enabled = NO;
    self.rightButton.enabled = YES;
    [self updateRightWrongCounters];    
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (IBAction) markRight {
    
    // Update the flash card
    self.currentCard.rightCount += 1;
    if (!self.wrongButton.enabled) {
        // They had previously marked the card right
        self.currentCard.wrongCount -= 1;
    }
    // Update the UI
    self.wrongButton.enabled = YES;
    self.rightButton.enabled = NO;
    [self updateRightWrongCounters];    
}

- (IBAction) addCard {
    
    // Show the create card view
    CreateCardsVCiPad *cardCreator =
    [[CreateCardsVCiPad alloc] init];
	cardCreator.cardDelegates = self;
    [self presentViewController:cardCreator animated:YES completion:nil];
}

#pragma mark -
#pragma mark CreateCardDelegate

- (void) didCancelCardCreation {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) didCreateCardWithQuestion:(NSString *)thisQuestion
                           answer:(NSString *)thisAnswer {
    
    // Add the new card as the next card
    FlashCard *newCard = [[FlashCard alloc]initWithQuestion: thisQuestion
                                                     answer:thisAnswer];
    if (self.currentCardCounter >= [self.flashCards count]) {
        [self.flashCards addObject:newCard];
    } else {
        [self.flashCards insertObject:newCard
                              atIndex:(self.currentCardCounter + 1)];
    }
    
    // Show the new card    
    [self showNextCard];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) resetRightWrongCount
{
	if (self.flashCards != nil)	{	// protect against resetting deck when there are no cards
		NSUInteger numberOfCards = [self.flashCards count];
        
        for (int i = 0; i < numberOfCards; i++)	{
			
            self.currentCard.rightCount = 0;
            self.currentCard.wrongCount = 0;
            [self showNextCard];
            
		}
	}
}

#pragma mark –

- (IBAction) deleteCard {
    [self.flashCards removeObjectAtIndex:currentCardCounter];
    [self showNextCard];
}

- (void)viewDidLoad {
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self createBackgroundGradientWithTopColor:[UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] bottomColor:[UIColor sluhWarmGrey]];
    
	self.lowerToolbar.tintColor = [UIColor colorWithRed:(19/255.0) green:(59/255.0) blue:(189/255.0) alpha:0];
    self.flashCards = [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
    self.currentCardCounter = -1;
    if (self.flashCards == nil)
	{
        self.flashCards = [[NSMutableArray alloc] init];
    }
	
    [self showNextCard];
    [super viewDidLoad];
}

- (void)createBackgroundGradientWithTopColor:(UIColor*)topColor bottomColor:(UIColor*)bottomColor {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, 1200.0, 1200.0);
    gradient.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (NSString *)archivePath {
    NSString *docDir =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex: 0];
    return [docDir stringByAppendingPathComponent:@"FlashCards.dat"];
}

- (void)viewDidDisappear:(BOOL)animated {
	[self archiveFlashCards];
}

- (void)archiveFlashCards {
    [NSKeyedArchiver archiveRootObject:flashCards toFile:[self archivePath]];
}


@end
