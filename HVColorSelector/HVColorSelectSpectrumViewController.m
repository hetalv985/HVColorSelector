//
//  HVColorSelectSpectrumViewController.m
//  HVColorSelector
//
//  Created by Vora, Hetal on 11/18/13.
//  Copyright (c) 2013 Vora, Hetal. All rights reserved.
//

#import "HVColorSelectSpectrumViewController.h"
#import "HVSpectrumView.h"

@interface HVColorSelectSpectrumViewController ()
@property (weak, nonatomic) IBOutlet UIView *selectedColorView;
@property (weak, nonatomic) IBOutlet UILabel *lblOpacity;
@property (weak, nonatomic) IBOutlet HVSpectrumView *spectrumView;
@property (weak, nonatomic) IBOutlet UITextField *txtR;
@property (weak, nonatomic) IBOutlet UITextField *txtG;
@property (weak, nonatomic) IBOutlet UITextField *txtB;
@property (weak, nonatomic) IBOutlet UISlider *opacitySlider;
@property (nonatomic, strong) UIColor *selectedColor;
-(IBAction)cancelClicked:(id)sender;
-(IBAction)doneClicked:(id)sender;
-(IBAction)opacityValueChanged:(id)sender;

@end

@implementation HVColorSelectSpectrumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorSelected:) name:@"colorSelectedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)colorSelected:(NSNotification*)notification{
    self.selectedColor = self.spectrumView.selectedColor;
    self.selectedColorView.backgroundColor = self.selectedColor;
    [self updateRGBALabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)opacityValueChanged:(id)sender {
    UISlider *slider = (UISlider*)sender;
    self.lblOpacity.text = [NSString stringWithFormat:@"%.1f",slider.value];
    UIColor *colorWithAlpha = [self.selectedColor colorWithAlphaComponent:slider.value];
    self.selectedColor = colorWithAlpha;
    self.selectedColorView.backgroundColor = self.selectedColor;
    [self updateRGBALabel];
    
}

-(void)updateRGBALabel{
    CGFloat r,g,b,a;
    [self.selectedColor getRed:&r green:&g blue:&b alpha:&a];
    self.txtR.text = [NSString stringWithFormat:@"%.0f",r*255];
    self.txtG.text = [NSString stringWithFormat:@"%.0f",g*255];
    self.txtB.text = [NSString stringWithFormat:@"%.0f",b*255];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self computeColorsFromEnteredValues];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.location>2)
        return NO;
    return YES;
}

-(void)keyBoardDidAppear:(NSNotification*)notification{
    
    NSDictionary* keyboardInfo = [(NSNotification*)notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    int moveby =CGRectGetMaxY(self.txtB.frame) -  CGRectGetMinY(keyboardFrameBeginRect);
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0){
        moveby = moveby +20; //account for status bar;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     self.view.frame.origin.y-moveby,
                                     self.view.frame.size.width, self.view.frame.size.height);
    }completion:^(BOOL finished){
    }];
    
}
-(void)keyBoardDidHide:(NSNotification*)notification{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     0,
                                     self.view.frame.size.width, self.view.frame.size.height);
    }completion:^(BOOL finished){
    }];

}
-(void)computeColorsFromEnteredValues{
    CGFloat r = (self.txtR.text)?self.txtR.text.floatValue:0.0;
    CGFloat g = (self.txtG.text)?self.txtG.text.floatValue:0.0;
    CGFloat b = (self.txtB.text)?self.txtB.text.floatValue:0.0;
    self.selectedColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:self.opacitySlider.value];
    self.selectedColorView.backgroundColor = self.selectedColor ;
}

-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"colorSelectedNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

-(IBAction)cancelClicked:(id)sender{
   
    [self.navigationController popViewControllerAnimated:YES];

}

-(IBAction)doneClicked:(id)sender{
    if(self.colorSelectorDelegate){
        [self.colorSelectorDelegate didSelectColor:self.selectedColor];
    }
    [self.navigationController popViewControllerAnimated:YES];

}


@end
