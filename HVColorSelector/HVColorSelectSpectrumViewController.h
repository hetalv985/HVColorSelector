//
//  HVColorSelectSpectrumViewController.h
//  HVColorSelector
//
//  Created by Vora, Hetal on 11/18/13.
//  Copyright (c) 2013 Vora, Hetal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HVColorSelectorDelegate <NSObject>

-(void)didSelectColor:(UIColor*)selectedColor;

@end


@interface HVColorSelectSpectrumViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) id<HVColorSelectorDelegate> colorSelectorDelegate;
@end
