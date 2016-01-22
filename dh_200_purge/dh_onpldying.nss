#include "inc_pvpkill"
#include "subdual_inc"
//::///////////////////////////////////////////////
//:: Dying Script
//:: s_dying.NSS
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a character is dying. Dying
    is when the character is between 0 and -9 hit
    points; -10 and below is death. To use, redirect
    the OnDying event script of the module to this script.
*/
//:://////////////////////////////////////////////
//:: Author : Scott Thorne
//:: E-mail : Thornex2@wans.net
//:: Updated: July 25, 2002
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Modifier : Peter Abdis
//:: E-mail : xantec@insightbb.com
//:: Updated: March 06, 2003
//:://////////////////////////////////////////////
//:: Modifier : Demon X
//:: E-mail : getmilk@gmail.com
//:: Updated: May 22, 2007
//:://////////////////////////////////////////////
void Bleed(int iBleedAmt)
{
    object oDying = GetLocalObject(OBJECT_SELF, "PCName");
    int iDCC = GetLocalInt(oDying, "iPCDCC");
    iDCC = iDCC + 1;
    int iDC;
    int iDCBase = 16; /* Decrease/increase this value to lower/raise the base DC. */
    iDC = iDCBase;

    /* This is used to decrease the PC's chance to stabilize should they not 
       stabilize after iDCBase turns. Is really only effective when iDCBase < 10 */
    if(iDCC > iDCBase)
        iDC = iDCC;

    effect eBleedEff;

    /* keep executing recursively until character is dead or at +1 hit points */
    if (GetCurrentHitPoints() <= 0)
    {
        /* a positive bleeding amount means damage, otherwise heal the character */
        if (iBleedAmt > 0)
            eBleedEff = EffectDamage(iBleedAmt);
        else
            eBleedEff = EffectHeal(-iBleedAmt);  /* note the negative sign */

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBleedEff, oDying);

        /* -10 hit points is the death threshold, at or beyond it the character dies */
        if (GetCurrentHitPoints() <= -10)
        {
            PlayVoiceChat(VOICE_CHAT_DEATH); /* scream one last time */
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF); /* make death dramatic */
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oDying); /* now kill them */
            return;
        }

        if (iBleedAmt > 0)  /* only check if character has not stablized */
        {
            int iConBonus = GetAbilityModifier(ABILITY_CONSTITUTION, oDying);
            int iStableRoll = d20() + iConBonus;
            if(iStableRoll >= iDC)
            {
                iBleedAmt = -iBleedAmt; /* reverse the bleeding process */
                SendMessageToPC(oDying, "You have stabilized and have begun to heal.");
            }
            else
            {
                SendMessageToPC(oDying, "You have failed to stabilized in round: "+IntToString(iDCC)+".");
                switch (d6())
                {
                    case 1: PlayVoiceChat(VOICE_CHAT_PAIN1); break;
                    case 2: PlayVoiceChat(VOICE_CHAT_PAIN2); break;
                    case 3: PlayVoiceChat(VOICE_CHAT_PAIN3); break;
                    case 4: PlayVoiceChat(VOICE_CHAT_HEALME); break;
                    case 5: PlayVoiceChat(VOICE_CHAT_NEARDEATH); break;
                    case 6: PlayVoiceChat(VOICE_CHAT_HELP);
                }
            }
        }

        if(GetCurrentHitPoints() <= 0)
        {
            SetLocalInt(oDying, "iPCDCC", iDC);
            DelayCommand(6.0,bleed(iBleedAmt)); /* do this again next round */
        }
    }
}

void main()
{
    object oDying = GetLastPlayerDying();
    if (CheckSubdual(oDying))
        return;

    object oKiller = GetLastDamager(oDying);
    SetLocalObject(oDying, "PCName", oDying);
    SetLocalInt(oDying, "iPCDCC", 0);
    AssignCommand(oDying, ClearAllActions());

    if(GetIsPossessedFamiliar(oDying) == FALSE)
    {
        // Create death token on player
        object oDeathToken = CreateItemOnObject("deathtoken", oDying);
        if(!GetIsPC(oKiller))
            AssignCommand(oDying, Bleed(1));
        else
            PVPKill(oDying, oKiller, oDeathToken);
    }
}
