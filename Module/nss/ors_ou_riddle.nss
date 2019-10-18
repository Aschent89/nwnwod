////////////////////////////////////////////////////////
//
//  LoME Switch Riddle
//  ors_ou_riddle
//  by Don Anderson
//  dandersonru@msn.com
//
//  Good for up to 8 Switches and Doors to Open
//  Will also make a Light on 8 Plates
//
////////////////////////////////////////////////////////

void ActivateSwitch()
{
   DelayCommand(0.1, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
   DelayCommand(10.0, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

void main()
{
  object oSwitch = OBJECT_SELF;
  object oPC = GetLastUsedBy();

  string sCode = "CODE";
  int nSSeq = GetLocalInt(oSwitch,"SEQ");
  object oCode = GetNearestObjectByTag(sCode,oSwitch);
  int nCSeq = GetLocalInt(oCode,"SEQ");

  //Animate
  ActivateSwitch();

  //Continue Sequence
  if((nSSeq - 1) == nCSeq)
  {
    //Make Light on Current Plate #
    string sPlate = "Plate"+IntToString(nSSeq);
    object oPlate = GetNearestObjectByTag(sPlate,oSwitch);
    string sLightTag = "Light"+sPlate;
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_solpurple",GetLocation(oPlate),FALSE,sLightTag);

    //Open a Door if there is one
    string sDoor = "Door"+IntToString(nSSeq);
    object oDoor = GetNearestObjectByTag(sDoor,oSwitch);
    if(GetIsObjectValid(oDoor)) ActionOpenDoor(oDoor);

    //Set Current Sequence
    SetLocalInt(oCode,"SEQ",nSSeq);
    return;
  }

  //Clear Sequence
  int nClear = 1;
  string sLight = "LightPlate";
  object oLight = GetNearestObjectByTag(sLight+IntToString(nClear),oSwitch,nClear);
  while(GetIsObjectValid(oLight))
  {
    DestroyObject(oLight);
    nClear++;
    oLight = GetNearestObjectByTag(sLight+IntToString(nClear),oSwitch,nClear);
  }
  SetLocalInt(oCode,"SEQ",0);

}
