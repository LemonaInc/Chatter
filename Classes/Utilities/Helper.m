//
// Copyright (c) 2014 Tech & Sound
//

#import "Helper.h"
#import "ProgressHUD.h"

@implementation Helper


static Helper *helper;
@synthesize _latitude;
@synthesize _longitude;
@synthesize isLastImage;
@synthesize isLastDish;

+ (id)sharedInstance {
    if (!helper) {
        helper  = [[self alloc] init];
    }
    
    return helper;
}

+(void)setToLabel:(UILabel*)lbl Text:(NSString*)txt WithFont:(NSString*)font FSize:(float)_size Color:(UIColor*)color backGroundColor:(UIColor *)backGroundColor
{
    
    lbl.textColor = color;
    
    if (txt != nil) {
        lbl.text = txt;
    }
    
    
    if (font != nil) {
        lbl.font = [UIFont fontWithName:font size:_size];
    }
    if (backGroundColor != nil) {
         lbl.backgroundColor = backGroundColor;
    }
    
}

+(void)setButton:(UIButton*)btn Text:(NSString*)txt WithFont:(NSString*)font FSize:(float)_size TitleColor:(UIColor*)t_color ShadowColor:(UIColor*)s_color
{
    [btn setTitle:txt forState:UIControlStateNormal];
    
    [btn setTitleColor:t_color forState:UIControlStateNormal];
    
    if (s_color != nil) {
        [btn setTitleShadowColor:s_color forState:UIControlStateNormal];
    }
    
    
    if (font != nil) {
        btn.titleLabel.font = [UIFont fontWithName:font size:_size];
    }
    else
    {
        btn.titleLabel.font = [UIFont systemFontOfSize:_size];
    }
}

@end
