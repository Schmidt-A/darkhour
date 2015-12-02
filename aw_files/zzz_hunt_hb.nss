void main()
{

object oModule = GetModule();
int nRound = GetLocalInt(oModule, "nRound");
if (nRound >= 999)
{
    int nMonsterType = GetLocalInt(oModule, "MonsterType");
    if ( (nMonsterType >= 16) || (nMonsterType < 1) )
    {
        SetLocalInt(oModule, "MonsterType", 1);
        DelayCommand(2.0, SetLocalInt(oModule, "MonsterType", 2));
        DelayCommand(4.0, SetLocalInt(oModule, "MonsterType", 3));
    }
    else
    {
        int nSetMonsterType1 = nMonsterType + 1;
        int nSetMonsterType2 = nMonsterType + 2;
        int nSetMonsterType3 = nMonsterType + 3;
        if (nSetMonsterType2 > 16)
        {
            nSetMonsterType2 = 1;
            nSetMonsterType3 = 2;
        }
        if (nSetMonsterType3 > 16)
        {
            nSetMonsterType3 = 1;
        }
        SetLocalInt(oModule, "MonsterType", nSetMonsterType1);
        DelayCommand(2.0, SetLocalInt(oModule, "MonsterType", nSetMonsterType2));
        DelayCommand(4.0, SetLocalInt(oModule, "MonsterType", nSetMonsterType3));
    }

    int nChance = d20(1);
    int nChance2 = d2(1);
    if ((nChance > 19) && (nChance2 == 2))
    {
        int nStone = d6(1);
        object oStone1 = GetObjectByTag("powerup1");
        object oStone2 = GetObjectByTag("powerup2");
        object oStone3 = GetObjectByTag("powerup3");
        object oStone4 = GetObjectByTag("powerup4");
        object oStone5 = GetObjectByTag("powerup6");
        object oStone6 = GetObjectByTag("powerup6");
        if ((nStone == 1) && (GetLocalInt(oStone1, "Decharged") == TRUE))
        {
            AssignCommand(oStone1, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A Spirit Stone is active! [testing only]", TALKVOLUME_SHOUT));
            DeleteLocalInt(oStone1, "Decharged");
        }
        else if ( (nStone == 2) && (GetLocalInt(oStone2, "Decharged") == TRUE) )
        {
            AssignCommand(oStone2, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A Spirit Stone is active! [testing only]", TALKVOLUME_SHOUT));
            DeleteLocalInt(oStone2, "Decharged");
        }
        else if ( (nStone == 3) && (GetLocalInt(oStone3, "Decharged") == TRUE) )
        {
            AssignCommand(oStone3, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A Spirit Stone is active! [testing only]", TALKVOLUME_SHOUT));
            DeleteLocalInt(oStone3, "Decharged");
        }
        else if ( (nStone == 4) && (GetLocalInt(oStone4, "Decharged") == TRUE) )
        {
            AssignCommand(oStone4, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A Spirit Stone is active! [testing only]", TALKVOLUME_SHOUT));
            DeleteLocalInt(oStone4, "Decharged");
        }
        else if ( (nStone == 5) && (GetLocalInt(oStone5, "Decharged") == TRUE) )
        {
            AssignCommand(oStone5, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A Spirit Stone is active! [testing only]", TALKVOLUME_SHOUT));
            DeleteLocalInt(oStone5, "Decharged");
        }
        else if ( (nStone == 6) && (GetLocalInt(oStone6, "Decharged") == TRUE) )
        {
            AssignCommand(oStone6, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            AssignCommand(GetObjectByTag("flagshouter"), ActionSpeakString("A Spirit Stone is active! [testing only]", TALKVOLUME_SHOUT));
            DeleteLocalInt(oStone6, "Decharged");
        }
    }
}

}
