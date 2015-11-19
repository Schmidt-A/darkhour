void main()
{
    effect eSpeed = EffectMovementSpeedDecrease(50);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSpeed,OBJECT_SELF,(IntToFloat(d4()) + 2.0));
    DelayCommand(9.0,ExecuteScript("speedburst",OBJECT_SELF));
}
