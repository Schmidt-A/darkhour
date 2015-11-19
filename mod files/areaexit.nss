void main()
{
    object oArea = OBJECT_SELF;
    string sTag = GetTag(oArea);

    if(sTag == "carnival")
    {ExecuteScript("window_areaexit", OBJECT_SELF);}
}
