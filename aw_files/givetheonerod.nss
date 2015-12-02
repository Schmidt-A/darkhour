#include"inc_bs_module"
#include "aw_include"
void main()
{
object oUser = GetPCSpeaker();
string sName = GetPCPlayerName(oUser);
if (GetIsGMNormalChar(oUser))
    {


    if(GetIsObjectValid(GetItemPossessedBy(oUser, "TheOneRod")) != TRUE)
        {
        object oSpawn = CreateItemOnObject("theonerod", oUser,1);
        }
    if(GetIsObjectValid(GetItemPossessedBy(oUser, "teamchangewand")) != TRUE)
        {
        object oSpawn = CreateItemOnObject("gmteambalanceite", oUser,1);
         }
if (sName == "ENIRO")
  {
  int oldXP = GetXP(oUser);
    SetXP(oUser, oldXP + 10000);
    GiveGoldToCreature(oUser, 10000);
          }
   FloatingTextStringOnCreature("The Gods Favor you...", oUser, FALSE);
   }
else {
FloatingTextStringOnCreature("The Gods cannot Favor you...", oUser, FALSE);
}
}
