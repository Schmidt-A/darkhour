#include "aw_include"
void main()
{
object oItem = GetItemActivated();
object oTarget = GetItemActivatedTarget();
object oPC = GetItemActivator();
if (!GetIsAdmin(oPC ))
    {
    FloatingTextStringOnCreature("You cannot use this item!",oPC);
        return;
    }

else  {
       SetPlotFlag(oTarget,FALSE);
       DestroyObject(oTarget);
       PlaySound("it_materialhard");
       FloatingTextStringOnCreature(GetName(oTarget)+ " has been destroyed!",oPC);
       }
}
