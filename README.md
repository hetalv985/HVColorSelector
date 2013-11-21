HVColorSelector
===============

HVSelector is a simple color selector for iOS. It is currently designed to work for iPhone 4, iPhone 4s, iPhone 5 and iPhone 5s form factors. The project has been created with Xcode 5.0 with iOS 7. The deployment target is iOS 6.0 which means its works on iOS 6.0, 6.1, 7.0 and above. The code has been tested on iOS simulators for iOS 6.0, 6.1 and 7.0 with 3.5 inch and 4 inch displays.

To add HVColorSelector to your project:
1. You will need to add the following files to your project:
HVColorSelectSpectrumViewController.h
HVColorSelectSpectrumViewController.m
HVSpectrumView.h
HVSpectrumView.m
Color Select Spectrum View from Main_iPhone5.storyboard to support 4 inch displays
Color Select Spectrum View from Main_iPhone4.storyboard to support 3.5 inch displays
2. HVColorSelectSpectrumViewController.h declares a protocol called 'HVColorSelectorDelegate'. Your class which allocates, initializes and presents the HVColorSelectSpectrumViewController will have to be set as the 'colorSelectorDelegate' for HVColorSelectSpectrumViewController and will need to implement the HVColorSelectorDelegate protocol. You can refer to HVViewController.h and HVViewController.m files to see how this is done.
3. The 'HVColorSelectorDelegate' has just one method '-(void)didSelectColor:(UIColor*)selectedColor' which will be called on the delegate when you select any color from the color selector spectrum. This will get you the UIColor object for the selected color.

The other files are merely to demo the capability of HVColorSelector:
HVAppDelegate.h and .m - Application delegate and launches correct storyboard based on the display screen size.
HVViewController.h and .m - Displays button 'Pick BGColor' on the navigation bar. When you click this button, it pushes the HVColorSelectSpectrumViewController into the navigation bar. This class declares itself as the colorSelectorDelegate and implements 'HVColorSelectorDelegate' protocol. When you select any color on the color selector screen and click done, the delegate method '-(void)didSelectColor:(UIColor*)selectedColor' gets called in this class and uses the selectedColor to set as the background color of a view added to this class.  



