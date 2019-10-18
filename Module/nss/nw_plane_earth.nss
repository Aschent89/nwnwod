// Script for onHeartbeat in earth plane.
// Makes rocks fall and the earth shake.
void main()
{
 // Falling rocks setup
 effect visAfterT = EffectVisualEffect(VFX_FNF_SCREEN_BUMP);
 effect visRocks = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
 effect Rocks = EffectDamage(10,DAMAGE_TYPE_BLUDGEONING);
 object oPC = GetFirstObjectInArea();
 int Reflex;
 int RocksTime = GetLocalInt(GetModule(),"nRocksTime");
 if(RocksTime == 18)
  {
   while(oPC != OBJECT_INVALID)
    {
     // Modify the number here to change the DC from 30 //
     Reflex = ReflexSave(oPC, 30);
     if(GetIsPC(oPC)==TRUE && Reflex == 0)
      {
       SendMessageToPC(oPC,"A falling rock hits you.");
       ApplyEffectToObject(DURATION_TYPE_INSTANT,Rocks,oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,visRocks,oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,visAfterT,oPC,2.0);
      }
     oPC=GetNextObjectInArea();
    }
   RocksTime = 0;
  }
 else RocksTime = RocksTime+6;
 SetLocalInt(GetModule(),"nRocksTime",RocksTime);
 // Finish rocks.
 // Tremor setup.
 effect Tremor = EffectKnockdown();
 effect visTremor = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
 oPC = GetFirstObjectInArea();
 int TremorTime = GetLocalInt(GetModule(),"nTremorTime");
 if(TremorTime==36)
  {
   while(oPC != OBJECT_INVALID)
    {
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,visTremor,oPC,2.0);
     DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,visAfterT,oPC,2.0));
     // Modify the number here to change the DC from 30 //
     Reflex = ReflexSave(oPC, 30);
     if(GetIsPC(oPC)==TRUE && Reflex == 0)
      {
       SendMessageToPC(oPC,"A sudden tremor knocks you to the ground.");
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,Tremor,oPC,6.0);
      }
     oPC = GetNextObjectInArea();
    }
   TremorTime=0;
  }
 else TremorTime=TremorTime+6;
 SetLocalInt(GetModule(),"nTremorTime",TremorTime);
 // End tremor.
}
