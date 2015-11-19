// This script marks the entering player as a PC. If they are a DM, do nothing.
// Place on your module's OnClientEnter

// Created by Zunath on July 29, 2007

void main()
{
    object oPC = GetEnteringObject();

    // If it's a DM, quit here.
    if(!GetIsPC(oPC)) {return;}

    // Now mark them as a PC
    SetLocalInt(oPC, "Is_PC", 1);
}
