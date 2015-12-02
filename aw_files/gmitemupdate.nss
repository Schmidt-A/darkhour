#include "inc_bs_module"
#include "aw_include"
void main()
{
object oUser = GetPCSpeaker();
string sName = GetPCPlayerName(oUser);
if (GetIsDM(oUser) || GetIsGMNormalChar(oUser) || GetIsGM(oUser))
    {
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "TheOneRod")) )
        {
           object oSpawn = CreateItemOnObject("theonerod", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "TheOneRod"), 0.0);
           object oSpawn = CreateItemOnObject("theonerod", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "teamchangewand")) )
        {
           object oSpawn = CreateItemOnObject("gmteambalanceite", oUser,1);
         }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "teamchangewand"), 0.0);
           object oSpawn = CreateItemOnObject("gmteambalanceite", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "banplayer")) )
        {
           object oSpawn = CreateItemOnObject("banplayer001", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "banplayer"), 0.0);
           object oSpawn = CreateItemOnObject("banplayer001", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "deletechar")) )
        {
           object oSpawn = CreateItemOnObject("deletechar", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "deletechar"), 0.0);
           object oSpawn = CreateItemOnObject("deletechar", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "boot_player")) )
        {
           object oSpawn = CreateItemOnObject("boot_player", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "boot_player"), 0.0);
           object oSpawn = CreateItemOnObject("boot_player", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "jailplayeranme")) )
        {
           object oSpawn = CreateItemOnObject("jailplayeranme", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "jailplayeranme"), 0.0);
           object oSpawn = CreateItemOnObject("jailplayeranme", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "jailplayer")) )
        {
           object oSpawn = CreateItemOnObject("jailplayer", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "jailplayer"), 0.0);
           object oSpawn = CreateItemOnObject("jailplayer", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "freezeunfreeze")) )
        {
           object oSpawn = CreateItemOnObject("freezeunfreeze", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "freezeunfreeze"), 0.0);
           object oSpawn = CreateItemOnObject("freezeunfreeze", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "jumpusback")) )
        {
           object oSpawn = CreateItemOnObject("jumpusback", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "jumpusback"), 0.0);
           object oSpawn = CreateItemOnObject("jumpusback", oUser,1);
        }
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "delete_bio")) )
        {
           object oSpawn = CreateItemOnObject("delete_bio", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "delete_bio"), 0.0);
           object oSpawn = CreateItemOnObject("delete_bio", oUser,1);
        }
         if(!GetIsObjectValid(GetItemPossessedBy(oUser, "kill_npc")) )
        {
           object oSpawn = CreateItemOnObject("kill_npc", oUser,1);
        }
        else
        {
           DestroyObject(GetItemPossessedBy(oUser, "kill_npc"), 0.0);
           object oSpawn = CreateItemOnObject("kill_npc", oUser,1);
        }
         if(!GetIsObjectValid(GetItemPossessedBy(oUser, "balance_teams")) )
        {
           object oSpawn = CreateItemOnObject("balance_teams", oUser,1);
        }


   FloatingTextStringOnCreature("The Gods Favor you...", oUser, FALSE);
   }
   else
   {
   FloatingTextStringOnCreature("The Gods cannot Favor you...if you are a GM contact the Admins", oUser, FALSE);
   }
}
