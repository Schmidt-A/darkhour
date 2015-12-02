#include "inc_bs_module"


int StartingConditional()
{
    int nGoodScore = GetLocalInt(GetModule(), "nScore_1");
    int nEvilScore = GetLocalInt(GetModule(), "nScore_2");
    //Additional Statistics for player stats added by Scott Shepherd
    int m_nGoldwinnings = GetLocalInt(GetLastSpeaker(),"m_nGoldwinnings");
    int m_nKills = GetLocalInt(GetLastSpeaker(),"m_nKills");
    int m_nDeaths = GetLocalInt(GetLastSpeaker(),"m_nDeaths");

    SetCustomToken(501, IntToString(nGoodScore));
    SetCustomToken(502, IntToString(nEvilScore));
    SetCustomToken(503, IntToString(GetLocalInt(GetLastSpeaker(), "nScore")));
    SetCustomToken(504, IntToString(m_nGoldwinnings));
    SetCustomToken(505, IntToString(m_nKills));
    SetCustomToken(506, IntToString(m_nDeaths));

    return TRUE;
}
