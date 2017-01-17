# RxSwiftExamples

<br />
## Branch master is currently trying to move to Swift 3.0 version. If you want to see Swift 2.2 version of this repo, please see the [swift-2.2](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/swift-2.2) branch.
<br />

This repo should be a nice starting point for anyone that wants to start the new adventure called FRP with [RxSwift](https://github.com/ReactiveX/RxSwift/).
However, here we also have some references to more advanced examples so that no-one feels unsubscribed 😎

We try to deeply comment our examples, but bear with us if they aren't and if you have any questions just use the contact information on the bottom of the page and ask away!

## Tutorials

1. [RxSwift by Examples #1 - The basics](http://www.thedroidsonroids.com/blog/ios/rxswift-by-examples-1-the-basics/). Start your adventure with FRP and RxSwift. This article starts from the basics and shows the example of searching using Rx. [Demo](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxSwiftExample).
2. [RxSwift by Examples #2 – Observable and the Bind](http://www.thedroidsonroids.com/blog/ios/rxswift-by-examples-2-observable-and-the-bind/). Bindings, subjects, variables and stuff. We are observing and we are observed! [Demo](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Simple%20Apps/ColourfulBall)
3. [RxSwift by Examples #3 - Networking](http://www.thedroidsonroids.com/blog/ios/rxswift-examples-3-networking/). Networking, Moya, request chaining, optional observers and more!
4. [RxSwift by Examples #4 - Multithreading](http://www.thedroidsonroids.com/blog/ios/rxswift-examples-4-multithreading/) - `observeOn()`, `subscribeOn()`, `Driver` and more!

## Utilites

1. [NSObject-Rx](https://github.com/RxSwiftCommunity/NSObject-Rx) - Handy RxSwift extensions on NSObject, including `rx_disposeBag`.
2. [ObservableArray-RxSwift](https://github.com/safx/ObservableArray-RxSwift) - ObservableArray is an array that can emit messages of elements and diffs on it's changing.
3. [Cell+Rx](https://github.com/ivanbruel/Cell-Rx) - Handy RxSwift extensions on UITableViewCell and UICollectionViewCell, including rx_reusableDisposeBag.
3. [RxOptional](https://github.com/RxSwiftCommunity/RxOptional) - RxSwift extentions for Swift optionals and "Occupiable" types.
4. [RxExt](https://github.com/RxSwiftCommunity/RxSwift-Ext) - Additional operators not found in the core RxSwift distribution.

## Extensions to built-in frameworks
1. [RxDataSources](https://github.com/RxSwiftCommunity/RxDataSources) - Table and Collection View Data Sources for RxSwift. [Example](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxDataSourcesExample)
2. [RxBluetooth](https://github.com/SideEffects-xyz/RxBluetooth) - RxBluetooth is a wrapper library to work with RxSwift and CoreBluetooth.
3. [RxSegue](https://github.com/RxSwiftCommunity/RxSegue) - Reactive generic segue, implemented with RxSwift.
4. [RxEasing](https://github.com/lintmachine/RxEasing) - RxSwift-based easing library.
5. [RxAction](https://github.com/RxSwiftCommunity/Action) - Abstracts actions to be performed in RxSwift. [Example](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxActionExample)
6. [RxWebKit](https://github.com/RxSwiftCommunity/RxWebKit) - RxWebKit is a RxSwift wrapper for WebKit. [Example](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxWebKitExample)
7. [RxMKMapView](https://github.com/RxSwiftCommunity/RxMKMapView) - RxMKMapView is a RxSwift wrapper for MKMapView `delegate`. [Example](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxMKMapViewExample)
8. [RxMediaPicker](https://github.com/RxSwiftCommunity/RxMediaPicker) - A reactive wrapper built around UIImagePickerController.
9. [RxViewModel](https://github.com/RxSwiftCommunity/RxViewModel) - ReactiveViewModel-esque using RxSwift.
10. [RxGesture](https://github.com/RxSwiftCommunity/RxGesture) - RxSwfit reactive wrapper for view gestures.
11. [RxAppState](https://github.com/pixeldock/RxAppState) - RxSwift extensions for UIApplicationDelegate methods to observe changes in your app's state.
12. [RxBluetoothKit](https://github.com/Polidea/RxBluetoothKit) - iOS Bluetooth library for RxSwift.
13. [RxMultipeer](https://github.com/RxSwiftCommunity/RxMultipeer) - RxSwift wrapper for MultipeerConnectivity.

## Extensions to external frameworks
1. [RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) - RxSwift wrapper around the elegant HTTP networking in Swift Alamofire. [Example](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxAlamofireExample)
2. [RxRealm](https://github.com/RxSwiftCommunity/RxRealm) - Rx wrapper for Realm's collection types.
3. [RxNimble](https://github.com/RxSwiftCommunity/RxNimble) - Nimble extensions that making unit testing with RxSwift easier.
4. [RxQueryKit](https://github.com/QueryKit/RxQueryKit) - RxSwift extensions for dealing with QueryKit.
5. [FirebaseRxSwiftExtensions](https://github.com/mbalex99/FirebaseRxSwiftExtensions) - Extension Methods for Firebase and RxSwift.
6. [ReduxKitRxSwift](https://github.com/ReduxKit/ReduxKitRxSwift) - RxSwift bindings for ReduxKit.
7. [RxHyperdrive](https://github.com/kylef/RxHyperdrive) - RxSwift extensions for Hyperdrive, the generic Swift Web API client.
8. [RxBrightFutures](https://github.com/SideEffects-xyz/RxBrightFutures) - RxSwift wrapper around the Future/Promise library BrightFutures.
9. [RxMoya](https://github.com/Moya/Moya/blob/master/docs/RxSwift.md) - RxSwift wrapper for Moya. [Example](https://github.com/DroidsOnRoids/RxSwiftExamples/tree/master/Libraries%20Usage/RxMoyaExample)
10. [RxSimpleNoSQL](https://github.com/xmartlabs/RxSimpleNoSQL/) - Reactive extensions for SimpleNoSQL.
11. [RxPermission](https://github.com/sunshinejr/RxPermission) - RxSwift bindings for Permissions API in iOS.

## Examples

1. [RxChat](https://github.com/bontoJR/RxChat) - Chat application also using RxSwift.
2. [RxPagination](https://github.com/tryswift/RxPagination) - Really nice demo for "Protocol-Oriented Programming in Networking", using RxSwift.
3. [RxTestScheduler](https://github.com/kumapo/RxSwiftTestSchedulerExample) - Example of how you can use RxSwift's `TestScheduler`. Unfortunately comments are not in English 😥
4. [RxGitHubAPI](https://github.com/FengDeng/RxGitHubAPI) - GitHub API example. Unfortunately comments are not in English 😥
5. [Parse-RxSwift](https://github.com/bluelinelabs/Parse-RxSwift) - A collection of wrapper classes that allow you to use RxSwift Observers in place of Parse's callbacks.
6. [RxSwiftGram](https://github.com/Dwar3xwar/RxSwiftGram) - Educational App using RxSwift and MVVM with the Instagram API.

## Applications

1. [Eidolon](https://github.com/artsy/eidolon) - The Artsy Auction Kiosk App.
2. [Boilerplate](https://github.com/tailec/boilerplate#github-api-client) - GitHub client using MVVM and RxSwift.
3. [ReactiveWeatherExample](https://github.com/marinbenc/ReactiveWeatherExample) - A simple iOS weather app using the MVVM pattern and RxSwift framework.
4. [RxMarbles](https://github.com/RxSwiftCommunity/RxMarbles) - RxMarbles iOS app.
5. [CountItApp](https://github.com/PiXeL16/CountItApp) - Dead simple App with Apple Watch integration that lets you count anything.
6. [WhatFilm](https://github.com/brocoo/WhatFilm) - Simple iOS app showing popular films, their cast and crew along with images and links to the trailers.

## More

1. [RxSnippets](https://github.com/RxSwiftCommunity/RxSnippets) - Several snippets for work with RxSwift
2. [RxSugar](https://github.com/RxSugar/RxSugar) - Simple RxSwift extensions for interacting with Apple APIs.
3. [ReactiveCommander](https://github.com/pepibumur/ReactiveCommander) - Reactive Command pattern. This one is for RxSwift as well as for ReactiveCocoa.
4. [CollectionVariable](https://github.com/gitdoapp/CollectionVariable) - RxSwift Variable for collections that report individual changes in the collection.
5. [RxTwift](https://github.com/mihyaeru21/RxTwift) - A type safe Twitter API client constructed on RxSwift.

## Contributing
Feel free to make issues/pull requests if you find something wrong in examples or readme, as well as you can add things you would want to see or you know that are written in RxSwift. Let's make our lives better and help each other!

## Author

Sunshinejr, thesunshinejr@gmail.com, <a href="https://twitter.com/thesunshinejr">@thesunshinejr</a>

## License

RxSwiftExamples is available under the MIT license. See the LICENSE file for more info.
