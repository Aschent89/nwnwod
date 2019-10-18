void main()
{
    object oPC=GetEnteringObject();
    int flags=0;
    object tempitem;
    if((tempitem=GetItemPossessedBy(oPC,"FALLEN_VAMPIRE_BAT_ABILITY"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("FALLEN_VAMPIRE_BAT_ABILITY"),oPC);
        flags|=1;
    }
    if((tempitem=GetItemPossessedBy(oPC,"FALLEN_VAMPIRE_MIST_ABILITY"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("FALLEN_VAMPIRE_MIST_ABILITY"),oPC);
        flags|=2;
    }
    if((tempitem=GetItemPossessedBy(oPC,"FALLEN_VAMPIRE_REFUGE"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("FALLEN_VAMPIRE_REFUGE"),oPC);
        flags|=4;
    }
    if((tempitem=GetItemPossessedBy(oPC,"cub_umbra_1"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("cub_umbra_1"),oPC);
        flags|=8;
    }
    if((tempitem=GetItemPossessedBy(oPC,"cub_umbra_2"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("cub_umbra_2"),oPC);
        flags|=16;
    }
    if((tempitem=GetItemPossessedBy(oPC,"cub_umbra_3"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("cub_umbra_3"),oPC);
        flags|=32;
    }
    if((tempitem=GetItemPossessedBy(oPC,"cub_umbra_4"))!=OBJECT_INVALID){
        ActionTakeItem(GetObjectByTag("cub_umbra_4"),oPC);
        flags|=64;
    }
    SetLocalInt(oPC,"removeditems",flags);
}
