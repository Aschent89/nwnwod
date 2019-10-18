// Script for onHeartbeat in air plane.
// Makes debris fly and winds blow.
void main()
{
 // Flying debris setup
 effect visDebris = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
 effect Debris = EffectDamage(10,DAMAGE_TYPE_BLUDGEONING);
 object oPC = GetFirstObjectInArea();
 int Reflex;
 int DebrisTime = GetLocalInt(GetModule(),"nDebrisTime");
 if(DebrisTime == 18)
  {
   while(oPC != OBJECT_INVALID)
    {
     // Modify the number here to change the DC from 20 //
     Reflex = ReflexSave(oPC, 20);
     if(GetIsPC(oPC)==TRUE && Reflex == 0)
      {
       SendMessageToPC(oPC,"A flying piece of debris hits you.");
       ApplyEffectToObject(DURATION_TYPE_INSTANT,Debris,oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,visDebris,oPC);
      }
     oPC=GetNextObjectInArea();
    }
   DebrisTime = 0;
  }
 else DebrisTime = DebrisTime+6;
 SetLocalInt(GetModule(),"nDebrisTime",DebrisTime);
 // Finish debris.
 // Wind setup.
 effect Wind = EffectKnockdown();
 effect visWind = EffectVisualEffect(VFX_IMP_PULSE_WIND);
 oPC = GetFirstObjectInArea();
 int Fortitude;
 int WindTime = GetLocalInt(GetModule(),"nWindTime");
 if(WindTime==36)
  {
   while(oPC != OBJECT_INVALID)
    {
     // Modify the number here to change the DC from 30 //
     Fortitude = FortitudeSave(oPC, 30);
     if(GetIsPC(oPC)==TRUE && Fortitude == 0)
      {
       SendMessageToPC(oPC,"A strong gust of wind blows you down.");
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,Wind,oPC,6.0);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY,visWind,oPC,3.0);
      }
     oPC = GetNextObjectInArea();
    }
   WindTime=0;
  }
 else WindTime=WindTime+6;
 SetLocalInt(GetModule(),"nWindTime",WindTime);
 // End wind.
}
