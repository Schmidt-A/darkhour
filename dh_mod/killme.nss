void main()
{
int iKill = GetLocalInt(OBJECT_SELF, "killme");
iKill += 1;
SetLocalInt(OBJECT_SELF, "killme", iKill);
if(iKill == 2)
    {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(1000), OBJECT_SELF);
    }
}
