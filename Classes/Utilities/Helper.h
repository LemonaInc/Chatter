//
// Created By Jaxon Stevens
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Helper : NSObject

{
    
}


@property(nonatomic,assign)float _latitude;
@property(nonatomic,assign)float _longitude;
@property(nonatomic,assign)int isLastImage,isLastDish;


+ (id)sharedInstance;

//+(void)setToLabel:(UILabel*)lbl Text:(NSString*)txt WithFont:(NSString*)font FSize:(float)_size Color:(UIColor*)color;
+(void)setToLabel:(UILabel*)lbl Text:(NSString*)txt WithFont:(NSString*)font FSize:(float)_size Color:(UIColor*)color backGroundColor:(UIColor *)backGroundColor;

+(void)setButton:(UIButton*)btn Text:(NSString*)txt WithFont:(NSString*)font FSize:(float)_size TitleColor:(UIColor*)t_color ShadowColor:(UIColor*)s_color;

@end
