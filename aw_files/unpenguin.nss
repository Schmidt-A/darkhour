void main()
{
object oGm = GetPCSpeaker();
object oMyTarget = GetLocalObject(oGm,"MyTarget");
effect ePenguinEffect;
string sName;

   ePenguinEffect=GetFirstEffect(oMyTarget);
   while(GetIsEffectValid(ePenguinEffect))
   {
      if ((GetEffectDurationType(ePenguinEffect) == DURATION_TYPE_PERMANENT) && (GetEffectType(ePenguinEffect) ==  EFFECT_TYPE_POLYMORPH))
      {
         RemoveEffect(oMyTarget, ePenguinEffect);
      }
      ePenguinEffect = GetNextEffect(oMyTarget);
   }

DelayCommand(20.0, DeleteLocalObject(oGm,"MyTarget"));

}

