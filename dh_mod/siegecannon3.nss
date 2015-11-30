void main()
{
int iDisabled = GetLocalInt(GetModule(), "disablecannon3");
int iIsLoaded = GetLocalInt(OBJECT_SELF, "isloaded");
int iIsLoading = GetLocalInt(OBJECT_SELF, "isloading");
object oPC = GetLastUsedBy();
if(iDisabled == FALSE)
    {
    if(iIsLoaded == 1)
        {
        object oTarget = GetNearestObjectByTag("CustomCannonTarget3");
        SetLocalInt(OBJECT_SELF, "isloaded", 0);
        SpeakString("5");
        DelayCommand(1.0, SpeakString("4"));
        DelayCommand(2.0, SpeakString("3"));
        DelayCommand(3.0, SpeakString("2"));
        DelayCommand(4.0, SpeakString("1"));
        DelayCommand(5.0, AssignCommand(OBJECT_SELF, ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_EMPOWER, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        DelayCommand(6.0, AssignCommand(oTarget, ActionCastSpellAtObject(SPELL_SOUND_BURST, OBJECT_SELF, METAMAGIC_EMPOWER, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        }else if(iIsLoading == 0)
             {
             SetLocalInt(OBJECT_SELF, "startcount", -1);
             SetLocalInt(OBJECT_SELF, "isloading", 1);
             FloatingTextStringOnCreature("You begin to load the cannon.", oPC, FALSE);
             }else
                 {
                 SendMessageToPC(oPC, "The cannon is still loading.");
                 }
       }else
        {
        SendMessageToPC(oPC, "This cannon has been disabled.");
        }
}
