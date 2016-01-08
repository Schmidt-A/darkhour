//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set appearance to the selected invisible model
    (with no glow) and set tail to the previous
    appearance if applicable
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
int nApp = GetAppearanceType(oTarget);
int nTail = GetCreatureTailType(oTarget);
int nScale = GetLocalInt(OBJECT_SELF, "CW_Scale");

SetCreatureAppearanceType(oTarget, nScale+2047);
TokenList();

if(nTail <= 14 ||
   Get2DAString("tailmodel", "MODEL", nTail) == "")
    {
    DelayCommand(1.0, SetCreatureTailType(AppToTail(nApp), oTarget));
    }
}
