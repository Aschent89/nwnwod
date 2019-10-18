////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - VFX on Placeable
//  ors_vfx_place
//  By:Don Anderson
//  dandersonru@msn.com
//
//  Tag on Placeable MUST be VFXPlace
//
////////////////////////////////////////////////////////////////////////////////


void main()
{
  object oSelf = OBJECT_SELF;

  if(GetLocalInt(oSelf, "nDoOnce") == 1) return;
  SetLocalInt(oSelf, "nDoOnce", 1);

  effect eEffect;
  int nVFX = GetLocalInt(oSelf,"VFX");
  eEffect = EffectVisualEffect(nVFX);

  //Object Type
  int nOT = GetObjectType(oSelf);

  //Placeables
  if(nOT == OBJECT_TYPE_PLACEABLE)
  {
    SendMessageToPC(GetFirstPC(),"VFX Place Placeable");

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oSelf);
    return;
  }
}
