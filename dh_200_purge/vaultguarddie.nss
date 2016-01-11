void main()
{
FloatingTextStringOnCreature("A nearby door is heard unlatching.", OBJECT_SELF, FALSE);
object oDoor = GetNearestObjectByTag("VaultDoorLvl3");
if(GetDistanceToObject(oDoor) > 0.0)
    {
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_BEAM_EVIL), oDoor, 5.0);
    SetLocked(oDoor, FALSE);
    DelayCommand(1200.0, SetLocked(oDoor, TRUE));
    DelayCommand(1200.0, AssignCommand(oDoor, ActionPlayAnimation(ANIMATION_DOOR_CLOSE)));
    }
}
