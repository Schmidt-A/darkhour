// tow_linkpoints
// Scripted By: Demon X
// For: Antiworld
// This script is placed on the Link Points OnDamaged event.
#include "inc_bs_module"



void Warn(object oPC)
{
int nDelay = GetLocalInt(oPC,"WarnedLink");
if(nDelay != 1)
    {
    FloatingTextStringOnCreature("You cannot damage locked links!",oPC);
    SetLocalInt(oPC,"WarnedLink",1);
    DelayCommand(3.0,SetLocalInt(oPC,"WarnedLink",0));
    }
}
void CheckMiddleClash(string sTag,int nTeam)
{
int nTag = StringToInt(sTag);
string sLinkage;
object oLinkage;
int nClaim;
effect eEffect;
if(nTeam == 1)
{
    nTag = nTag+1;
    sLinkage = IntToString(nTag);
    oLinkage = GetNearestObjectByTag(sLinkage);
    nClaim = GetLocalInt(oLinkage,"LinkClaimed");
    if(nClaim == 2)
    {
    RemoveAllBeams(GetNearestObjectByTag(sLinkage));
    RemoveAllBeams(OBJECT_SELF);
    oLinkage = GetNearestObjectByTag("Middle0"+sTag);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_HOLY,OBJECT_SELF,BODY_NODE_CHEST)),oLinkage);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_EVIL,GetNearestObjectByTag(sLinkage),BODY_NODE_CHEST)),oLinkage);
    }
}
else if(nTeam == 2)
{
    nTag = nTag-1;
    sLinkage = IntToString(nTag);
    oLinkage = GetNearestObjectByTag(sLinkage);
    nClaim = GetLocalInt(oLinkage,"LinkClaimed");
    if(nClaim == 1)
    {
    RemoveAllBeams(GetNearestObjectByTag(sLinkage));
    RemoveAllBeams(OBJECT_SELF);
    oLinkage = GetNearestObjectByTag("Middle0"+sLinkage);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_EVIL,OBJECT_SELF,BODY_NODE_CHEST)),oLinkage);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_HOLY,GetNearestObjectByTag(sLinkage),BODY_NODE_CHEST)), oLinkage);
    }
}
}
void DestroyLink(int nTeam, object oPC)
{
string sLost;
int nLinkNumber = StringToInt(GetTag(OBJECT_SELF));
string sLinkNumber;
object oLinkage, oMiddle;
RewardTugOfWar(TOW_DESTROY_LINK,oPC,nTeam, 10);
if(nTeam == 1)
{
sLost = "<c¶)<>Evil<c¶¶<>";
sLinkNumber = IntToString(nLinkNumber-1);
oLinkage = GetNearestObjectByTag(sLinkNumber);
sLinkNumber = IntToString(nLinkNumber-1);
oMiddle = GetNearestObjectByTag("Middle0"+sLinkNumber);
SetLocalInt(oLinkage,"UnlockEvil",0);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_HOLY,OBJECT_SELF,BODY_NODE_CHEST)),oLinkage);
}
else if(nTeam == 2)
{
sLost = "<c29±>Good<c¶¶<>";
sLinkNumber = IntToString(nLinkNumber+1);
oLinkage = GetNearestObjectByTag(sLinkNumber);
sLinkNumber = IntToString(nLinkNumber);
oMiddle = GetNearestObjectByTag("Middle"+sLinkNumber);
SetLocalInt(oLinkage,"UnlockGood",0);
ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_EVIL,OBJECT_SELF,BODY_NODE_CHEST)),oLinkage);
}
SpeakString(sLost+" has lost a link point!",TALKVOLUME_SHOUT);
SetLocalInt(OBJECT_SELF,"LinkClaimed",0);
PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION),OBJECT_SELF);
RemoveAllEffects(OBJECT_SELF);
if(GetTag(oMiddle)!= "Middle0" && GetTag(oMiddle) != "Middle08")
RemoveAllEffects(oMiddle);
}
void ClaimLink(int nTeam, object oPC)
{
RewardTugOfWar(TOW_LINK_CAPTURED,oPC,nTeam, 15);
SetLocalInt(OBJECT_SELF,"LinkHP",100);
SetLocalInt(OBJECT_SELF,"LinkClaimed",nTeam);
SetLocalInt(OBJECT_SELF,"nTeam",nTeam);
SetLocalInt(OBJECT_SELF,"ClaimHP",100);
int nLinkNumber = StringToInt(GetTag(OBJECT_SELF));
string sLinkNumber;
object oLinkage;
string sTeam;
if(nTeam == 1)
{
    sLinkNumber = IntToString(nLinkNumber+1);
    oLinkage = GetNearestObjectByTag(sLinkNumber);
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_STRIKE_HOLY),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_ICESKIN)),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_BLUR)),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_HOLY,oLinkage,BODY_NODE_CHEST)),OBJECT_SELF);
    SetLocalInt(oLinkage,"UnlockGood",1);
    sLinkNumber = IntToString(nLinkNumber-1);
    oLinkage = GetNearestObjectByTag(sLinkNumber);
    SetLocalInt(oLinkage,"UnlockEvil",0);
    sTeam = "<c29±>Good<c¶¶<>";
    CheckMiddleClash(GetTag(OBJECT_SELF),nTeam);
}
else if(nTeam == 2)
{
    sLinkNumber = IntToString(nLinkNumber-1);
    oLinkage = GetNearestObjectByTag(sLinkNumber);
    SetLocalInt(oLinkage,"UnlockEvil",1);
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_HARM),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_PROT_SHADOW_ARMOR)),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectVisualEffect(VFX_DUR_PARALYZED)),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SupernaturalEffect(EffectBeam(VFX_BEAM_SILENT_EVIL,oLinkage,BODY_NODE_CHEST)),OBJECT_SELF);
    sLinkNumber = IntToString(nLinkNumber+1);
    oLinkage = GetNearestObjectByTag(sLinkNumber);
    SetLocalInt(oLinkage,"UnlockGood",0);
    sTeam = "<c¶)<>Evil<c¶¶<>";
    CheckMiddleClash(GetTag(OBJECT_SELF),nTeam);
}

