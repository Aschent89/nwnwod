////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_getmarkinfo
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  string message;
  object oPC=GetPCSpeaker();
  object oTarg=GetLocalObject(oPC,"targ"+IntToString(GetLocalInt(oPC,"convtarg")));
  int jewelryvalue=0;
  int pcAppraise=GetSkillRank(SKILL_APPRAISE,oPC);
  int pcPick=GetSkillRank(SKILL_PICK_POCKET,oPC);
  int easyvalue=GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_HEAD,oTarg))+GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CHEST,oTarg))
  +GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_CLOAK,oTarg));


  if(pcAppraise>4)
  {
    jewelryvalue= GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_LEFTRING,oTarg))+
    GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarg)) + GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_NECK,oTarg));
  }

  int spot=GetSkillRank(SKILL_SPOT,oTarg);
  int base;
  int surfacevalue;
  if(GetIsNeutral(oTarg,oPC))
  {
    base=20;
  }
  else
  {
    base=30;
    spot+=10;
  }

  base+=spot;

  string alert;
  string jewel;
  string clothing;
  string overall;

  if(spot>20)alert="This person is extremely alert, almost to the point of being nervous.\n";
  else if(spot>10)alert="This person is unusually alert.\n";
  else if(spot>5)alert="This person is moderately alert.\n";
  else alert="This person does not seem very alert.\n";

  if(easyvalue>1120-(pcAppraise*3))clothing="This person is dressed in extremely valuable clothing.\n";
  else if(easyvalue>600-(pcAppraise*3))clothing="This person is wearing very valuable clothing.\n";
  else if(easyvalue>100-(pcAppraise*3))clothing="This person is wearing good clothing.\n";
  else clothing="This person's clothing does not appear to be worth much.\n";

  if(jewelryvalue>3000-(pcAppraise*3))jewel="This person's jewelry is powerfully enchanted and extremely valuable.\n";
  else if(jewelryvalue>1500-(pcAppraise*3))jewel="This person's jewelry is probably magical, and is quite valuable.\n";
  else if(jewelryvalue>500-(pcAppraise*3))jewel="This person's jewelry probably carries mediocre enchantments, not unvaluable however.\n";
  else jewel="You cannot appraise the value of his jewelry well, it may not be worth much.\n";

  if(base>pcPick+30)overall="This person would prove a very difficult mark indeed.\n";
  if(base>pcPick+15)overall="It would be tough to pick this person's pockets.\n";
  if(base>pcPick+10)overall="This person would make reasonable mark. 50/50.\n";
  else overall="This person would be an easy mark.\n";

  string gold="";
  if(pcAppraise>1)
  {
    int goldamt=GetGold(oTarg);
    if(goldamt>20000)gold="This person's money bags are bulging to the point of explosion.\n";
    else if(goldamt>10000)gold="This person is carrying far too much coin to be safe.\n";
    else if(goldamt>3000)gold="This person is carrying plenty of coin.\n";
    else gold="This person is carrying a decent amount of coin.\n";
  }

  message=alert+clothing+jewel+gold+overall;

  SetCustomToken(7008,message);
}
