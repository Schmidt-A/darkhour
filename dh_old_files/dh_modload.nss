// Wrapper for the Dark Hour module
#include "x2_inc_switches"

void main()
{
 int iHour = GetTimeHour();
 int iMilli = GetTimeMillisecond();
 int iMinute = GetTimeMinute();
 int iSecond = GetTimeSecond();
 SetTime(iHour, iMinute, iSecond, iMilli);
 AssignCommand(OBJECT_SELF, DelayCommand(120.0, ExecuteScript("bm_setclock", OBJECT_SELF)));
//0255 is not usable in scripts, use 0254, symbol þ

    SetCustomToken(100, "</c>"); // CLOSE tag
    SetCustomToken(102, "<c þ >"); // green
    SetCustomToken(103, "<c  þ>"); // blue
    SetCustomToken(105, "<cþ þ>"); // magenta
    SetCustomToken(106, "<cþþ >"); // yellow
    SetCustomToken(107, "<c   >"); // black
    SetCustomToken(108, "<c¥  >"); // dark red
    SetCustomToken(109, "<c ¥ >"); // dark green
    SetCustomToken(110, "<c  ¥>"); // dark blue
    SetCustomToken(111, "<c ¥¥>"); // dark cyan
    SetCustomToken(112, "<c¥ ¥>"); // dark magenta
    SetCustomToken(113, "<c¥¥ >"); // dark yellow
    SetCustomToken(114, "<c¥¥¥>"); // grey
    SetCustomToken(117, "<cŒŒŒ>"); // dark grey
    SetCustomToken(115, "<cþ¥ >"); // orange
    SetCustomToken(116, "<cþŒ >"); // dark orange
    SetCustomToken(117, "<cÚ¥#>"); // brown
    SetCustomToken(118, "<cÂ† >"); // dark brown
    SetCustomToken(119, "<cþ  >"); // red
    SetCustomToken(120, "<c þþ>"); // cyan
    SetCustomToken(121, "<c þ >"); // lime green
    SetCustomToken(122, "<cþ× >"); // gold
    SetCustomToken(123, "<cþÙP>"); // Peach
    SetCustomToken(124, "<cþß+>"); // Gold-Yellow

    SetCustomToken(125, GetCampaignString("NPC_STORAGE_NAMES","1"));
    SetCustomToken(126, GetCampaignString("NPC_STORAGE_NAMES","2"));
    SetCustomToken(127, GetCampaignString("NPC_STORAGE_NAMES","3"));
    SetCustomToken(128, GetCampaignString("NPC_STORAGE_NAMES","4"));
    SetCustomToken(129, GetCampaignString("NPC_STORAGE_NAMES","5"));
    SetCustomToken(130, GetCampaignString("NPC_STORAGE_NAMES","6"));
    SetCustomToken(131, GetCampaignString("NPC_STORAGE_NAMES","7"));
    SetCustomToken(132, GetCampaignString("NPC_STORAGE_NAMES","8"));
    SetCustomToken(133, GetCampaignString("NPC_STORAGE_NAMES","9"));
    SetCustomToken(134, GetCampaignString("NPC_STORAGE_NAMES","10"));
    SetLocalInt(GetModule(), "X3_MOUNTS_EXTERNAL_ONLY", TRUE);
    SetLocalInt(GetModule(), "X3_MOUNT_NO_REST_DESPAWN", FALSE);

    SetModuleOverrideSpellscript("dh_spellhook");
}
