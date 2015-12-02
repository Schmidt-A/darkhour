int StartingConditional()
{
    if (GetLocalInt(GetPCSpeaker(),"nFoundMaker") == 1)
       {
       DeleteLocalInt(GetPCSpeaker(),"nFoundMaker");
       return FALSE;
       }

    else return TRUE;
}
