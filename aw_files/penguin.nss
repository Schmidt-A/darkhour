#include "criminalrecorder"
#include "aw_include"
void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
effect ePenguinEffect;
         ePenguinEffect = EffectPolymorph(POLYMORPH_TYPE_PENGUIN , TRUE);
         ePenguinEffect = SupernaturalEffect(ePenguinEffect);
         ApplyEffectToObject(DURATION_TYPE_PERMANENT,ePenguinEffect, oMyTarget);
         if (!GetIsGM(oMyTarget))  CriminalRecordEntry(oMyTarget, oGm, "", 1);
DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));
}
