#import "LRFViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#define USER_ID @"user_id"
#define USER_FORGET_PASSWORD_URL @"http://Project/forgotPassword?emailId=%@"
#define USER_LOGIN_URL @"http://Project/login?emailId=%@&password=%@"
#define USER_REGISTRATION_URL @"http://Project/register?name=%@&emailId=%@&password=%@"

@interface URLConnection : NSURLConnection {
	NSString *tagInfo;
	NSHTTPURLResponse *response;
	NSMutableData *responseData;
}
@property (nonatomic, strong) NSString *tagInfo;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSMutableData *responseData;
- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate andtag:(NSString *)tag;
@end
@implementation URLConnection
@synthesize tagInfo, response, responseData;
- (id)initWithRequest:(NSURLRequest *)request delegate:(id)delegate andtag:(NSString *)tag {
	NSAssert(self != nil, @"self is nil!");
	self.response = nil;
	self.responseData = nil;
	self.tagInfo = tag;
	self = [super initWithRequest:request delegate:delegate];
	return self;
}

@end


@implementation LRFViewController

@synthesize isViewModeUp, isAutoLoginEnabled;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		CurrentView = 1;
		appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
		label.text = @"LOGIN";
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundPatternImage"]]];
	[[[self navigationController]navigationBar]setHidden:YES];
	[self UpdateScreen];
	[[NSNotificationCenter defaultCenter] addObserver:self
	                                         selector:@selector(AppGoingtobackground)
	                                             name:UIApplicationDidEnterBackgroundNotification
	                                           object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
	T3.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"RememberedEmail"];
	T4.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"RememberedPassword"];
	if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"isAutoLoginEnabled"]isEqualToString:@"YES"])
		isAutoLoginEnabled = FALSE;
	else
		isAutoLoginEnabled = TRUE;
	if (T3.text.length > 0 && T4.text.length > 0 && isAutoLoginEnabled == FALSE) {
		[self OnClickB4];
		[self OnClickB2];
	}
	else {
		[self OnClickB4];
	}
}

- (void)AppGoingtobackground {
	[self setViewMovedUp:NO];
}

