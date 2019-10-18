////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Trash Can
//  ors_trashcan
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is placed in the OnClosed Event of
//  a chest or whatever.
//
//  Destroys anything that is placed in this can
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oTrashCan = OBJECT_SELF;
    object oItemInTrash = GetFirstItemInInventory(oTrashCan);

    if(GetIsObjectValid(oItemInTrash))
    {
      ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect( VFX_FNF_SMOKE_PUFF ), OBJECT_SELF );
    }

    while(GetIsObjectValid(oItemInTrash) == TRUE)
    {
      DestroyObject(oItemInTrash);
      oItemInTrash = GetNextItemInInventory(oTrashCan);
    }
}
