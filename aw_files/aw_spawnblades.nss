//////////////Created by Jantima with Jay ////////////
/////OnUse on a lever spawn some blades on the bridge (waypoint) /////////
#include "inc_bs_module"
void main()
{
//Declare major variables including Area of Effect Object
    object oPlayer = GetLastUsedBy();
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLBLADE);
    int nTeam = GetLocalInt(OBJECT_SELF,"Team");//read the vaule of the Team Variable on the lever.
    object oSpawn = GetObjectByTag("bladebarrier_"+IntToString(nTeam));
    location lTarget = GetLocation(oSpawn);   //the waypoint
    int nDuration = 2;     ///just a testing  duration
    //Create an instance of the AOE Object using the Apply Effect function

///NO SPAMM ///
if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
    {
    return;
    }
if (GetPlayerTeam(oPlayer) != nTeam )
  {
   return;
  }
else
   {
    if (GetLocalInt(OBJECT_SELF,"Activate") == 1)
       {
       SetLocalInt(OBJECT_SELF,"InUse",1);
       ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
       SetLocalInt(OBJECT_SELF,"Activate",0);
       //remove effect
       effect eAOEEffect = GetFirstEffect(oSpawn);
       while(GetIsEffectValid(eAOEEffect))
             {
             RemoveEffect(oSpawn, eAOEEffect);

             eAOEEffect = GetNextEffect(oSpawn);
             }
       DelayCommand(2.0,SetLocalInt(OBJECT_SELF,"InUse",0));
       }
    else
       {
       SetLocalInt(OBJECT_SELF,"InUse",1);
       ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
       SetLocalInt(OBJECT_SELF,"Activate",1);
       eAOE = SupernaturalEffect(eAOE);
       ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAOE, oSpawn);
       DelayCommand(2.0,SetLocalInt(OBJECT_SELF,"InUse",0));
       }
  }


}
