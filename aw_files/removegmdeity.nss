void main()
{
object oDm = GetItemActivator();
object oPlayer = GetItemActivatedTarget() ;
object oItem = GetItemActivated();
if(GetIsDM(oDm))
         {
         SetDeity(oPlayer,"BannedFromGm");
         FloatingTextStringOnCreature(GetPCPlayerName(oPlayer)+" ["+GetName(oPlayer)+"] Removed from GameMaster.",oDm, FALSE);
         DelayCommand(15.0,BootPC(oPlayer));
         FloatingTextStringOnCreature("You are removed from GameMaster",oPlayer, FALSE);
         DelayCommand(3.0,FloatingTextStringOnCreature("You will be Booted and your character, deleted!" ,oPlayer, FALSE));
         }
else
   {
   FloatingTextStringOnCreature("Only Dm  can use this.",oDm, FALSE);
   DestroyObject(oItem);
   }
}
