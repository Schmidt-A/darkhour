void main()
{


object oPC = GetPCSpeaker();
 int nLevel = GetHitDice(oPC);
 if (nLevel >= 16)
   {
             switch (GetClassByPosition(1,oPC))
             {
             case CLASS_TYPE_CLERIC :
                 SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GHOUL_LORD );
                 break;
             case CLASS_TYPE_SORCERER:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GHOUL_LORD);
                  break;
             case CLASS_TYPE_WIZARD:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GHOUL_LORD);
                  break;
             case CLASS_TYPE_ROGUE:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GHOUL);
                  break;
             default :
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_GHOUL);
                  break;
                  }
         }
else{
           FloatingTextStringOnCreature("Nothing happen..",oPC);
         }

}
/*10 to 16 skeleton zombie,Will'o'Wisp Werewolf
16-22 mummy ghoul [skeleton zombieWill'o'Wisp Werewolf Succubus]
22-28  spectre vampire [mummy ghoul skeleton zombie Will'o'Wisp Werewolf]
28-34 bodak Mohrg [spectre vampire - mummy ghoul skeleton zombie Will'o'Wisp Werewolf]
34-40 lich  demilich doom-knight wraith[bodak Mohrg - spectre vampire - mummy ghoul - skeleton zombie Will'o'Wisp Werewolf]*/
/*Plus Eniro only: APPEARANCE_TYPE_DOG_WOLF
Jantima: APPEARANCE_TYPE_DROW_MATRON */

