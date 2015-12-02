void main()
{
// In an onConversation script this gets the number of the string pattern
// matched (the one that triggered the script).
// * Returns -1 if no string matched
// int GetListenPatternNumber()
/*
APPEARANCE_TYPE_WILL_O_WISP
APPEARANCE_TYPE_ZOMBIE
APPEARANCE_TYPE_ZOMBIE_ROTTING
APPEARANCE_TYPE_ZOMBIE_WARRIOR_1
APPEARANCE_TYPE_ZOMBIE_WARRIOR_2
APPEARANCE_TYPE_MUMMY_COMMON
APPEARANCE_TYPE_MUMMY_FIGHTER_2
APPEARANCE_TYPE_MUMMY_GREATER
APPEARANCE_TYPE_MUMMY_WARRIOR
APPEARANCE_TYPE_GHOUL
APPEARANCE_TYPE_SUCCUBUS
APPEARANCE_TYPE_GHOUL_LORD
APPEARANCE_TYPE_SPECTRE
APPEARANCE_TYPE_VAMPIRE_MALE
APPEARANCE_TYPE_VAMPIRE_FEMALE
APPEARANCE_TYPE_BODAK
APPEARANCE_TYPE_MOHRG
APPEARANCE_TYPE_LICH
APPEARANCE_TYPE_DEMI_LICH
APPEARANCE_TYPE_DOOM_KNIGHT
APPEARANCE_TYPE_WRAITH
APPEARANCE_TYPE_WERECAT
APPEARANCE_TYPE_WERERAT
APPEARANCE_TYPE_WEREWOLF
APPEARANCE_TYPE_DOG_WORG  ENIRO ONLY
   */

object oPC = GetPCSpeaker();
int nMatch = GetListenPatternNumber();
switch  (nMatch)
        {
    case 401:
             switch (GetClassByPosition(1,oPC))
             {
             case CLASS_TYPE_CLERIC :
                 SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_PRIEST );
                 break;
             case CLASS_TYPE_SORCERER:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_MAGE);
                  break;
             case CLASS_TYPE_WIZARD:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_MAGE);
                  break;
             case CLASS_TYPE_ROGUE:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_COMMON);
                  break;
             case CLASS_TYPE_RANGER:
                 SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_CHIEFTAIN);
                  break;
             case CLASS_TYPE_PALADIN:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_WARRIOR);
                  break;
             case CLASS_TYPE_MONK:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_WARRIOR_2);
                  break;
             default :
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SKELETON_WARRIOR_1);
                  break;
                  }
             break;
     case 402:
             switch (GetClassByPosition(1,oPC))
             {
             case CLASS_TYPE_CLERIC :
                 SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ZOMBIE_TYRANT_FOG );
                 break;
             case CLASS_TYPE_SORCERER:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ZOMBIE_ROTTING);
                  break;
             case CLASS_TYPE_WIZARD:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ZOMBIE_ROTTING);
                  break;
             case CLASS_TYPE_ROGUE:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ZOMBIE_WARRIOR_1);
                  break;
             default :
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_ZOMBIE_WARRIOR_2);
                  break;
                  }
             break;
     case 403:
            switch  (GetGender(oPC))
            {
               case GENDER_FEMALE :
                   SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_HARPY );
                   break;
               case GENDER_MALE:
                    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GARGOYLE);
                    break;
                    }
             break;
      case 404:
             switch (GetClassByPosition(1,oPC))
             {
             case CLASS_TYPE_CLERIC :
                 SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MUMMY_GREATER );
                 break;
             case CLASS_TYPE_SORCERER:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MUMMY_GREATER);
                  break;
             case CLASS_TYPE_WIZARD:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MUMMY_COMMON);
                  break;
             case CLASS_TYPE_ROGUE:
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MUMMY_FIGHTER_2);
                  break;
             default :
                  SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MUMMY_WARRIOR);
                  break;
                  }
             break;
      case 405:
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
             break;
     case 406:
             SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_ALLIP);
             break;
    case 407:
             SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_WEREWOLF);
             break;
       case 408:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_SPECTRE );
             break;
       case 409:
             switch  (GetGender(oPC))
             {
               case GENDER_FEMALE :
                   SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_VAMPIRE_FEMALE );
                   break;
               case GENDER_MALE:
                    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_VAMPIRE_MALE);
                    break;
                    }
             break;
    case 410:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_WRAITH );
             break;
       case 411:
             switch  (GetGender(oPC))
             {
               case GENDER_FEMALE :
                   SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DROW_FEMALE_2 );
                   break;
               case GENDER_MALE:
                    SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DROW_WARRIOR_2);
                    break;
                    }
             break;
      case 412:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_BODAK );
             break;
    case 413:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_MOHRG );
             break;
     case 414:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_LICH );
             break;
     case 415:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DEMI_LICH );
             break;
      case 416:
             SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_DOOM_KNIGHT);
             break;
      case 417:
             SetCreatureAppearanceType(oPC,APPEARANCE_TYPE_DEVIL );
             break;
       case 418:
             SetCreatureAppearanceType(oPC, APPEARANCE_TYPE_GOLEM_BONE);
             break;
       default:
           FloatingTextStringOnCreature("Nothing happen..",oPC);
         }
         SetListening(oPC, FALSE);
}
/*10 to 16 skeleton zombie,Will'o'Wisp Werewolf
16-22 mummy ghoul [skeleton zombieWill'o'Wisp Werewolf Succubus]
22-28  spectre vampire [mummy ghoul skeleton zombie Will'o'Wisp Werewolf]
28-34 bodak Mohrg [spectre vampire - mummy ghoul skeleton zombie Will'o'Wisp Werewolf]
34-40 lich  demilich doom-knight wraith[bodak Mohrg - spectre vampire - mummy ghoul - skeleton zombie Will'o'Wisp Werewolf]*/
/*Plus Eniro only: APPEARANCE_TYPE_DOG_WOLF
Jantima: APPEARANCE_TYPE_DROW_MATRON */

