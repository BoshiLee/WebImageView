# Web Image View

## Features

- Fix reused bug with UITableViewCell or UICollectionViewCell
- Loading web image with view animation 
- Smooth loading web image

<p align="center">
  <img src="https://media.giphy.com/media/xULW8ABL8rsw3jZyaA/giphy.gif">
</p>


## Useage:

1. Drag the UIImageView to your storyboard and set it to `WebImageView.swift`

![](https://i.imgur.com/JXVrs5W.png)

2. Load Image form URL：

 
```Swift
yourImageView.load(fromURLString: webUrlString, enableAnimation: true, defaultImage: UIImage(named: "defaultImage")!)
```

3. You can set animation transition style with `animationOptions:`

```Swift
yourImageView.load(fromURLString: webUrlString, enableAnimation: true, defaultImage: UIImage(named: "defaultImage")!, animationOptions: .transitionCrossDissolve)
```

Check out animationOptions with [UIViewAnimationOptions](https://developer.apple.com/documentation/uikit/uiviewanimationoptions) documents.

4. Or just set `enableAnimation: false` to load without animations.

5. Cancel download tasks for table view `didEndDisplaying` :

```Swift
func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let imageCell = cell as? ImageTableViewCell else {return}
    imageCell.imageView.cancelLoading()
}
```    


## Requirements:

- Swift 3
- iOS 10

## Installation:

Drag `WebImageView.swift` and `InternetUtil.swift` to your XCode project.

## Contact Me
Contact me with with email or linkedin

- [Email](boshi.litw@gmail.com)
- [LinkedIn](https://www.linkedin.com/in/boshi-li-b72836102/)

## Other:
- Please 🌟 this repo if you like it! 