- (void)UpdateScreen {
	[self AnimationArrayOfWidgets:[NSArray arrayWithObjects:label, T1, T2, T3, T4, B1, B2, B3, Autologin, B4, nil]];
	[self breathAnimation:self.view];

	[T1 setText:@""];
	[T2 setText:@""];
	[T3 setText:@""];
	[T4 setText:@""];

	if (CurrentView == 1) {
		[T3 setPlaceholder:@"Email"];
		[T4 setPlaceholder:@"Password"];

		[B1 setBackgroundImage:[UIImage imageNamed:@"retrieve pass.png"] forState:UIControlStateNormal];
		[B1 setBackgroundImage:[UIImage imageNamed:@"retrieve pass_f.png"] forState:UIControlStateHighlighted];
		[B2 setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
		[B2 setBackgroundImage:[UIImage imageNamed:@"login_f.png"] forState:UIControlStateHighlighted];
		[B3 setBackgroundImage:[UIImage imageNamed:@"signup.png"] forState:UIControlStateNormal];
		[B3 setBackgroundImage:[UIImage imageNamed:@"signup_f.png"] forState:UIControlStateHighlighted];


		B1.hidden = false;
		B2.hidden = false;
		B3.hidden = false;
		B4.hidden = false;

		T1.hidden = true;
		T2.hidden = true;
		T3.hidden = false;
		T4.hidden = false;
		T3.secureTextEntry = NO;
		T4.secureTextEntry = YES;
		T1.keyboardType = UIKeyboardTypeDefault;
		T2.keyboardType = UIKeyboardTypeDefault;
		T3.keyboardType = UIKeyboardTypeEmailAddress;
		T4.keyboardType = UIKeyboardTypeDefault;
		label.text = @"LOGIN";
		Autologin.hidden = false;
	}
	else if (CurrentView == 2) {
		[T1 setPlaceholder:@"Name"];
		[T2 setPlaceholder:@"Email"];
		[T3 setPlaceholder:@"Password"];
		[T4 setPlaceholder:@"Confirm password"];

		[B1 setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
		[B1 setBackgroundImage:[UIImage imageNamed:@"cancel_f.png"] forState:UIControlStateHighlighted];
		[B2 setBackgroundImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
		[B2 setBackgroundImage:[UIImage imageNamed:@"submit_f.png"] forState:UIControlStateHighlighted];

		B1.hidden = false;
		B2.hidden = false;
		B3.hidden = true;
		B4.hidden = true;

		T1.hidden = false;
		T2.hidden = false;
		T3.hidden = false;
		T4.hidden = false;
		T3.secureTextEntry = YES;
		T3.secureTextEntry = YES;

		T1.keyboardType = UIKeyboardTypeNamePhonePad;
		T2.keyboardType = UIKeyboardTypeEmailAddress;
		T3.keyboardType = UIKeyboardTypeDefault;
		T4.keyboardType = UIKeyboardTypeDefault;
		label.text = @"SIGN UP";
		Autologin.hidden = true;
	}
	else if (CurrentView == 3) {
		[T4 setPlaceholder:@"Email"];

		[B1 setBackgroundImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
		[B1 setBackgroundImage:[UIImage imageNamed:@"cancel_f.png"] forState:UIControlStateHighlighted];
		[B2 setBackgroundImage:[UIImage imageNamed:@"submit.png"] forState:UIControlStateNormal];
		[B2 setBackgroundImage:[UIImage imageNamed:@"submit_f.png"] forState:UIControlStateHighlighted];

		B1.hidden = false;
		B2.hidden = false;
		B3.hidden = true;
		B4.hidden = true;

		T1.hidden = true;
		T2.hidden = true;
		T3.hidden = true;
		T4.hidden = false;
		T3.secureTextEntry = NO;
		T4.secureTextEntry = NO;

		T1.keyboardType = UIKeyboardTypeDefault;
		T2.keyboardType = UIKeyboardTypeDefault;
		T3.keyboardType = UIKeyboardTypeDefault;
		T4.keyboardType = UIKeyboardTypeEmailAddress;

		label.text = @"RETRIEVE PASSWORD";
		Autologin.hidden = true;
	}
}

- (BOOL)Validate {
	if (CurrentView == 1) {
		BOOL WhatToReturn = TRUE;
		NSString *error;

		if (!([self validateEmailWithString:[T3 text]])) {
			WhatToReturn = NO;
			error = @"Please enter valid Email";
			[self AnimationAsIfErrorfor:T3];
		}
		else if ([[T4 text]length] < 6) {
			error = @"Password should have atleast six characters";
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T4];
		}

		if (error != nil) {
			UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Login" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[errorAlert show];
		}
		return WhatToReturn;
	}
	else if (CurrentView == 2) {
		BOOL WhatToReturn = TRUE;
		NSString *error;

		if ([[T1 text] length] == 0) {
			error = @"Please enter your name";
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T1];
		}
		else if (![self validateUsernameWithString:[T1 text]]) {
			error = @"Please enter valid name . Only alphabets and numbers are allowed";
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T1];
		}
		else if (![self validateEmailWithString:[T2 text]]) {
			WhatToReturn = NO;
			error = @"Please enter valid Email";
			[self AnimationAsIfErrorfor:T2];
		}
		else if ([[T3 text]length] == 0) {
			error = @"Please enter password";
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T3];
		}
		else if ([[T3 text]length] < 6) {
			error = @"Password should have atleast six characters";
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T3];
		}
		else if ([[T4 text]length] == 0) {
			error = @"Please confirm the password";
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T3];
		}
		else if (!([[T3 text]isEqualToString:[T4 text]])) {
			error = @"Password's do not matches";
			[T3 setText:@""];
			[T4 setText:@""];
			WhatToReturn = NO;
			[self AnimationAsIfErrorfor:T3];
			[self AnimationAsIfErrorfor:T4];
		}
		if (error != nil) {
			UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Sign up" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[errorAlert show];
		}
		return WhatToReturn;
	}
	else if (CurrentView == 3) {
		BOOL WhatToReturn = TRUE;
		NSString *error;

		if (!([self validateEmailWithString:[T4 text]])) {
			WhatToReturn = NO;
			error = @"Please enter valid Email";
			[self AnimationAsIfErrorfor:T4];
		}
		if (error != nil) {
			UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Retrieve password" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[errorAlert show];
		}
		return WhatToReturn;
	}
	return YES;
}

