#include "inc_bs_module"


int StartingConditional()
{   object oPC = GetPCSpeaker();
    int nLevel = GetHitDice(oPC);

if (nLevel >= 10)
   {
    SetCustomToken(401, "Skeleton");
    SetCustomToken(402, "Zombie");
    if (GetGender(oPC) == GENDER_MALE) SetCustomToken(403, "Gargoyle");
    else if (GetGender(oPC) == GENDER_FEMALE) SetCustomToken(403, "Harpy");
    }
    else {
          SetCustomToken(401, "You must levelup to 10 before wear Skeleton costume");
          SetCustomToken(402, "You must levelup to 10 before wear Zombie costume");
          if (GetGender(oPC) == GENDER_FEMALE) SetCustomToken(403, "You must levelup to 10 before wear Gargoyle costume");
          else if (GetGender(oPC) ==GENDER_MALE)SetCustomToken(403, "You must levelup to 10 before wear Harpy costume");
         }
 if (nLevel >= 16)
   {
    SetCustomToken(404, "Mummy");
    SetCustomToken(405, "Ghoul");
    SetCustomToken(406, "Allip");
    SetCustomToken(407, "Werewolf");
    }
    else {
          SetCustomToken(404, "You must levelup to wear Mummy costume");
          SetCustomToken(405, "You must levelup to wear Ghoul costume");
          SetCustomToken(406, "You must levelup to wear Allip costume");
          SetCustomToken(407, "You must levelup to wear Werewolf costume");
         }
if (nLevel >= 22)
   {
    SetCustomToken(408, "Spectre");
    SetCustomToken(409, "Vampire");
    SetCustomToken(410, "Wraith");
    SetCustomToken(411, "Drow");
    }
    else {
          SetCustomToken(408, "You must levelup to wear Spectre costume");
          SetCustomToken(409, "You must levelup to wear Vampire costume");
          SetCustomToken(410, "You must levelup to wear Wraith costume");
          SetCustomToken(411, "You must levelup to wear Drow costume");
         }
if (nLevel >= 28)
   {
    if (GetGender(oPC) == GENDER_MALE)
       {
       SetCustomToken(412, "Bodak");
       SetCustomToken(413, "Mohrg");
       }
    else if (GetGender(oPC) ==GENDER_FEMALE)
       {
        SetCustomToken(412, "Yuam-ti Invoker");
        SetCustomToken(413, "Sea Hag");
       }
    }
    else {
         if (GetGender(oPC) == GENDER_FEMALE)
            {
             SetCustomToken(412, "You must levelup to wear Yuam-ti Invoker costume");
             SetCustomToken(413, "You must levelup to wear Sea Hag costume");
            }
          else if (GetGender(oPC) ==GENDER_MALE)
            {
             SetCustomToken(412, "You must levelup to wear Bodak costume");
             SetCustomToken(413, "You must levelup to wear Mohrg costume");
             }
         }
if (nLevel >= 34)
   {
    SetCustomToken(414, "Lich");
    SetCustomToken(415, "Demilich");
    SetCustomToken(416, "Doom knight");
    }
     else {
          SetCustomToken(414, "You must levelup to wear Lich costume");
          SetCustomToken(415, "You must levelup to wear Demilich costume");
          SetCustomToken(416, "You must levelup to wear Doom knight costume");
         }
if (nLevel >= 40)
     {
    SetCustomToken(417, "Devil");
    SetCustomToken(418, "Lord Golem Bone");
    }
     else {
          SetCustomToken(417, "You must levelup to wear Devil costume");
          SetCustomToken(418, "You must levelup to wear Lord Golem Bone costume");
         }
 if (GetPCPlayerName(oPC) == "Jantima" || GetPCPlayerName(oPC) == "ENIRO")
     {
    SetCustomToken(419, "Dog Wrog");
    SetCustomToken(420, "Drow Matron");
    }
     else {
          SetCustomToken(419, "This is a restricted costume costume");
          SetCustomToken(420, "This is a restricted costume costume");
         }
    /*  //object oPC = GetPCSpeaker();
// Initialise oTarget to listen for the standard Associates commands.
SetListening(oPC, TRUE);
SetListenPattern(oPC, "Skeleton", 401);
SetListenPattern(oPC, "Zombie", 402);
if (GetGender(oPC) == GENDER_FEMALE)SetListenPattern(oPC, "Gargoyle", 403);
else if (GetGender(oPC) ==GENDER_MALE)SetListenPattern(oPC, "Harpy", 403);
SetListenPattern(oPC, "Mummy", 404);
SetListenPattern(oPC, "Ghoul", 405);
SetListenPattern(oPC, "Allip", 406);
SetListenPattern(oPC, "Werewolf", 407);
SetListenPattern(oPC, "Spectre", 408);
SetListenPattern(oPC, "Vampire", 409);
SetListenPattern(oPC, "Wraith", 410);
SetListenPattern(oPC, "Drow", 411);
if (GetGender(oPC) == GENDER_FEMALE)
            {
            SetListenPattern(oPC, "Yuam-ti Invoker", 412);
            SetListenPattern(oPC, "Sea Hag", 413);
            }
          else if (GetGender(oPC) ==GENDER_MALE)
            {
            SetListenPattern(oPC, "Bodak", 412);
SetListenPattern(oPC, "Mohrg", 413);
             }
SetListenPattern(oPC, "Bodak", 412);
SetListenPattern(oPC, "Mohrg", 413);
SetListenPattern(oPC, "Lich", 414);
SetListenPattern(oPC, "Demilich", 415);
SetListenPattern(oPC, "Doom knight", 416);
SetListenPattern(oPC, "Devil", 417);
SetListenPattern(oPC, "Lord Golem Bone", 418);  */


    return TRUE;
}
/*void main()
{
object oPC = GetPCSpeaker();
// Initialise oTarget to listen for the standard Associates commands.
SetListening(oPC, TRUE);
SetListenPattern(oPC, "Will'o'Wisp", 400);
SetListenPattern(oPC, "Skeleton", 401);
SetListenPattern(oPC, "Zombie", 402);
SetListenPattern(oPC, "Mummy", 403);
SetListenPattern(oPC, "Ghoul", 404);
SetListenPattern(oPC, "Spectre", 405);
SetListenPattern(oPC, "Vampire", 406);
SetListenPattern(oPC, "Bodak", 407);
SetListenPattern(oPC, "Mohrg", 408);
SetListenPattern(oPC, "Lich", 409);
SetListenPattern(oPC, "Demilich", 410);
SetListenPattern(oPC, "Doom knight", 411);
SetListenPattern(oPC, "Wraith", 411);
    SetListening(oPC, TRUE);
}       */
/*10 to 16 skeleton zombie Will'o'Wisp
16-22 mummy ghoul [skeleton zombie]
22-28  spectre vampire [mummy ghoul skeleton zombie]
28-34 bodak Mohrg [spectre vampire - mummy ghoul skeleton zombie]
34-40 lich  demilich doom-knight [bodak Mohrg - spectre vampire - mummy ghoul - skeleton zombie]
void main()
{
SetListening(oNPC, TRUE)
SetListenPattern(oNPC, "Skeleton", 401
}

wraith allip devil drow cleric
drow matron  = jantima only
gargoyle ghoul lord golem bone (40) harpy
mephistopheles /large
sea hag /female/ yuam-ti Invoker
wight
/*10 to 16 skeleton zombie,gargoyle/harpy,
16-22 mummy ghoul allip Werewolf[skeleton zombieWill'o'Wisp Werewolf Succubus]
22-28  spectre vampire wraith drow[mummy ghoul skeleton zombie Will'o'Wisp Werewolf]
28-34 bodak Mohrg [spectre vampire - mummy ghoul skeleton zombie Will'o'Wisp Werewolf]
34-40 lich  demilich doom-knight devil lord golem bone[bodak Mohrg - spectre vampire - mummy ghoul - skeleton zombie Will'o'Wisp Werewolf]*/
