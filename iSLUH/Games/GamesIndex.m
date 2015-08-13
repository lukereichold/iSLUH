#import "GamesIndex.h"
#import "FlashCardsViewController.h"
#import "FlashCardsVCiPad.h"
#import "DYKiPad.h"

@interface GamesIndex ()

@property (nonatomic, strong) NSMutableArray *games;

@end

@implementation GamesIndex

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.navigationItem.title = @"Games";
	self.games = [[NSMutableArray alloc]initWithObjects:@"Did You Know?", @"Flashcards", nil];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    return ([Convenience isiPad]) ? UIInterfaceOrientationMaskAll : (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
	if (indexPath.section == 0) {   // did you know?
		[[cell textLabel] setTextColor:[UIColor sluhNavy]];

        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.text = @"Did You Know?";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    if (indexPath.section == 1) {       //flashcards
		[[cell textLabel] setTextColor:[UIColor whiteColor]];
        cell.backgroundColor = [UIColor sluhNavy];
		cell.textLabel.text = @"Flashcards!";
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.section == 0) {       //did you know?
        
        if ([Convenience isiPad]) {
            DYKiPad *ipadtrivia = [[DYKiPad alloc]initWithNibName:@"DYKiPad" bundle:nil];
            ipadtrivia.title = @"Did You Know?!";
            [self.navigationController pushViewController: ipadtrivia animated:YES];
        }
        else {
            DidYouKnow *dykiphone = [[DidYouKnow alloc]initWithNibName:@"DidYouKnow" bundle:nil];
            dykiphone.title = @"Did You Know?";
            [self.navigationController pushViewController: dykiphone animated:YES];
        }
	}
    
    if (indexPath.section == 1) {       //flashcards
    
        if ([Convenience isiPad])   {
            FlashCardsVCiPad *flashcardVC = [[FlashCardsVCiPad alloc]initWithNibName:@"FlashCardsVCiPad" bundle:nil];
        
            flashcardVC.title = @"Flashcards!";
            [self.navigationController pushViewController: flashcardVC animated:YES];
        }
        else {
            
            FlashCardsViewController *flashcardVC = [[FlashCardsViewController alloc]initWithNibName:@"FlashCardsViewController" bundle:nil];
            
            flashcardVC.title = @"Flashcards!";
            [self.navigationController pushViewController: flashcardVC animated:YES];
        }
	}
}

@end