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
        int nChance = d4(1);
        if (nChance == 1)
        {
            int nChance2 = d8(1);
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

                            HuntVulture(oPC);
            }
        }
        else if (nChance == 2)
        {
            int nChance2 = d8(1);
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

                            HuntFish(oPC);
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

                            HuntBull(oPC);
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

                            HuntAnt(oPC);
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

                            HuntVulture(oPC);
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

                            HuntSkink(oPC);
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

                            HuntLouse(oPC);
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

                            HuntSpider(oPC);
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

                            HuntMutant(oPC);
            }
        }
        else if (nChance == 3)
        {
            int nChance2 = d8(1);
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

                            HuntSkink(oPC);
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

                            HuntLouse(oPC);
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

                            HuntSpider(oPC);
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

                            HuntMutant(oPC);
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
                            HuntBoar(oPC);

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

                            HuntRat(oPC);

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

                            HuntWolf(oPC);

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

                            HuntCat(oPC);

            }
        }
        else if (nChance == 4)
        {
            int nChance2 = d8(1);
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
                            HuntBoar(oPC);

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

                            HuntRat(oPC);

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

                            HuntWolf(oPC);

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

                            HuntCat(oPC);

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

                            HuntFrog(oPC);

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

                            HuntGoat(oPC);
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

                            HuntBeetle(oPC);
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

                            HuntScorpion(oPC);
            }
        }
    }

}

else
{
    FloatingTextStringOnCreature("Only Berserkers, Archers, or Shamans may use this.", oPC);
}

}
