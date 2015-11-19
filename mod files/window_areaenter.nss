// Zombie Window Break-In System
// Place OnEnter of area

// This script will increase the player count for the area the PC enters.

// Created by Zunath on July 29, 2007

void main()
{
    object oPC = GetEnteringObject();
    int iCurrentPlayersInArea = GetLocalInt(OBJECT_SELF, "PCInArea");

    // If it's not a PC, just quit
    if(!GetIsPC(oPC)) {return;}

    // Otherwise increase the player count
    iCurrentPlayersInArea = iCurrentPlayersInArea + 1;
    // Now update the area with the new player count
    SetLocalInt(OBJECT_SELF, "PCInArea", iCurrentPlayersInArea);
}
