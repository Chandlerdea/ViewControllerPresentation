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

There are fhour animations that you get out of the box: default, overlay, peek, and circle.

#### Default Animation

The default animation is modal, from bottom to top. The presented view controller will be pinned to the bottom of the presenting view controller. See the gif above for an example

#### Overlay Animation

`ViewControllerOverlayPlacement` defines 3 different positions: `top`, `center`, and `bottom`. Both `top` and `bottom` have an associated value, which is used for padding. To use this animation, you use a `ViewControllerOverlayTransitionAnimationController`, which takes a `ViewControllerOverlayPlacement` in the initializer.

Using the framework is very easy. 
```swift
let vc: UIViewController = .....
let overlay: ViewControllerOverlay = try! ViewControllerOverlay(entry: .top, exit: .bottom, position: .center)
self.transitionController = ViewControllerOverlayTransitionAnimationController(overlay: overlay) // You need to keep a strong reference to this object
vc.transitioningDelegate = self.transitionController
self.present(vc, animated: true, completion: completion)
```
Here's what it looks like:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/overlay-transition.gif)

#### Peek Animation

The peek animation is the same as the transition when composing an email in Apple's Mail app. The view controller presenting the new view controller "peeks" behind the presented view controller.  To present a view controller this way, have you view controller conform to `ViewControllerPeekPresentable`. `ViewControllerPeekPresentable` has default implementations for its properties, but you can override them for custom values.

Here is what it looks like:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/peek-transition.gif)

#### Circle Animation

The circle animation is a very specific animation, mostly for demo purporeses, which looks like this:

![sample](https://github.com/Chandlerdea/ViewControllerPresentation/blob/master/circle-transition.gif)

## Tests
I have application tests for the default and overlay animations. The application tests are like unit tests, execept you have access to view controllers, and objects in your application while it is running on the simulator. This is ideal for testing view controllers.

## Support
If you find any bugs, or have any critiques, please open a PR and I will fix them as soon as I can. And if you feel the need to add some more tests, you're more than welcome!
