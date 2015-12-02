#include "inc_bs_module"
#include "aw_include"
void main()
{
   object oUser = GetItemActivator();
   object oTarget = GetItemActivatedTarget();

   if (GetIsGMNormalChar(oUser))
   {
            if (!GetIsPC(oTarget) && !GetPlotFlag(oTarget) && !GetIsPossessedFamiliar(oTarget) && (!GetIsPC(GetMaster(oTarget)) || ( GetTag(oTarget) == "Nightmare1" || GetTag(oTarget) == "Nightmare2" || GetTag(oTarget) == "horse002"  || GetTag(oTarget) == "horsy001")) )
            {
              DestroyObject(oTarget);
            }
            else
            {
                 FloatingTextStringOnCreature("This is a plot creature and/or it might be needed for the game.",oUser,FALSE);
            }
   }
   else
   {
       FloatingTextStringOnCreature("You cannot use this",oUser,FALSE);
       SetPlotFlag(OBJECT_SELF,FALSE);
       DestroyObject(OBJECT_SELF);
   }
}
