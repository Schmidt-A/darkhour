//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set the target's alignment as a conversation
    token
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
string sAlign;

switch(GetAlignmentLawChaos(oTarget))
    {
    case ALIGNMENT_CHAOTIC:
        sAlign = "Chaotic";
        break;
    case ALIGNMENT_LAWFUL:
        sAlign = "Lawful";
        break;
    default:
        sAlign = "Neutral";
        break;
    }

switch(GetAlignmentGoodEvil(oTarget))
    {
    case ALIGNMENT_EVIL:
        sAlign = sAlign+" Evil";
        break;
    case ALIGNMENT_GOOD:
        sAlign = sAlign+" Good";
        break;
    default:
        sAlign = sAlign+" Neutral";
        break;
    }

if(sAlign == "Neutral Neutral")
    {
    sAlign = "True Neutral";
    }

SetCustomToken(307, sAlign);
}