- (IBAction)OnClickB1 {
	[self setViewMovedUp:NO];

	if (CurrentView == 1) {
		CurrentView = 3;
		[self UpdateScreen];
	}
	else if (CurrentView == 2) {
		CurrentView = 1;
		[self UpdateScreen];
	}
	else if (CurrentView == 3) {
		CurrentView = 1;
		[self UpdateScreen];
	}
}

- (IBAction)OnClickB2 {
	[self setViewMovedUp:NO];

	if ([self Validate] == NO)
		return;

	NSString *string = nil;
	NSString *tagInfo;

	if (CurrentView == 1) {
		//----data to post is---emailId="email"" password=""
		//here we have to request server for login of the user
		[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:USER_ID];
		tagInfo = @"Login";
		NSString *D1 = [T3 text];
		NSString *D2 = [T4 text];
		string = [NSString stringWithFormat:USER_LOGIN_URL, D1, D2];
	}
	else if (CurrentView == 2) {
		//----data to post is---name="user name"&password=""&userId="login userid"&emailId="email""
		//here we have to request server for registration of new user
		tagInfo = @"Sign up";
		NSString *D1 = [T1 text];
		NSString *D2 = [T2 text];
		NSString *D3 = [T3 text];
		string = [NSString stringWithFormat:USER_REGISTRATION_URL, D1, D2, D3];
	}
	else if (CurrentView == 3) {
		//here we have to request server for recovery of the password of user
		//----data to post is---emailId="email"
		tagInfo = @"Retrieve password";
		NSString *D1 = [T4 text];
		string = [NSString stringWithFormat:USER_FORGET_PASSWORD_URL, D1];
	}

	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
	[[URLConnection alloc]initWithRequest:request delegate:self andtag:tagInfo];
}

- (IBAction)OnClickB3 {
	[self setViewMovedUp:NO];
	CurrentView = 2;
	[self UpdateScreen];
}

- (IBAction)OnClickB4 {
	isAutoLoginEnabled = !isAutoLoginEnabled;

	if (isAutoLoginEnabled) {
		[B4 setBackgroundImage:[UIImage imageNamed:@"checkboxf_30x30"] forState:UIControlStateNormal];
		[B4 setBackgroundImage:[UIImage imageNamed:@"checkboxf_30x30"] forState:UIControlStateHighlighted];
	}
	else {
		[B4 setBackgroundImage:[UIImage imageNamed:@"checkbox_30x30"] forState:UIControlStateNormal];
		[B4 setBackgroundImage:[UIImage imageNamed:@"checkbox_30x30"] forState:UIControlStateHighlighted];
		[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"RememberedEmail"];
		[[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"RememberedPassword"];
		[[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:@"isAutoLoginEnabled"];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setViewMovedUp:NO];
}

#pragma mark -
#pragma mark Json Delegate Methods
//for response frm server
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	URLConnection *conn = (URLConnection *)connection;
	conn.responseData = [NSMutableData data];
	[conn.responseData setLength:0];
}
// for data reception
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	URLConnection *conn = (URLConnection *)connection;
	[conn.responseData appendData:data];
}
// for error in response
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	URLConnection *conn = (URLConnection *)connection;
	NSString *responseString = [[NSString alloc]initWithData:conn.responseData encoding:NSUTF8StringEncoding];
	NSDictionary *dict  = /** User your parser and parse json response*/ nil;
	bool isSucceded = true;
	if ([dict objectForKey:@"isSucceded"]) {
		isSucceded = [[dict objectForKey:@"isSucceded"]boolValue];
	}
	if ([conn.tagInfo isEqualToString:@"Login"]) {
	}
	else if ([conn.tagInfo isEqualToString:@"Sign up"]) {
		CurrentView = 1;
		[self UpdateScreen];
	}
	else if ([conn.tagInfo isEqualToString:@"Retrieve password"] && [dict objectForKey:@"message"]) {
		CurrentView = 1;
		[self UpdateScreen];
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)sender {
	if (self.view.frame.origin.y >= 0) {
		[self setViewMovedUp:YES];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	[self setViewMovedUp:NO];
	return YES;
}

- (void)setViewMovedUp:(BOOL)movedUp {
#define kOFFSET_FOR_KEYBOARD 80
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.2];
	CGRect rect = self.view.frame;
	if (movedUp) {
		if (!isViewModeUp) {
			isViewModeUp = YES;
			rect.origin.y -= kOFFSET_FOR_KEYBOARD;
			rect.size.height += kOFFSET_FOR_KEYBOARD;
		}
	}
	else {
		[T1 resignFirstResponder];
		[T2 resignFirstResponder];
		[T3 resignFirstResponder];
		[T4 resignFirstResponder];

		if (isViewModeUp) {
			isViewModeUp = NO;
			rect.origin.y += kOFFSET_FOR_KEYBOARD;
			rect.size.height -= kOFFSET_FOR_KEYBOARD;
		}
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}

- (BOOL)validateEmailWithString:(NSString *)email {
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:email];
}

