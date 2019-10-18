////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Modlue Reload
//  ors_dm_modreload
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is called from opw_dm_switch
//
////////////////////////////////////////////////////////////////////////////////

void ReloadCount(object oMod)
{
   int nCount = GetLocalInt(oMod,"RELOADCOUNT");
   if(nCount == 0) nCount = 10;
   if(nCount > 1)
   {
     nCount = nCount - 1;
     SpeakString("Server restarting in: " +IntToString(nCount), TALKVOLUME_SHOUT);
   }
   else
   {
     ExportAllCharacters();
     string sMod = GetLocalString(oMod,"MODNAME");
     StartNewModule(sMod);
     return;
   }
   SetLocalInt(oMod,"RELOADCOUNT",nCount);
   DelayCommand(3.0,ReloadCount(oMod));
}

void main()
{
   object oMod = GetModule();
   DelayCommand(3.0,ReloadCount(oMod));
}
