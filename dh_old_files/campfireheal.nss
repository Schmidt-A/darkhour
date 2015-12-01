void main()
{
object oFire = OBJECT_SELF;
object oPC;
location lFire = GetLocation(oFire);
int iConMod, maxHP, curHP;
int iLoop = 0;
effect eHeal;

oPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lFire, TRUE, OBJECT_TYPE_CREATURE);
while(GetIsObjectValid(oPC) && iLoop < 25)
    {
    if(GetIsPC(oPC))
        {
        if(GetIsInCombat(oPC))
            {
            SendMessageToPC(oPC, "This campfire cannot aid you while you are in combat.");
            return;
            }
        maxHP = GetMaxHitPoints(oPC);
        curHP = GetCurrentHitPoints(oPC);
        if(maxHP > curHP)
            {
            iConMod = GetAbilityModifier(ABILITY_CONSTITUTION, oPC);
            if(iConMod < 0)
                {
                iConMod = 0;
                }
            eHeal = EffectHeal(iConMod + 1);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
            SendMessageToPC(oPC, "Relaxing in the warmth of the campfire soothes your wounds.");
            }
        }
        iLoop++;
        oPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lFire, TRUE, OBJECT_TYPE_CREATURE);
    }
}
