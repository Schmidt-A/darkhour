#include "aw_include"
void main()
{
object oItem = GetItemActivated();
object oTarget = GetItemActivatedTarget();
object oPC = GetItemActivator();
if (!GetIsAdmin(oPC ) || GetTag(oTarget) != "itemsremoved")
    {
    FloatingTextStringOnCreature("You cannot use this item or you selected not a rag!",oPC);
        return;
    }

else  {
       int nStartingValue = GetLocalInt(oTarget,"char_checks");
       FloatingTextStringOnCreature( "Your Rag check was: "+ IntToString(nStartingValue),oPC);
       SetLocalInt(oTarget,"char_checks",nStartingValue-1);
       PlaySound("sce_positive");
       FloatingTextStringOnCreature( "Your Rag check is now set to: "+ IntToString(GetLocalInt(oTarget,"char_checks")),oPC);
       }
}
