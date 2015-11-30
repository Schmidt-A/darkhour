//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set color to be changed
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////
#include "zep_cw_inc"

void main()
{
struct CW2da data = Get2daData();
object oTarget = data.target;
int iTail = GetCreatureTailType(oTarget);
int iApp = GetAppearanceType(oTarget);
int iCheck = FALSE;

SetLocalString(OBJECT_SELF, "CW_Change", "color");

//If current appearance isn't an invisible model set to the default invisible model (838)
//Check BioWare range
if(iApp >= 569 &&
   iApp <= 868 )
    {
    iCheck = TRUE;
    }
//Check CEP range
else if(iApp >= 2600 &&
    iApp <= 2963)
    {
    iCheck = TRUE;
    }

if(iCheck == FALSE)
    {
    SetCreatureAppearanceType(oTarget, 838);
    }

//If current tail isn't a tintable model switch to the default tintable tail (4000)
if(iTail <= 3999 ||
   iTail >= 5000 )
    {
    SetCreatureTailType(4000, oTarget);
    FloatingTextStringOnCreature("Creature set to default tintable tail.", GetPCSpeaker(), FALSE);
    }
}
