Geogame documentation
=====================

UML schema
----------

![UML schema image](http://yuml.mea2eac8a1.jpg)

This is the current script of the previous UML chart : 
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
