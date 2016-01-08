//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set vfx to be changed
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////

void main()
{
SetLocalInt(OBJECT_SELF, "CW_VFX", 0);
SetLocalString(OBJECT_SELF, "CW_Change", "vfx");
ExecuteScript("zep_cw_con_tlist", OBJECT_SELF);
}
