#include "zzz_huntinclude"

void main()
{
//Monster statue script for "The Hunt" game mode
object oPC = GetLastUsedBy();
if (GetLocalInt(oPC, "Hunter") == TRUE)
{

    object oStatue = OBJECT_SELF;
    if (GetLocalInt(OBJECT_SELF, "StatueUsed") == TRUE)
    {
        FloatingTextStringOnCreature("This statue is empty.", oPC);
    }
    else
    {
        int nChance2 = GetLocalInt(GetModule(), "MonsterType");
            if (nChance2 == 1)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);

                            HuntFrog(oPC);

            }
            if (nChance2 == 2)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntGoat(oPC);
            }
            if (nChance2 == 3)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntBeetle(oPC);
            }
            if (nChance2 == 4)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntScorpion(oPC);
            }
            if (nChance2 == 5)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntFish(oPC);
            }
            if (nChance2 == 6)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntBull(oPC);
            }
            if (nChance2 == 7)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntAnt(oPC);
            }
            if (nChance2 == 8)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntVulture(oPC);
            }
            if (nChance2 == 9)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntSkink(oPC);
            }
            if (nChance2 == 10)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntLouse(oPC);
            }
            if (nChance2 == 11)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntSpider(oPC);
            }
            if (nChance2 == 12)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntMutant(oPC);
            }
            if (nChance2 == 13)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            HuntBoar(oPC);
                            DoRemoveBuffs(OBJECT_SELF);

            }
            if (nChance2 == 14)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntRat(oPC);

            }
            if (nChance2 == 15)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntWolf(oPC);

            }
            if (nChance2 == 16)
            {
                            SetLocalInt(OBJECT_SELF, "StatueUsed", TRUE);
                            DeleteLocalInt(oPC, "Hunter");
                            int nTeam = GetLocalInt(oPC, "nTeam");
                            string sTeam = IntToString(nTeam);
                            sTeam = "Monster" + sTeam;
                            if (GetLocalInt(GetModule(), sTeam) < 1)
                            {
                                SetLocalInt(GetModule(), sTeam, 1);
                            }
                            else
                            {
                                int nSet = GetLocalInt(GetModule(), sTeam) +1;
                                SetLocalInt(GetModule(), sTeam, nSet);
                            }
                            DoRemoveBuffs(OBJECT_SELF);
                            HuntCat(oPC);
            }

}      }

else
{
    FloatingTextStringOnCreature("Only Berserkers, Archers, or Shamans may use this.", oPC);
}

}
