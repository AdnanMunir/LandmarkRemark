# LandmarkRemark



App Approach : 

1. App is built using MVVM-C , Singleton , Protocols , Coordinators, CocoaPods(Only Firebase used as was described in requirement)
2. Modules Folder contains all ViewControllers,ViewModels,Views,Storyboards for specific screens . Currently There are 2 modules :
    (i) Authentication Module -> contains Login, Signup screens
    (ii) Map Module -> contains Map, Note View, Note table search screens
3. App Forced to use Light Mode for iOS 13
4. Unit Tests added

Implicit Requirements : 

1. User should be able to Sign up using Email,Username,Password to identify - Completed
2. User should be able to Login using Email,Password - Completed
3. Button -User should be able to focus himself on map if anywhere displaced on the map - Completed
4. Button -User should be able to refresh map - Completed
5. Clicking on Notes after searching it takes to specific note location on the map - Completed
6. Refresh Map/Notes After every1 kilometre of the user location update to get new notes. -  Completed

Explicit Requirements : 

    1.    As a user (of the application) I can see my current location on a map - Completed
    2.    As a user I can save a short note at my current location - Completed
    3.    As a user I can see notes that I have saved at the location they were saved on the map - Completed
    4.    As a user I can see the location, text, and user-name of notes other users have saved - Completed
    5.    As a user I have the ability to search for a note based on contained text or user-name - Completed 
Man Hours : 

1. 20 Hours (Mostly Refining implicit requirements)

App Limitations : 

1. Notes on the map should appear range wise i.e : Get all notes in 3 Km of user location. Currently range queries do not work directly in firestore. Need External Pods to use them which is currently not implemented.
