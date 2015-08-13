#import "RotatableNavController.h"

@interface RotatableNavController ()

@end


@implementation RotatableNavController

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

@end
