Geogame documentation
=====================

UML schema
----------

![UML schema image](http://yuml.me/a2eac8a1)  

**This is the current script of the previous UML chart :**

Go to [YUML website](http://yuml.me/edit/a2eac8a1) to generate to update this schema.

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
