#import <UIKit/UIKit.h>

%hook _UIStatusBarStringView

- (void)setText:(NSString *)text {
	if([text containsString:@":"]) {
		long long timeInSeconds = (long)CFAbsoluteTimeGetCurrent();
		timeInSeconds %= 86400;
		int ist = (timeInSeconds*600)/86400;
		NSMutableString *istStr = [[NSMutableString alloc] initWithString:@":"];
		if(ist < 100) [istStr appendString:@"0"];
		if(ist < 10) [istStr appendString:@"0"];
		[istStr appendString:[NSString stringWithFormat:@"%d",ist]];
		%orig(istStr);
	} else {
		%orig(text);
	}
}

%end
