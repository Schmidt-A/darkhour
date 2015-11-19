void main()
{
if(GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC) == OBJECT_INVALID)
    {
    return;
    }
int iRand = Random(30) + 1;
string sWP = "hallvfxwp" + IntToString(iRand);
object oWP = GetWaypointByTag(sWP);
location lWP = GetLocation(oWP);
object oPixie = CreateObject(OBJECT_TYPE_CREATURE, "thcpixie", lWP);
DelayCommand(10.0, DestroyObject(oPixie));
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SMOKE_PUFF), lWP, 1.5);
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_DUR_PIXIEDUST), lWP, 10.0);
}
