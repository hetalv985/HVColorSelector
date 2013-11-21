/*The MIT License (MIT)
 
 Copyright (c) 2013 Hetal Vora
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
