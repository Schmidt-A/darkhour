//::///////////////////////////////////////////////
//:: Dye Kit - Group 1
//:: dye_group1.nss
//:: Copyright (c) 2003 Jake E. Fitch
//:://////////////////////////////////////////////
/*
    Sets the color group to 1.
*/
//:://////////////////////////////////////////////
//:: Created By: Jake E. Fitch (Milambus Mandragon)
//:: Created On: Dec. 10, 2004
//:://////////////////////////////////////////////
void main()
{
    object oPC = GetPCSpeaker();

    SetLocalInt(oPC, "ColorGroup", 1);
}