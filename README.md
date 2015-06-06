# YPMagnifyingGlass

YPMagnifyingGlass is Swift port of [ACMagnifyingGlass](https://github.com/acoomans/iOS-MagnifyingGlass), a magnifier like the one in the iOS _notes_ app.

## Usage

Select the view you want to magnify, and embed it in another view. Set the views class to `YPMagnifyingGlass`, and connect it to an `IBOutlet` property in your `UIViewController` (or whatever else). In this example you call the connected view `magnifyingView`.

Then in your code, add
```
var mag = YPMagnifyingGlass(frame:CGRectMake(magnifyingView.frame.origin.x, magnifyingView.frame.origin.y,100,100))
mag.scale = 2
self.magnifyingView.magnifyingGlass = mag
```

## Installation

Add _YPMagnifyingGlass.swift_ and _YPMagnifyingView.swift_ to your project

## Author

Geert-Jan Nilsen ( gert@yuppielabel.com )
[Yuppielabel](http://yuppielabel.com)

## Thanks

Thanks a lot to [Arnaud Coomans](http://acoomans.com) for writing the original class this was ported from, [ACMagnificationGlass](https://github.com/acoomans/iOS-MagnifyingGlass). He has kindly granted me to share it with all of you.

## License

YPMagnifyingGlass is available under the MIT license. See the LICENSE file for more info.
