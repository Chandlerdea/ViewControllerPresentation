# ViewControllerPresentation
A small framwork for the custom presentation of view controllers

## Installation
### Requirements
* Swift 4

### Carthage
Add this line to your `Cartfile`:
```
github "Chandlerdea/ViewControllerPresentation"
```

### Manual
You can just drop `ViewControllerPresentation.xcodeproj` into your project and then add `ViewControllerPresentation.framework` to your app’s embedded frameworks


## Use
### Demo
This framework uses the default animation for presenting view controllers, but uses the view controller's `preferredContentSize` to display the presented view controller. Here's what the animation looks like:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/viewcontrollerpresentation_demo.gif)

Right now, the frameworks pins the presented view controller's view to the bottom of the screen. I want to eventually add support for a custom origins for presented view controllers' views.

### Code

Using the framework is very easy. 
```
let vc: UIViewController = .....
vc.modalPresentationStyle = .custom
vc.transitioningDelegate = self.animationController // We need a strong reference to the ViewControlllerTransitionAnimationController 
self.present(vc, animated: true, completion: nil)
```
And that's it! If the presented view controller has a `presentedContentSize`, its view will show up as that size.

## Tests
I have application tests for the basic animation. The application tests are like unit tests, execept you have access to view controllers, and objects in your application while it is running on the simulator. This is ideal for testing view controllers.

## Support
If you find any bugs, or have any critiques, please open a PR and I will fix them as soon as I can. And if you feel the need to add some more tests, you're more than welcome!
