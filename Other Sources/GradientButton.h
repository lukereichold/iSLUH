#import <UIKit/UIKit.h>
#import <QuartzCore/CAGradientLayer.h>

@interface GradientButton : UIButton {}

@property (nonatomic, strong) IBOutlet UIColor *_highColor;
@property (nonatomic, strong) IBOutlet UIColor *_lowColor;
@property (nonatomic, strong) IBOutlet CAGradientLayer *gradientLayer;


- (void)setHighColor:(UIColor*)color;
- (void)setLowColor:(UIColor*)color;

@end
