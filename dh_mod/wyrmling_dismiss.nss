//
//
//
void main()
{
    object oPc = GetPCSpeaker();
    object oWyrmling = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPc, 1);

    RemoveHenchman(oPc, oWyrmling);
    SetPlotFlag(oWyrmling, FALSE);
    SetImmortal(oWyrmling, FALSE);
    DestroyObject(oWyrmling, 0.2);
}

