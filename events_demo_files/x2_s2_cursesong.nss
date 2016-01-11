//::///////////////////////////////////////////////
//:: Curse Song
//:: X2_S2_CurseSong
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spells applies penalties to all of the
    bard's enemies within 30ft for a set duration of
    10 rounds.
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: May 16, 2003
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs May 20, 2003

/*
Updated Dec 2015 for Dark Hour by Tweek.
- removed <= level 8 options;
- duration increased;
- buffs dependent on feats.
*/
#include "_incl_bard"

void main()
{
    DoCurseSong(TRUE);
}
