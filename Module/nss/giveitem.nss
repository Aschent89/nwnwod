void main()
{
    object oPC=GetExitingObject();
    int flags=GetLocalInt(oPC,"removeditems");
    if((flags&1)==1){
        ActionGiveItem(GetObjectByTag("FALLEN_VAMPIRE_BAT_ABILITY"),oPC);
    }
    if((flags&1)==2){
        ActionGiveItem(GetObjectByTag("FALLEN_VAMPIRE_MIST_ABILITY"),oPC);
    }
    if((flags&1)==4){
        ActionGiveItem(GetObjectByTag("FALLEN_VAMPIRE_REFUGE"),oPC);
    }
    if((flags&1)==8){
        ActionGiveItem(GetObjectByTag("cub_umbra_1"),oPC);
    }
    if((flags&1)==16){
        ActionGiveItem(GetObjectByTag("cub_umbra_2"),oPC);
    }
    if((flags&1)==32){
        ActionGiveItem(GetObjectByTag("cub_umbra_3"),oPC);
    }
    if((flags&1)==64){
        ActionGiveItem(GetObjectByTag("cub_umbra_4"),oPC);
    }
    DeleteLocalInt(oPC,"removeditem");
}
