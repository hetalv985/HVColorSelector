//
//  HVViewController.m
//  HVColorSelector
//
//  Created by Vora, Hetal on 11/19/13.
//  Copyright (c) 2013 Vora, Hetal. All rights reserved.
//

#import "HVViewController.h"
#import "HVColorSelectSpectrumViewController.h"

@interface HVViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end

@implementation HVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    HVColorSelectSpectrumViewController *hvColorSpectrumViewController = segue.destinationViewController;
    hvColorSpectrumViewController.colorSelectorDelegate = self;
}

//delegate method that gets called when you select a color
-(void)didSelectColor:(UIColor *)selectedColor{
    self.colorView.backgroundColor = selectedColor;
}

@end
