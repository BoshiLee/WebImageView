# Web Image View

## Features

- Fix reused bug with UITableViewCell or UICollectionViewCell
- Loading web image with view animation 
- Smooth loading web image
- Automatic cancel download task when create a new task

<p align="center">
  <img src="https://media.giphy.com/media/xULW8ABL8rsw3jZyaA/giphy.gif">
</p>


## Useage:

1. Drag the UIImageView to your storyboard and set it to `WebImageView.swift`

![](https://i.imgur.com/JXVrs5W.png)

2. Load Image form URLRequest：


```Swift
yourImageView.load(request: URLRequest(url: imageURL))
```

3. Optional Setting palceholder Image or animationOptions:

```Swift
@IBOutlet weak var imageView: WebImageView! {
	didSet {
    	imageView.configuration.placeholderImage = UIImage(named: "placeholderImage")
        imageView.configuration.animationOptions = .transitionCrossDissolve
	}
}
```

Check out animationOptions with [UIViewAnimationOptions](https://developer.apple.com/documentation/uikit/uiviewanimationoptions) documents.



## Requirements:

- Swift 3
- iOS 10

## Installation:

Drag `WebImageView.swift` to your XCode project.

## Contact Me
Contact me with with email or linkedin

- boshiLi, boshi.litw@gmail.com
- [LinkedIn](https://www.linkedin.com/in/boshi-li-b72836102/)

## Other:
- Please 🌟 this repo if you like it! 











