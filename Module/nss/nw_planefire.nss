void main()
{
object oPC = GetFirstPC();
while (GetIsObjectValid(oPC))
{
    if (GetArea(oPC) == GetArea(OBJECT_SELF))
    {
    //SendMessageToPC(oPC,"1");
    if (!GetIsDM(oPC))
    {
    //SendMessageToPC(oPC,"2");
    if (GetIsPC(oPC))
    {
        int nDmgAmt = 10;
        int nPChp = GetCurrentHitPoints(oPC);
        int nFireDeath = GetLocalInt(oPC,"Fire_Death");
        effect eBurnt = EffectDamage(nDmgAmt,DAMAGE_TYPE_FIRE,DAMAGE_POWER_ENERGY);
        if (GetIsDead(oPC))
            {
            SetLocalInt(oPC,"Fire_Death",0);
            }
        else
            {
            SetLocalInt(oPC,"Fire_Death",1);
            }

        DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT,eBurnt,oPC,0.0));
        if (nPChp >= 30)
            {
            DelayCommand(4.1, SendMessageToPC(oPC,"You feel the extreme heat burning your body."));
            }
        else if (nPChp < 30 && nPChp > 10)
            {
            DelayCommand(4.1, SendMessageToPC(oPC,"You feel the extreme heat burning your body."));
            DelayCommand(4.2, SendMessageToPC(oPC,"You are about to burn to death."));
            }
        else if (nPChp < 11 &&  nFireDeath == 0)
            {
            DelayCommand(4.2, SendMessageToPC(oPC,"You have burnt to death."));
            }
        }
      }
      }
    oPC = GetNextPC();
}
}
