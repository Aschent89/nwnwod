////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Export All Characters
//  ors_pcexport
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Module User Defined Event
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  ExportAllCharacters();
  //SpeakString("LoME is Saving all characters...", TALKVOLUME_SHOUT);

  //Improved Shifter and Druid Wildshape Script By Iznoghoud
  object oPC = GetFirstPC();
  while(GetIsObjectValid(oPC))
  {
    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC)))
    {
      DelayCommand(0.1, ExecuteScript("ws_saveall_sub", oPC));
    }
    oPC = GetNextPC();
  }
}
