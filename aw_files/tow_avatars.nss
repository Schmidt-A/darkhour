// tow_avatars
// Scripted By: Demon X
// For: Antiworld
// This script is placed upon the Avatars OnDamaged event.
#include "inc_bs_module"


void DestroyAvatar(object oAvatar, object oPC)
{
if(GetTag(oAvatar) == "0")
    {RewardTugOfWar(TOW_AVATAR_CAPTURED,oPC,2, 100);
    SpeakString("<c¶)<>Evil<c¶¶<> has destroyed <c29±>Good<c¶¶<>'s Avatar!",TALKVOLUME_SHOUT);}
else if(GetTag(oAvatar) == "9")
    {RewardTugOfWar(TOW_AVATAR_CAPTURED,oPC,1, 100);
    SpeakString("<c29±>Good<c¶¶<> has destroyed <c¶)<>Evil<c¶¶<>'s Avatar!",TALKVOLUME_SHOUT);}

ResetTugOfWar(oAvatar);
}
void Warn(object oPC)
{
int nDelay = GetLocalInt(oPC,"WarnedLink");
if(nDelay != 1)
    {
    FloatingTextStringOnCreature("You cannot damage an unlinked Avatar!",oPC);
    SetLocalInt(oPC,"WarnedLink",1);
    DelayCommand(3.0,SetLocalInt(oPC,"WarnedLink",0));
    }
}
void DamageAvatar(object oPC)
{
int nAvatarHP = GetLocalInt(OBJECT_SELF,"AvatarHP");
int nTeam = GetLocalInt(oPC,"nTeam");
int nRepair;
string sAvatarHP;
if(nTeam == 1 && GetTag(OBJECT_SELF)=="0")
    nRepair = TRUE;
else if(nTeam == 2 && GetTag(OBJECT_SELF)=="9")
    nRepair = TRUE;
else
    nRepair = FALSE;

if(nRepair == TRUE && nAvatarHP != 500)
{
    nAvatarHP = nAvatarHP+1;
    SetLocalInt(OBJECT_SELF,"AvatarHP",nAvatarHP);
}
else if(nRepair == FALSE && nAvatarHP > 0)
{
    nAvatarHP = nAvatarHP-1;
    SetLocalInt(OBJECT_SELF,"AvatarHP",nAvatarHP);
}
if(GetTag(OBJECT_SELF)=="9")
    sAvatarHP = IntToString(nAvatarHP)+" <c¶)<>Evil<c3¦y>";
else if(GetTag(OBJECT_SELF)=="0")
    sAvatarHP = IntToString(nAvatarHP)+" <c29±>Good<c3¦y>";

SendMessageToPC(oPC,"<ca¦z>----------- "+sAvatarHP+" Avatar HP Left! <ca¦z>-----------");
if(nAvatarHP == 0)
    DestroyAvatar(OBJECT_SELF, oPC);
}
void main()
{
object oPC = GetLastDamager();
int nUnLockedGood = GetLocalInt(OBJECT_SELF,"UnlockGood");
int nUnLockedEvil = GetLocalInt(OBJECT_SELF,"UnlockEvil");
int nTeam = GetLocalInt(oPC,"nTeam");
if(nTeam == 1 && nUnLockedGood == 1)
DamageAvatar(oPC);
else if(nTeam == 2 && nUnLockedEvil == 1)
DamageAvatar(oPC);
else
Warn(oPC);
}
