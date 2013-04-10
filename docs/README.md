Geogame documentation
=====================

UML schema
----------

![UML schema image](http://yuml.me/a2eac8a1)  

**This is the current script of the previous UML chart :**

Go to [YUML website](http://yuml.me/edit/a2eac8a1) to update this schema.

    [User]*-*[UserComment]
    [User]*-*[UserPicture]
    [User]*-*[UserQuiz]
    [UserQuiz]*-*[Quiz]
    [Quiz]1-1[Waypoint]
    [UserComment]*-*[Waypoint]
    [UserPicture]*-*[Waypoint]
    [Waypoint]*-*[WaypointCategory]
    [Category]*-*[WaypointCategory]
    [Tag]*-*[WaypointTag]
    [WaypointTag]*-*[Waypoint]
    [PFUSer]^-[User]

Inside User object
------------------

The User object is based on a PFUser (see the Parse Framework documentation to get more details).
So, when you launch the app, you have to test if the user is logged in then load its content.

You need to reed the specific documentation (iOS or Android to get source code implementation).

However, the syntax is the save :

* Check user auth
* Load user's profile (it is the _User class on Parse Cloud) in background
* Load user's comments (it is the UserComment class on Parse Cloud) in background.
* Load user's activity / pictures and more.

Keep in mind you have to implement listeners / observers to refresh views when the model is updated.
