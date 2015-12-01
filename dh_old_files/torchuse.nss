// Destroys candles and torches that are unequipped.

// Created by Ronin_DM on Unknown
// Description by Zunath on July 22, 2007

void main()
{
    object oItem = GetPCItemLastUnequipped();
    if ((GetTag(oItem) == "zn_torch") || (GetTag(oItem) == "Candle"))
    {
        DestroyObject(oItem);
    }
}
