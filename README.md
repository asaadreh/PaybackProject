# PaybackProject
Assessment for payback

## Set up

To start the project, open terminal, go to the project directory and run:

- pod install

Then open Payback_Project.xcworkspace

## Rationale behind Decisions

### Programmatic UI

I understand that I will be working in a team so the decision of choosing programmatic UI over storyboards was taken. This way, any changes in UI will be easily detected by the entire team.

### MVVM

MVVM architecture pattern was chose because 4 different types of data have to be shown in a single tableview. All the data is cast into a FeedViewModelItem and then displayed in the tableview. This way, if any new data is to be added to the tableview, it needs to conform to FeedViewModelItem and then added to the items array. it can be achieved with minimal code.

### Coordinator

While not completely necessary, the Coordinator class handles the navigation of the app. This way, the view controllers do not have to worry about navigation and they can focus on the single responsibility of lifecycle management


### Chain Of Responsibility

In order to fulfil the requirement of making only one API call per day, the Chain of Responsibility pattern has been used which first tries the API, then checks the cache and then check Persistent memory.

### Persistence Layer

UserDefaults was used instead of CoreData because the amount of data to be stored was very less. If CoreData is to be implemented, it has to conform to the FeedServiceProtocol and can be integrated with very little code.

### URLs (data attribute) in items

The data is downloaded and then stored in the ViewModelItem object. This makes the scrolling very smooth which was otherwise a little laggy. If persistence is required, a similar approach to caching/persisting the feed can be used for caching the items.


### 3rd Party Pods

While image download could've been done natively as well, a popular and well maintained 3rd party SDK called KingFisher was used to handle downloads and caching of Images in order to demonstrate usage of cocoapods.


### TODOs, Known Issues and Improvements

- To make UI components, factories for Labels, stackviews could also be used
- The data link returned for video attribute by the API is unsafe and isn't played and the following error is thrown: 

"The certificate for this server is invalid. You might be connecting to a server that is pretending to be “www.sample-videos.com” which could put your confidential information at risk." UserInfo={NSLocalizedRecoverySuggestion=Would you like to connect to the server anyway?, _kCFStreamErrorDomainKey=3, NSErrorPeerCertificateChainKey"
    
    
However when replaced with a different link, the app works just fine. NSArbitraryLoads have been allowed in info.plist
     
-  Similarly, LinkPresentation also throws som warnings but according to the following post on Apple Developer Forums: https://developer.apple.com/forums/thread/112095, an apple dev claims that they aren't something we should worry about. The working of the app is completely fine though. To silence these warnings, OS_ACTIVITY_MODE  is set to disable. It can be enabled again in Edit Scheme.
    

