//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set local int to the male gender of the
    selected invisible appearance
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////

void main()
{
int nScale = GetLocalInt(OBJECT_SELF, "CW_Scale");

SetLocalInt(OBJECT_SELF, "CW_Scale", nScale+120);
}
