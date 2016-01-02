//--------------------------------------------------------------------------
//  Dark Hour spell hook. Includes Blood magic item logic -Aez
//
//------------------------------------------------------------------------------
#include "_incl_bloodmagic"
#include "x2_inc_switches"


void main()
{
    object oCaster = OBJECT_SELF;
    object oCastItem = GetSpellCastItem();
    if (GetIsPC(oCaster) && GetIsObjectValid(oCastItem) && GetTag(oCastItem) == "BloodMagicBook")
    {
        int iCastClass = GetLastSpellCastClass();
        int iCastLevel = GetCasterLevel(oCaster);

        BloodMagic(oCaster, iCastClass, oCastItem, iCastLevel);
    }
}
