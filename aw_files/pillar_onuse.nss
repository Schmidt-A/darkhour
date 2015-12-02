 #include "aps_include"
void main()
{
 object oPC = GetLastUsedBy();
    if (GetLocalInt(oPC,"PillarInUse") == 1)
    {
        return;
    }

    SetLocalInt(oPC,"PillarInUse",1);
    int nPart = GetLocalInt(OBJECT_SELF,"MODPART");
    int nType = GetLocalInt(OBJECT_SELF,"MODTYPE");


ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), oPC, 1.5);

    if (nPart == 1)
     {
       SetCreatureWingType(nType, oPC);
       /*
       switch  (nType)    {
          case 0: SetCreatureWingType(CREATURE_WING_TYPE_NONE, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_NONE value is "+IntToString(CREATURE_WING_TYPE_NONE),oPC);
                  break;
          case 1: SetCreatureWingType(CREATURE_WING_TYPE_DEMON, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_DEMON value is "+IntToString(CREATURE_WING_TYPE_DEMON),oPC);
                  break;
          case 2: SetCreatureWingType(CREATURE_WING_TYPE_ANGEL, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_ANGEL value is "+IntToString(CREATURE_WING_TYPE_ANGEL),oPC);
                  break;
          case 3: SetCreatureWingType(CREATURE_WING_TYPE_BAT, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_BAT value is "+IntToString(CREATURE_WING_TYPE_BAT),oPC);
                  break;
          case 4: SetCreatureWingType(CREATURE_WING_TYPE_DRAGON, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_DRAGON value is "+IntToString(CREATURE_WING_TYPE_DRAGON),oPC);
                 break;
          case 5: SetCreatureWingType(CREATURE_WING_TYPE_BUTTERFLY, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_BUTTERFLY value is "+IntToString(CREATURE_WING_TYPE_BUTTERFLY),oPC);
                  break;
          case 6: SetCreatureWingType(CREATURE_WING_TYPE_BIRD, oPC);
                  FloatingTextStringOnCreature("CREATURE_WING_TYPE_BIRD value is "+IntToString(CREATURE_WING_TYPE_BIRD),oPC);
                  break;
             }  */
    }

else if (nPart == 0)
     {
     SetCreatureTailType(nType, oPC);
           /*
       switch  (nType)    {
          case 0: SetCreatureTailType(CREATURE_TAIL_TYPE_NONE, oPC);
                  FloatingTextStringOnCreature("CREATURE_TAIL_TYPE_NONE value is "+IntToString(CREATURE_TAIL_TYPE_NONE),oPC);
                  break;
          case 1: SetCreatureTailType(CREATURE_TAIL_TYPE_LIZARD, oPC);
                  FloatingTextStringOnCreature("CREATURE_TAIL_TYPE_LIZARD value is "+IntToString(CREATURE_TAIL_TYPE_LIZARD),oPC);
                  break;
          case 2: SetCreatureTailType(CREATURE_TAIL_TYPE_BONE, oPC);
                  FloatingTextStringOnCreature("CREATURE_TAIL_TYPE_BONE value is "+IntToString(CREATURE_TAIL_TYPE_BONE),oPC);
                  break;
          case 3: SetCreatureTailType(CREATURE_TAIL_TYPE_DEVIL, oPC);
                  FloatingTextStringOnCreature("CREATURE_TAIL_TYPE_DEVIL value is "+IntToString(CREATURE_TAIL_TYPE_DEVIL),oPC);
                  break;
                      }*/
    }

   // SetBodyPart(oPC,nPart,nType);

    FloatingTextStringOnCreature("Setting "+IntToString(nPart)+" to "+IntToString(nType), oPC);

    // Antiworld Persistant wings////
    if (nPart == 1)SetPersistentInt(oPC,"WingsModel",nType,0,"Wings");
    if (nPart == 0)SetPersistentInt(oPC,"TailModel",nType,0,"Wings");


    DelayCommand(3.0,DeleteLocalInt(oPC,"PillarInUse"));
}
/*



 ////////////// pillar_onuse ////////// wingery pillars* /////////////
#include "bodypart_inc"
#include "aps_include"
void main()
{
    object oPC = GetLastUsedBy();
    if (GetLocalInt(oPC,"PillarInUse") == 1)
    {
        return;
    }

    SetLocalInt(oPC,"PillarInUse",1);
    int nModP = GetLocalInt(OBJECT_SELF,"MODPART");
    int nPart = nModP?NWNX_BODYPART_WING:NWNX_BODYPART_TAIL;
    int nType = GetLocalInt(OBJECT_SELF,"MODTYPE");

    SetBodyPart(oPC,nPart,nType);

    FloatingTextStringOnCreature("Setting "+IntToString(nPart)+" to "+IntToString(nType), oPC);

    // Antiworld Persistant wings////
    if (nPart == 29)SetPersistentInt(oPC,"WingsModel",nType,0,"Wings");
    if (nPart == 28)SetPersistentInt(oPC,"TailModel",nType,0,"Wings");

    // Need to sync the engine to the client otherwise effects
    // stack.  SetCreatureAppearanceType() can do this, but it
    // must be a change and not application of their current type.
    // Therefore we need a pair.  A delay of about 1.0 second seems
    // to be the safe minium between them.
    //  SetPersistentInt(oPC,"SantaJudgement",nValue,0,"christmas");
    //
    // Hide SetCreatureAppearanceType() effects with a flashy effect.
    // You can also do this with Cutscene Invisibility applied before
    // the first SCAT();
    int nApp = GetAppearanceType(oPC);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_STRIKE_HOLY), oPC, 1.5);
    SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WILL_O_WISP);
    DelayCommand(1.0,SetCreatureAppearanceType(oPC,nApp));
    DelayCommand(3.0,DeleteLocalInt(oPC,"PillarInUse"));
}

*/
