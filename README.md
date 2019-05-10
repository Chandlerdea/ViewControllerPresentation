# ViewControllerPresentation
A small framwork for the custom presentation of view controllers

## Installation
### Requirements
* Swift 5

### Carthage
Add this line to your `Cartfile`:
```
github "Chandlerdea/ViewControllerPresentation"
```

### Manual
You can just drop `ViewControllerPresentation.xcodeproj` into your project and then add `ViewControllerPresentation.framework` to your app’s embedded frameworks


## Use
### Demo
This framework uses the default animation for presenting view controllers, but uses the view controller's `preferredContentSize` to display the presented view controller. Here's what the default animation looks like:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/viewcontrollerpresentation_demo.gif)

### Code

There are two animations that you get out of the box: default and overlay.

#### Default Animation

The default animation is modal, from bottom to top. The presented view controller will be pinned to the bottom of the presenting view controller. See the gif above for an example

#### Overlay Animation

`ViewControllerOverlayPlacement` defines 3 different positions: top, center, and bottom. Both top and bottom have an associated value, which is used for padding. To use this animation, you use a `ViewControllerOverlayTransitionAnimationController`, which takes a `ViewControllerOverlayPlacement` in the initializer.

Using the framework is very easy. 
```swift
let vc: UIViewController = .....
vc.modalPresentationStyle = .custom
vc.transitioningDelegate = self.animationController // We need a strong reference to this property 
self.present(vc, animated: true, completion: nil)
```
And that's it!

#### Peek Animation

The peek animation is the same as the transition when composing an email in Apple's Mail app. The view controller presenting the new view controller "peeks" behind the presented view controller. Here is what it looks like:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/peek_transition.gif)

#### Circle Animation

The circle animation is a very specific animation, mostly for demo purporeses, which looks like this:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/circle_transition.gif)

## Tests
I have application tests for the default and overlay animations. The application tests are like unit tests, execept you have access to view controllers, and objects in your application while it is running on the simulator. This is ideal for testing view controllers.

## Support
If you find any bugs, or have any critiques, please open a PR and I will fix them as soon as I can. And if you feel the need to add some more tests, you're more than welcome!
