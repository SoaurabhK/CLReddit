# CLReddit

### Introduction
CLReddit is a Reddit clone for iOS with functionalities limited to post creation, upvote/downvote posts and sorting posts based on votes(descending) and title(ascending).

### Building and Running
To build and run this project open the CLReddit.xcodeproj file in Xcode 8.x and use the following - 
```bash
Build: Cmd + B or Product -> Build
  Run: Cmd + R or Product -> Run
```

### Supported Platforms
iOS 8.0 and later.

### Layers and Classes
This project uses Model, View, Controller and Store layers to segregate responsibility of different types/classes.

#### Model Includes
- **Post.swift**: Post is a Model class for creating objects of type Post.

#### View Includes
- **PostCell.swift**: PostCell is a subclass of UITableViewCell for configuring tableView's cell objects.
- **Main.storyboard**: Contains applications view components and manages their configuration and connections.
- **LaunchScreen.storyboard**: Contains a single viewController scene to manage the launch screen of the application. For this application default(white) screen is used.

#### Controller Includes
- **AppDelegate.swift**: Appdelegate is a subclass of UIResponder and confirms to UIApplicationDelegate, responsible for listening application lifecycle events/delegate_calls and allows developers to perform necessary actions for each such event.
- **PostsViewController.swift**: PostsViewController is a subclass of UITableViewController for configuring and managing the associated tableView i.e. initial view of the application.
- **AddViewController.swift**: AddViewController is a subclass of UIViewController for configuring and managing the associated UIView i.e. for adding Posts.

#### Store Includes
- **PostStore.swift**: PostStore class is an in-memory Store for holding all the Posts created by a user.

### CodeFlow
- On application launch, AppDelegate recieves a delegate message where PostStore is instantiated passed as a dependency to PostsViewController. During initialization, PostStore creates 20 instances of Post objects with random titles(fruit names) and keeps them in an in-memory dictionary. 
- PostsViewController is responsible for managing its associated tableView, creates and configures tableView cells of type PostCell. It also provides features to reloadTable, which reloads and sorts all the Posts. For creating new posts there is a add UIBarButtonItem which segues to AddViewController.
- AddViewController is responsible for creating new Posts and uses a UITextField to take users input. Users input is restricted to 255 character limit using a UITextFields delegate method. It also controls dismissing keyboard if the user touches anywhere on the screen or clicks return on keyboard. It has a Done UIBarButtonItem, which creates a new Post and pops out the current viewController i.e. AddViewController from the navigation stack.

### Assumptions
- Posts with same titles are allowed, because their author, content and other meta-info may be different.
- Posts with title having only space characters is allowed.
- Currently Post object has postID, title and votes instance properties. I can keep upvotes and downvotes separately but Reddit, Digg, Quora, Stack Overflow etc. all manages only single votes field.
- On upvote/downvote tableView only reloads the row on which action is performed to update the votes label. For complete reordering/reloading and sorting, press the Reload UIBarButtonItem.
- Not using NSCache in store as the Posts objects have a small memory footprint.

### References
- Knowledge reference - https://www.bignerdranch.com/books/ios-programming/
- TextField delegate reference - https://stackoverflow.com/questions/433337/set-the-maximum-character-length-of-a-uitextfield
