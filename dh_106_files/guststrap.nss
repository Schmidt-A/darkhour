void main()
{
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
int iReady = GetLocalInt(OBJECT_SELF, "isready");
if(iReady == 0)
    {
    AssignCommand(GetNearestObjectByTag("StatueTrap1"), ActionCastSpellAtObject(SPELL_GUST_OF_WIND, GetWaypointByTag("gusttrap1"), METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    AssignCommand(GetNearestObjectByTag("StatueTrap3"), ActionCastSpellAtObject(SPELL_GUST_OF_WIND, GetWaypointByTag("gusttrap2"), METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    AssignCommand(GetNearestObjectByTag("StatueTrap5"), ActionCastSpellAtObject(SPELL_GUST_OF_WIND, GetWaypointByTag("gusttrap3"), METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
    SetLocalInt(OBJECT_SELF, "isready", 1);
    DelayCommand(30.0, SetLocalInt(OBJECT_SELF, "isready", 0));
    DelayCommand(30.0, FloatingTextStringOnCreature("The Gusts trap is now ready.", GetLastUsedBy()));
    FloatingTextStringOnCreature("Gusts of wind have been released at map points 3, 4, and 5.", GetLastUsedBy());
    }else if(iReady == 1)
        {
        FloatingTextStringOnCreature("This trap is not yet ready.", GetLastUsedBy());
        }
}
