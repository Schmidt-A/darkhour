void main()
{
object oItem = GetFirstItemInInventory();
if(GetLocalInt(OBJECT_SELF, "sf_poofed") != 1)
    {
    while(oItem != OBJECT_INVALID)
        {
            DestroyObject(oItem);
            oItem = GetNextItemInInventory();
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SUNSTRIKE), OBJECT_SELF);
        SetLocalInt(OBJECT_SELF, "sf_poofed", 1);
        DelayCommand(6.0, SetLocalInt(OBJECT_SELF, "sf_poofed", 0));
    }
}
