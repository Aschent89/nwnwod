////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Siege System - Siege Keg - When Damaged By Fire
//  os_keg_ondamage
//  by Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    //We check to see if enough fire damage detonated the Keg
    if (GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 2)
    {
      ExecuteScript("os_keg_detonate",OBJECT_SELF);
    }
    else return;
}
