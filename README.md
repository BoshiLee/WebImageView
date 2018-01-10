# Web Image View

## Features

- Fix reused bug with UITableViewCell or UICollectionViewCell
- Loading web image with view animation 
- Smooth loading web image


![](https://media.giphy.com/media/xULW8ABL8rsw3jZyaA/giphy.gif)


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
    imageCell.pixaImageView.task?.cancel()
}
```    


## Requirements:

- Swift 3

## Installation:

Drag `WebImageView.swift` and `InternetUtil.swift` to your XCode project.

## Other:

Please share this repo if you like it! 
May the force be with you. 🤩