- (BOOL)validateUsernameWithString:(NSString *)username {
	NSString *nameRegex = @"[a-zA-Z0-9_ ]+$";
	NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
	return [nameTest evaluateWithObject:username];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	return YES;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)breathAnimation:(UIView *)view {
	NSString *kBreath = @"breath";
	NSString *kOpacity = @"opacity";

	[CATransaction begin];
	CAKeyframeAnimation *BreathAnimation = [CAKeyframeAnimation animationWithKeyPath:kOpacity];
	NSArray *OpacityValues = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0f],
	                          [NSNumber numberWithFloat:0.0f],
	                          [NSNumber numberWithFloat:0.1f], [NSNumber numberWithFloat:0.2f], [NSNumber numberWithFloat:0.30f], [NSNumber numberWithFloat:0.4f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:0.6f], [NSNumber numberWithFloat:0.7f], [NSNumber numberWithFloat:0.8f], [NSNumber numberWithFloat:0.9f], [NSNumber numberWithFloat:1.0f], nil];
	NSArray *OpacityTimes = [NSArray arrayWithObjects:
	                         [NSNumber numberWithFloat:0.0f],
	                         [NSNumber numberWithFloat:0.1f], [NSNumber numberWithFloat:0.2f], [NSNumber numberWithFloat:0.30f], [NSNumber numberWithFloat:0.4f], [NSNumber numberWithFloat:0.5f], [NSNumber numberWithFloat:0.6f], [NSNumber numberWithFloat:0.7f], [NSNumber numberWithFloat:0.8f], [NSNumber numberWithFloat:0.9f], [NSNumber numberWithFloat:1.0f], [NSNumber numberWithFloat:1.1f], nil];
	[BreathAnimation setValues:OpacityValues];
	[BreathAnimation setKeyTimes:OpacityTimes];
	[BreathAnimation setDuration:1.1f];
	[BreathAnimation setRepeatCount:0];
	[BreathAnimation setFillMode:kCAFillModeRemoved];
	[BreathAnimation setCalculationMode:kCAAnimationLinear];
	[BreathAnimation setRemovedOnCompletion:YES];
	[BreathAnimation setDelegate:self];
	[view.layer addAnimation:BreathAnimation forKey:kBreath];
	[CATransaction commit];
}

- (void)AnimationArrayOfWidgets:(NSArray *)Objects {
	float FullDistance = 320.0f;
	float SmallDistance = 20.0f;
	int counter = 0;
	for (float i = 0.6; counter < Objects.count; i += 0.1, counter++) {
		SmallDistance = -SmallDistance;
		FullDistance = -FullDistance;
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
		[animation setDuration:i];
		[animation setRepeatCount:0];
		[animation setAutoreverses:NO];
		[animation setFromValue:[NSValue valueWithCGPoint:
		                         CGPointMake([[Objects objectAtIndex:counter] center].x - FullDistance, [[Objects objectAtIndex:counter] center].y)]];
		[animation setToValue:[NSValue valueWithCGPoint:
		                       CGPointMake([[Objects objectAtIndex:counter] center].x + SmallDistance, [[Objects objectAtIndex:counter] center].y)]];
		[[[Objects objectAtIndex:counter] layer] addAnimation:animation forKey:@"position"];
	}
}

- (void)AnimationAsIfErrorfor:(id)object {
	CABasicAnimation *animation_ = [CABasicAnimation animationWithKeyPath:@"position"];
	[animation_ setDuration:0.07];
	[animation_ setRepeatCount:3];
	[animation_ setAutoreverses:YES];
	[animation_ setFromValue:[NSValue valueWithCGPoint:
	                          CGPointMake([object center].x - 8.0f, [object center].y)]];
	[animation_ setToValue:[NSValue valueWithCGPoint:
	                        CGPointMake([object center].x + 8.0f, [object center].y)]];
	[[object layer] addAnimation:animation_ forKey:@"position"];
}

@end
