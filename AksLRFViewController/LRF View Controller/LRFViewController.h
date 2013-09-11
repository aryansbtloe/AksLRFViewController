#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@interface LRFViewController : UIViewController <UITextFieldDelegate>
{
	IBOutlet UITextField *T1;
	IBOutlet UITextField *T2;
	IBOutlet UITextField *T3;
	IBOutlet UITextField *T4;

	IBOutlet UIButton *B1;
	IBOutlet UIButton *B2;
	IBOutlet UIButton *B3;
	IBOutlet UIButton *B4;

	IBOutlet UILabel *label;
	IBOutlet UILabel *Autologin;

	NSInteger CurrentView;
	AppDelegate *appDelegate;
	bool isViewModeUp;
	bool isAutoLoginEnabled;
}
@property (nonatomic, readwrite) bool isViewModeUp;
@property (nonatomic, readwrite) bool isAutoLoginEnabled;

- (IBAction)OnClickB1;
- (IBAction)OnClickB2;
- (IBAction)OnClickB3;
- (IBAction)OnClickB4;

- (void)UpdateScreen;
- (BOOL)Validate;
- (void)setViewMovedUp:(BOOL)movedUp;
- (void)AppGoingtobackground;
- (BOOL)validateEmailWithString:(NSString *)email;
- (BOOL)validateUsernameWithString:(NSString *)username;
- (void)breathAnimation:(UIView *)view;
- (void)AnimationArrayOfWidgets:(NSArray *)Objects;
- (void)AnimationAsIfErrorfor:(id)object;
@end
