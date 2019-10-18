////////////////////////////////////////////////////////////////////////////////
//  Dead and Wild Magic System - OnAcquired
//  wdm_mod_onaqu
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module OnAcquired Event
//
////////////////////////////////////////////////////////////////////////////////

#include "wdm_inc"

void main()
{
    object oItem = GetModuleItemAcquired();
    object oCreature = GetModuleItemAcquiredBy();
    if (oCreature != OBJECT_INVALID)
    {
      struct DeadMagicInfo deadInfo = WDM_GetAreaDeadMagicStatus(GetArea(oCreature));
      if (deadInfo.iIsDeadMagic && deadInfo.iStripProperties) WDM_RemoveAllProperties(oItem, oCreature);
    }
}
