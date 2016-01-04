// Zombie Window Break-In System
// Place OnExit of area

// This script decreases the area's player count. It works a little differently
// because strangely enough, you can't get the PC object because they have already
// left. However, you are able to get local ints stored on them.
// It will check to see if the int "Is_PC" equals 1. If so, it will decrease the player
// count. Otherwise it will do nothing.

// Created by Zunath on July 29, 2007

void main()
{
    object oPC = GetExitingObject();
    int iIsPC = GetLocalInt(oPC, "Is_PC");
    int iCurrentPlayersInArea = GetLocalInt(OBJECT_SELF, "PCInArea");

    // If not a PC, just quit
    if (iIsPC == 0) {return;}

    // Decrease the player count
    iCurrentPlayersInArea = iCurrentPlayersInArea - 1;
    // Now update the area with the new player count
    SetLocalInt(OBJECT_SELF, "PCInArea", iCurrentPlayersInArea);

}
