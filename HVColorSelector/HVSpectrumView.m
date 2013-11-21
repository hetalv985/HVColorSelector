//
//  HVSpectrumView.m
//  HVColorSelector
//
//  Created by Vora, Hetal on 11/18/13.
//  Copyright (c) 2013 Vora, Hetal. All rights reserved.
//

#import "HVSpectrumView.h"

@interface HVSpectrumView(){
    int xStep, yStep;
}

@end

@implementation HVSpectrumView
@synthesize selectedColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)awakeFromNib{
    xStep = self.frame.size.width/255;
    yStep = self.frame.size.height/255;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat hue=0.0, brightness=0.0;
    
    for(int y=0;y<=rect.size.height;y+=yStep){
        hue = 0;
        for (int x=0;x<=rect.size.width;x+=xStep){
            
            CGContextSaveGState(context);
            CGContextSetFillColorWithColor(context, [[UIColor colorWithHue:hue/255.0 saturation:1.0 brightness:brightness/255.0 alpha:1.0] CGColor]);
            CGContextFillRect(context, CGRectMake(x, y, xStep, yStep));
            CGContextRestoreGState(context);
            hue = hue+1;
            
        }
        brightness = brightness +1.0;
    }
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPt = [touch locationInView:self];
    self.selectedColor= [self colorOfPoint:touchPt];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorSelectedNotification" object:nil];
}

- (UIColor*)colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace,(CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}



@end
