#include "x2_inc_switches"
void FindStuff(object oUser, int DC, object oFarm)
{
    if(GetIsSkillSuccessful(oUser,SKILL_SEARCH,DC))
    {
        int nIncrease = GetLocalInt(oFarm,"INCREASE");
        int nRand = d4(1);
        object oFood;
        if(nRand==1)
            oFood = CreateItemOnObject("dmxfarmfood1",oUser,1,"FoodRaw");
        else if(nRand==2)
            oFood = CreateItemOnObject("dmxfarmfood2",oUser,1,"FoodRaw");
        else if(nRand==3)
            oFood = CreateItemOnObject("dmxfarmfood3",oUser,1,"FoodRaw");
        else
            oFood = CreateItemOnObject("dmxfarmfood",oUser,1,"FoodRaw");

        FloatingTextStringOnCreature("You have harvested some "+GetName(oFood)+"!",oUser,FALSE);

        if(nIncrease>=4)
        {
        SetLocalInt(oFarm,"INCREASE",0);
        SetLocalInt(oFarm,"DC",DC+2);
        }
        else
            SetLocalInt(oFarm,"INCREASE",nIncrease+1);
    }
    else
        FloatingTextStringOnCreature("You find nothing...",oUser,FALSE);
}

void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oFarm = GetLocalObject(oPC,"FARMABLE");
    if(oFarm!=OBJECT_INVALID)
        {
            int nDC = GetLocalInt(oFarm,"DC");
            AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 5.0));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oPC,5.0);
            DelayCommand(5.0,FindStuff(oPC,nDC,oFarm));
        }
        }
}
