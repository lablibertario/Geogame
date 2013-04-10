Geogame documentation
=====================

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