SpeakString(sTeam+" has captured a link point!",TALKVOLUME_SHOUT);
}
void DamageLink(object oPC)
{
int nTeam = GetLocalInt(oPC,"nTeam");
int nLinkClaimed = GetLocalInt(OBJECT_SELF,"LinkClaimed");
int nClaimHP = GetLocalInt(OBJECT_SELF,"ClaimHP");
int nLinkHP = GetLocalInt(OBJECT_SELF,"LinkHP");
string sLinkHP, sClaimHP;

if(nTeam == 1 && nLinkClaimed == 0)
    sLinkHP = IntToString(nLinkHP);
else if(nTeam == 2 && nLinkClaimed == 0)
    sLinkHP = IntToString(200-nLinkHP);

if(nLinkClaimed == 0)
    SendMessageToPC(oPC,"<ca¦z> -+-+-+-+-+ <c3¦y>"+sLinkHP+" Link HP Remaining! <c3¦y> +-+-+-+-+-");

if(nLinkHP <= 0 && nLinkClaimed == 0)
{
ClaimLink(1,oPC);
}
else if(nLinkHP >= 200 && nLinkClaimed == 0)
{
ClaimLink(2,oPC);
}
else if(nTeam == 1 && nLinkClaimed == 0)
SetLocalInt(OBJECT_SELF,"LinkHP",(nLinkHP-1));

else if(nTeam == 1 && nLinkClaimed == 1 && nClaimHP <= 100)
SetLocalInt(OBJECT_SELF,"ClaimHP",nClaimHP+1);

else if(nTeam == 1 && nLinkClaimed == 2 && nClaimHP >0)
SetLocalInt(OBJECT_SELF,"ClaimHP",nClaimHP-1);

else if(nTeam == 2 && nLinkClaimed == 0)
SetLocalInt(OBJECT_SELF,"LinkHP",(nLinkHP+1));

else if(nTeam == 2 && nLinkClaimed == 1 && nClaimHP >0)
SetLocalInt(OBJECT_SELF,"ClaimHP",nClaimHP-1);

else if(nTeam == 2 && nLinkClaimed == 2 && nClaimHP <= 100)
SetLocalInt(OBJECT_SELF,"ClaimHP",nClaimHP+1);

else if(nTeam == 2 && nLinkClaimed == 1 && nClaimHP <=0)
DestroyLink(2,oPC);

else if(nTeam == 1 && nLinkClaimed == 2 && nClaimHP <=0)
DestroyLink(1,oPC);

if(nLinkClaimed == 1)
    sClaimHP = IntToString(nClaimHP)+" <c29±>Good<c3¦y>";
else if(nLinkClaimed ==2)
    sClaimHP = IntToString(nClaimHP)+" <c¶)<>Evil<c3¦y>";

if(nLinkClaimed != 0)
    SendMessageToPC(oPC,"<ca¦z>-+-+-+-+-+ <c3¦y>"+sClaimHP+" Link HP Remaining! <ca¦z> +-+-+-+-+-");
}
void main()
{
object oPC = GetLastDamager();
int nUnLockedGood = GetLocalInt(OBJECT_SELF,"UnlockGood");
int nUnLockedEvil = GetLocalInt(OBJECT_SELF,"UnlockEvil");
int nTeam = GetLocalInt(oPC,"nTeam");
if(nTeam == 1 && nUnLockedGood == 1)
DamageLink(oPC);
else if(nTeam == 2 && nUnLockedEvil == 1)
DamageLink(oPC);
else
Warn(oPC);
}
