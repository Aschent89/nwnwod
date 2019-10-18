////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_cls_cleric
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

void ApplyBlessing(object oTarg,int blessingnumber)
{
  string message="Your deity has granted you ";
  int clericlevel=GetLevelByClass(CLASS_TYPE_CLERIC,oTarg);

  if(blessingnumber > 97)
  {
    SendMessageToAllDMs(GetName(oTarg)+" has been granted DIVINE INTERVENTION!");
    object oMember;
    message="Your deity has granted you its DIVINE INTERVENTION!";
    switch(d3())
    {
      case 1:
        oMember=GetFirstFactionMember(oTarg,TRUE);
        while(oMember!=OBJECT_INVALID)
        {
          ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oMember,0.0);
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSanctuary(40),oMember,60.0);
          GetNextFactionMember(oTarg,TRUE);
        }
        break;

      case 2:
        oMember=GetFirstFactionMember(oTarg,TRUE);
        while(oMember!=OBJECT_INVALID)
        {
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(3*(clericlevel/4),5.0),oTarg,(40.0*clericlevel));
          GetNextFactionMember(oTarg,TRUE);
        }
        break;

      case 3:
        oMember=GetFirstFactionMember(oTarg,TRUE);
        while(oMember!=OBJECT_INVALID)
        {
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectModifyAttacks(2),oTarg,(40.0*clericlevel));
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectHaste(),oTarg,(40.0*clericlevel));
          GetNextFactionMember(oTarg,TRUE);
        }
        break;
    }
  }

  if(blessingnumber>90)
  {
    message+="a miracle!";
    switch(d4())
    {
      case 1:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,clericlevel/4),oTarg,(30.0*clericlevel)); break;
      case 2:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConcealment(4*(clericlevel/3),MISS_CHANCE_TYPE_NORMAL),oTarg,(30.0*clericlevel));  break;
      case 3:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectHaste(),oTarg,(30.0*clericlevel));  break;
      case 4:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(3*(clericlevel/4),5.0),oTarg,(40.0*clericlevel));  break;
    }
  }
  else if(blessingnumber>70)
  {
    message+="aid!";
    switch(d4())
    {
      case 1:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,clericlevel/5),oTarg,(30.0*clericlevel)); break;
      case 2:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConcealment(2*(clericlevel/3),MISS_CHANCE_TYPE_NORMAL),oTarg,(30.0*clericlevel));  break;
      case 3:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectHaste(),oTarg,(15.0*clericlevel));  break;
      case 4:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(3*(clericlevel/5),20.0),oTarg,(40.0*clericlevel));  break;
    }
  }
  else if(blessingnumber>40)
  {
    message+="a blessing!";
    switch(d4())
    {
      case 1:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityIncrease(ABILITY_WISDOM,clericlevel/6),oTarg,(30.0*clericlevel)); break;
      case 2:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectConcealment(1*(clericlevel/4),MISS_CHANCE_TYPE_NORMAL),oTarg,(30.0*clericlevel));  break;
      case 3:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectHaste(),oTarg,(10.0*clericlevel));  break;
      case 4:ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectRegenerate(2*(clericlevel/5),30.0),oTarg,(40.0*clericlevel));  break;
    }
  }
  else
  {
    message+="an answer to your prayer.";
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSavingThrowIncrease(SAVING_THROW_ALL,1),oTarg,(40.0*clericlevel));
  }

  SendMessageToPC(oTarg,message);
}

void main()
{
  object oPC=GetPCSpeaker();

  string message;

  int blesscap=3;

  if(GetLevelByClass(CLASS_TYPE_CLERIC,oPC)>=15) blesscap=0;
  if(GetLocalInt(oPC,"prayed")!=TRUE)
  {
    SetLocalInt(oPC,"prayed",TRUE);
    DelayCommand(1800.0,SetLocalInt(oPC,"prayed",FALSE));
    DelayCommand(15.1,ApplyBlessing(oPC,d100()-blesscap));
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0,15.0));
    SetCutsceneMode(oPC,TRUE);
    SetPlotFlag(oPC,FALSE);
    DelayCommand(15.1,SetCutsceneMode(oPC,FALSE));
  }
  else
  {
    message="Your deity tells you: 'maybe later, I have my hands full at the moment'.";
    SendMessageToPC(oPC,message);
  }
}
