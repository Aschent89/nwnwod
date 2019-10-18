////////////////////////////////////////////////////////////////////////////////
//  King of the Hill
//  ors_inc_koh
//  By Don Anderson
//  dandersonru@msn.com
//
////////////////////////////////////////////////////////////////////////////////

void KoH_SetPCBlueTeam(object oPC)
{
  object oTeam = GetItemPossessedBy(oPC,"KoH_BlueTeam");
  if(!GetIsObjectValid(oTeam))
  {
    //Create Team Item on Player
    CreateItemOnObject("koh_blueteam",oPC);
  }
}

void KoH_SetPCRedTeam(object oPC)
{
  object oTeam = GetItemPossessedBy(oPC,"KoH_RedTeam");
  if(!GetIsObjectValid(oTeam))
  {
    //Create Team Item on Player
    CreateItemOnObject("koh_redteam",oPC);
  }
}

void KoH_RemovePCTeam(object oPC)
{
  object oBlueTeam = GetItemPossessedBy(oPC,"KoH_BlueTeam");
  if(GetIsObjectValid(oBlueTeam)) DestroyObject(oBlueTeam);
  object oRedTeam = GetItemPossessedBy(oPC,"KoH_RedTeam");
  if(GetIsObjectValid(oRedTeam)) DestroyObject(oRedTeam);
}

int KoH_TeamNumber(object oPC)
{
  //Check Team Items
  object oBlueTeam = GetItemPossessedBy(oPC,"KoH_BlueTeam");
  object oRedTeam = GetItemPossessedBy(oPC,"KoH_RedTeam");

  if(GetIsObjectValid(oBlueTeam)) return 1;
  if(GetIsObjectValid(oRedTeam)) return 2;

  return 0;
}

//void main(){}
