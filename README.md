# Flickr SwiftUI

###### API

The following Flickr API is used to populate the application ```https://api.flickr.com/services/feeds/photos_public.gne?tags=gardenning&tagmode=any&format=json&nojsoncallback=1``` At the time of implementation the correct endpoint could not be found.

###### MVVM

 The Architectural choice was made to use MVVM, since it includes better encapsulation and more flexible view and model.

 ###### SwiftUI

 To create the graphical user interface functionality, SwiftUI is used, as this reduces the development time when compared to using Swift with Auto layout and Storyboards etc. Using SwiftUI provides a declarative programming that makes it easier to share information within the app.

 ###### ASYNC & AWAIT

 For concurrency, instead of using closure or completion handler, Async and Await is used for background tasks and to route information around the app.  Using Async and Await, abandons the need for having completion: @escaping in the function signature and makes all calls to completion (...) obsolete.

###### Swift

 To create the business logic Swift is used in the following files:

     * Models
     * Services
     * View Model
