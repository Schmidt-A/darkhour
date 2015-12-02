//called from the spirit stone to give powerups
//4 monster-specific, 4 hunter-specific, 4 every1

void All1(object oPC);
void All1(object oPC)
{
    FloatingTextStringOnCreature("All1 works.", oPC);
}
void All2(object oPC);
void All2(object oPC)
{
    FloatingTextStringOnCreature("All2 works.", oPC);
}
void All3(object oPC);
void All3(object oPC)
{
    FloatingTextStringOnCreature("All3 works.", oPC);
}
void All4(object oPC);
void All4(object oPC)
{
    FloatingTextStringOnCreature("All4 works.", oPC);
}
void Hunter1(object oPC);
void Hunter1(object oPC)
{
    FloatingTextStringOnCreature("Hunter1 works.", oPC);
}
void Hunter2(object oPC);
void Hunter2(object oPC)
{
    FloatingTextStringOnCreature("Hunter2 works.", oPC);
}
void Hunter3(object oPC);
void Hunter3(object oPC)
{
    FloatingTextStringOnCreature("Hunter3 works.", oPC);
}
void Hunter4(object oPC);
void Hunter4(object oPC)
{
    FloatingTextStringOnCreature("Hunter4 works.", oPC);
}
void Monster1(object oPC);
void Monster1(object oPC)
{
    FloatingTextStringOnCreature("Monster1 works.", oPC);
}
void Monster2(object oPC);
void Monster2(object oPC)
{
    FloatingTextStringOnCreature("Monster2 works.", oPC);
}
void Monster3(object oPC);
void Monster3(object oPC)
{
    FloatingTextStringOnCreature("Monster3 works.", oPC);
}
void Monster4(object oPC);
void Monster4(object oPC)
{
    FloatingTextStringOnCreature("Monster4 works.", oPC);
}

void main()
{

object oPC = GetLastUsedBy();
int nDecharged = GetLocalInt(OBJECT_SELF, "Decharged");
int nH = GetLocalInt(oPC, "Hunter");
int nL = GetLocalInt(oPC, "LegendHunter");
int nHL = nH + nL;
int nM = GetLocalInt(oPC, "Monster");
if (nDecharged != 1)
{

    if (nHL >= 1)
    {
        int nChance = d8(1);
        switch (nChance)
        {
            case 1:
            {
                All1(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 2:
            {
                All2(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 3:
            {
                All3(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 4:
            {
                All4(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 5:
            {
                Hunter1(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 6:
            {
                Hunter2(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 7:
            {
                Hunter3(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 8:
            {
                Hunter4(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
        }

    }
    else if (nM >= 1)
    {
        int nChance = d8(1);
        switch (nChance)
        {
            case 1:
            {
                All1(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 2:
            {
                All2(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 3:
            {
                All3(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 4:
            {
                All4(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 5:
            {
                Monster1(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 6:
            {
                Monster2(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 7:
            {
                Monster3(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
            case 8:
            {
                Monster4(oPC);
                SetLocalInt(OBJECT_SELF, "Decharged", 1);
                AssignCommand(OBJECT_SELF, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                break;
            }
        }
    }
}

}
