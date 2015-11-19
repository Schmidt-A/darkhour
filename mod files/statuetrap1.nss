void main()
{
object oPC = GetEnteringObject();
if(GetItemPossessedBy(oPC, "ViperKey") == OBJECT_INVALID)
    {
    object oStatueOne = GetNearestObjectByTag("StatueTrap1");
    object oStatueTwo = GetNearestObjectByTag("StatueTrap2");
    AssignCommand(oStatueOne, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oPC, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    AssignCommand(oStatueTwo, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, oPC, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    }else
        {
        SendMessageToPC(oPC, "The trap detected your key, and did not fire at you.");
        }
}
