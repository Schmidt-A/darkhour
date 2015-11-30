//Rod of Wings Script
void main()
{
object oTarget = GetItemActivatedTarget();
SetCreatureWingType(CREATURE_WING_TYPE_NONE,oTarget);
int nCycleWings = GetLocalInt(oTarget,"WingType")+1;
SetLocalInt(oTarget,"WingType",nCycleWings);
if(nCycleWings == 1)
SetCreatureWingType(CREATURE_WING_TYPE_DEMON,oTarget);
else if(nCycleWings == 2)
SetCreatureWingType(CREATURE_WING_TYPE_ANGEL,oTarget);
else if(nCycleWings == 3)
SetCreatureWingType(CREATURE_WING_TYPE_BAT,oTarget);
else if(nCycleWings == 4)
SetCreatureWingType(CREATURE_WING_TYPE_DRAGON,oTarget);
else if(nCycleWings == 5)
SetCreatureWingType(CREATURE_WING_TYPE_BUTTERFLY,oTarget);
else if(nCycleWings == 6)
SetCreatureWingType(CREATURE_WING_TYPE_BIRD,oTarget);
else if(nCycleWings == 7)
    {
    SetCreatureWingType(CREATURE_WING_TYPE_NONE,oTarget);
    SetLocalInt(oTarget,"WingType",0);
    }
}
