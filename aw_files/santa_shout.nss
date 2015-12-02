void main()
{
object santa = GetObjectByTag("santaclaus");
int nHour = GetTimeHour();
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
if (GetLocalInt(santa,"santa_shout") == 1) //DM Activate / Deactivate
   {
   SetLocalInt(santa,"santa_shout",0);
   FloatingTextStringOnCreature ("Santa Shout Disabled",GetLastUsedBy(),FALSE);
   }
else if (GetLocalInt(santa,"santa_shout") == 0)
    {
   SetLocalInt(santa,"santa_shout",1);
   SetLocalInt(santa, "LastShout", nHour);
   FloatingTextStringOnCreature ("Santa Shout Enabled",GetLastUsedBy(),FALSE);
   }
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
 // check this one too...:D//
}
