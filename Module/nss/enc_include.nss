#include "_sh_inc_list1"

////////////////////////////////////////////////////////////////////////////////
//                       Spawn Encounter constants                            //
////////////////////////////////////////////////////////////////////////////////

const int EVENT_ENCOUNTER_ON_ENTER                     = 400;
const int EVENT_ENCOUNTER_ON_EXHAUSTED                 = 401;
const int EVENT_ENCOUNTER_ON_INIT                      = 402;

////////////////////////////////////////////////////////////////////////////////
//                        Spawn Encounter functions                           //
////////////////////////////////////////////////////////////////////////////////

//sets minimum ammount of npcs that will be spawned
void EncounterSetMinSpawnedCreatures(object oEncounter, int nMin);

//sets maximum ammount of npcs that will be spawned
void EncounterSetMaxSpawnedCreatures(object oEncounter, int nMax);

//sets alternative OnEnter script
void EncounterSetOnEnterScript(object oEncounter, string sScript);

//sets alternative OnExhausted script
void EncounterSetOnExhaustedScript(object oEncounter, string sScript);

////////////////////////////////////////////////////////////////////////////////
//                             System functions                               //
////////////////////////////////////////////////////////////////////////////////

//disables the specified group to be chosen for spawning
void EncounterDisableSpawnGroup(int nGroup);

//sets the spawn encounter to active/deactive
void EncounterSetStatus(object oEncounter, int nStatus=TRUE);

//returns TRUE if the spawn encounter status is active
int EncounterGetIsActive(object oEncounter);

//enables the specified group to be chosen for spawning
void EncounterEnableSpawnGroup(int nGroup);

////////////////////////////////////////////////////////////////////////////////
//                    Functions for spawn encounter settings                  //
////////////////////////////////////////////////////////////////////////////////

//number of seconds the spawn encounter will be inactiave after killing last npc
void EncounterSetRespawn(int nRespawn);

//creates a spawn waypoint on coordinates X and Y
void EncounterSetSpawnPoint(int X, int Y);

//nGroup: number of group you want to change this for
//MaxNPC: maximal ammount of npcs that spawn encounter spawns
//MinNPC: minimal ammount of npcs that spawn encounter spawns
void EncounterSetMaxMinNPCForGroup(int nGroup, int MaxNPC, int MinNPC=1);

//nGroup: number of group you want to change this for
//nNPC: number of the npc you want to change this for, according to the order in the spawn group, ie.
//if the spawn group is defined as "zombie2,zombie3" then zombie2 is NPC no. 1 and zombie3 no. 2
//nMin: minimal ammount this npc will be spawned with
//nMax: maximal ammount this npc will be spawned with, 0 means unlimited (but it still cannot exceed
//max ammount NPCs defined by spawn group itself)
void EncounterSetMaxMinNPCForGroupSpecific(int nGroup, int nNPC, int nMin, int nMax=0);

//NPC1-10: resref of the npc
//specificy number of resrefs you need, no need to specify all 10
//examples:
//EncounterNastavSpawnSkupinu("zombie1");
//EncounterNastavSpawnSkupinu("zombie1","zombie2","zombie3","zombie4"); etc.
//this will automatically assign group number to the group to be +1 of the last group defined already
//therefore if this the above lines are used on undefined spawn encounter then group1 will be "zombie1"
//and group2 will be "zombie1,zombie2,zombie3,zombie4"
void EncounterAddSpawnGroup(string NPC1="", string NPC2="", string NPC3="", string NPC4="", string NPC5="", string NPC6="", string NPC7="", string NPC8="", string NPC9="", string NPC10="");

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
void EncounterSetMinSpawnedCreatures(object oEncounter, int nMin)
{
    SetLocalInt(oEncounter,"Min",nMin);
}

void EncounterSetMaxSpawnedCreatures(object oEncounter, int nMax)
{
    SetLocalInt(oEncounter,"Max",nMax);
}

void EncounterSetOnEnterScript(object oEncounter,string sScript)
{
    SetLocalString(oEncounter,"OnEnter",sScript);
}

void EncounterSetOnExhaustedScript(object oEncounter,string sScript)
{
    SetLocalString(oEncounter,"OnExhausted",sScript);
}

void EncounterDisableSpawnGroup(int nGroup)
{
    string sVarName = "EncounterDisableSpawnGroup_"+IntToString(nGroup);
    if(!GetLocalInt(OBJECT_SELF,sVarName))
    {
        SetLocalInt(OBJECT_SELF,sVarName,TRUE);
        DelayCommand(0.2,DeleteLocalInt(OBJECT_SELF,sVarName));
    }
}

void EncounterEnableSpawnGroup(int nGroup)
{
    DeleteLocalInt(OBJECT_SELF,"EncounterDisableSpawnGroup_"+IntToString(nGroup));
}

int EncounterGetIsActive(object oEncounter)
{
    return !GetLocalInt(oEncounter,"Active");
}

void EncounterSetStatus(object oEncounter, int nStatus=TRUE)
{
    SetLocalInt(oEncounter,"Active",!nStatus);
}

void EncounterSetRespawn(int nRespawn)
{
    SetLocalInt(OBJECT_SELF,"Respawn",nRespawn);
}

void EncounterSetSpawnPoint(int X, int Y)
{
    int nTh = GetLocalInt(OBJECT_SELF,"NUM_SPAWN_POINT")+1;
    object oWP = CreateObject(OBJECT_TYPE_WAYPOINT,"enc_wp",Location(GetArea(OBJECT_SELF),Vector(IntToFloat(X),IntToFloat(Y)),0.0),FALSE,GetTag(OBJECT_SELF)+"_WP"+IntToString(nTh));
    if(GetIsObjectValid(oWP))
    {
        SetLocalInt(OBJECT_SELF,"NUM_SPAWN_POINT",nTh);
    }
}

void EncounterAddSpawnGroup(string NPC1="", string NPC2="", string NPC3="", string NPC4="", string NPC5="", string NPC6="", string NPC7="", string NPC8="", string NPC9="", string NPC10="")
{
    int nGroup = GetLocalInt(OBJECT_SELF,"NUM_SPAWN_GROUPS")+1;
    SetLocalInt(OBJECT_SELF,"NUM_SPAWN_GROUPS",nGroup);
    string sVarName = "NPC_GROUP_"+IntToString(nGroup);
    string sNPC = NPC1;
    int n = 1;
    while(sNPC != "")
    {
        ListAddString(OBJECT_SELF,sVarName,sNPC);
        switch(++n)
        {
        case 2: sNPC = NPC2; break;
        case 3: sNPC = NPC3; break;
        case 4: sNPC = NPC4; break;
        case 5: sNPC = NPC5; break;
        case 6: sNPC = NPC6; break;
        case 7: sNPC = NPC7; break;
        case 8: sNPC = NPC8; break;
        case 9: sNPC = NPC9; break;
        case 10:sNPC = NPC10; break;
        default: sNPC = ""; break;
        }
    }
}

void EncounterSetMaxMinNPCForGroupSpecific(int nGroup, int nNPC, int nMin, int nMax=0)
{
    string sVarName = "NPC_GROUP_"+IntToString(nGroup);
    if(nMax > 0)
    {
        ListSetIntArray(OBJECT_SELF,sVarName,nNPC,2,nMax);
    }
    ListSetIntArray(OBJECT_SELF,sVarName,nNPC,1,nMin);
}

void EncounterSetMaxMinNPCForGroup(int nGroup, int MaxNPC, int MinNPC=1)
{
    SetLocalInt(OBJECT_SELF,"MIN_GROUP_"+IntToString(nGroup),MinNPC);
    SetLocalInt(OBJECT_SELF,"MAX_GROUP_"+IntToString(nGroup),MaxNPC);
}

void Despawn()
{
    if(!GetIsObjectValid(OBJECT_SELF) || (GetIsObjectValid(GetMaster(OBJECT_SELF)) && GetIsPC(GetMaster(OBJECT_SELF))))
    {
        return;
    }
    if(GetIsInCombat(OBJECT_SELF))
    {
        DelayCommand(240.0,Despawn());
    }
    else
    {
        object oEncounter = GetLocalObject(OBJECT_SELF,"ENCOUNTER_FROM");
        int nAlive = GetLocalInt(oEncounter,"NUM_SPAWNED_CREATURES_ALIVE")-1;
        if(nAlive < 1)//OnExhausted!
        {
            SetLocalInt(oEncounter,"NUM_SPAWNED_CREATURES_ALIVE",0);
            SetLocalObject(oEncounter,"LAST_KILLER",OBJECT_INVALID);
            ExecuteScript("enc_exhausted",oEncounter);
        }
        else
        {
            SetLocalInt(oEncounter,"NUM_SPAWNED_CREATURES_ALIVE",nAlive);
        }
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), OBJECT_SELF);
        DestroyObject(OBJECT_SELF);
    }
}

//private
void SpawnCreatures(object oEntering, object oObject = OBJECT_SELF)
{              if(GetTag(oObject) == "debugspawn")SpawnScriptDebugger();
    int n, nCould, nCount = GetLocalInt(oObject,"NUM_SPAWN_GROUPS");
///////////////////////spawn group selection////////////////////////////////////
    while(n < nCount)
    {
        if(GetLocalInt(OBJECT_SELF,"EncounterDisableSpawnGroup_"+IntToString(++n)) < 1)
        {
            ListAddInt(oObject,"GROUPS_FOR_SPAWN",n);
            nCould++;
        }
    }
    if(!nCould)
    {
        if(GetLocalInt(oObject,"DISABLE_SPAWN_IF_NO_GROUP_SPAWN"))
        {
            SetLocalInt(oObject,"DISABLE_SPAWN_IF_NO_GROUP_SPAWN",0);
            ExecuteScript("enc_exhausted",oObject);
        }
        else
        {
            EncounterSetStatus(oObject,TRUE);
        }
        return;
    }
    else if(nCould != 1)
    {
        nCould = Random(nCould)+1;
    }
////////////////////////////////////////////////////////////////////////////////
    int nGroup = ListGetInt(oObject,"GROUPS_FOR_SPAWN",nCould);
    string snGroup = IntToString(nGroup);
////////////////////////////////////////////////////////////////////////////////
    SetLocalInt(oObject,"LAST_SPAWNED_GROUP",nGroup);
    ListDestroy(oObject,"GROUPS_FOR_SPAWN");
///////////////////////////urceni kolik NPC spawn vyplivne//////////////////////
    int nMax = GetLocalInt(oObject,"MAX_GROUP_"+snGroup);
    int nMin = GetLocalInt(oObject,"MIN_GROUP_"+snGroup);
////////////////////////////////////////////////////////////////////////////////
    int nSpawnCount;
////////////////////////////////////////////////////////////////////////////////
    if(nMax > nMin)
    {
        nSpawnCount = Random(nMax-nMin+1)+nMin;
        if(nSpawnCount < 1)
        {
            nSpawnCount = 1;
        }
    }
    else
    {
        if(nMin)//nMin==nMax || nMin>nMax
        {
            nSpawnCount = nMin;
        }
        else//nMax<=0 && nMin<=0
        {
            nSpawnCount = d2();
        }
    }
/////////////////////////determining spawn points///////////////////////////////
    nCount = GetLocalInt(oObject,"NUM_SPAWN_POINT");
    string sVarName = GetTag(oObject)+"_WP";
    float fDistance, fFarthest;
    int bClosest = GetLocalInt(oObject,"USE_NEAREST_WP"); if(bClosest) fFarthest = 99.0;
    int bRandom = GetLocalInt(oObject,"USE_RANDOM_WP");
    if(bRandom)
    {
        nCould = Random(nCount);
    }
    else
    {
        for(n=0;n < nCount;n++)
        {
            fDistance = GetDistanceBetween(oEntering,GetObjectByTag(sVarName,n));
            if(bClosest)
            {
                if(fDistance < fFarthest)
                {
                    nCould = n;
                    fFarthest = fDistance;
                }
            }
            else if(fFarthest < fDistance)
            {
                nCould = n;
                fFarthest = fDistance;
            }
        }
    }
////////////////////////////////////////////////////////////////////////////////
    location lWhere;
////////////////////////////////////////////////////////////////////////////////
    if(!nCount)
    {
        WriteTimestampedLogEntry("SPAWN SYSTEM WARNING: spawn trigger "+GetTag(oObject)+" in area "+GetName(GetArea(oObject))+": doesn't have spawn point set!");
        lWhere = GetLocation(oEntering);
    }
    else
    {
        lWhere = GetLocation(GetObjectByTag(sVarName,nCould));
    }
/////////////////determining how many and which npcs will be spawned////////////
    sVarName = "NPC_GROUP_"+snGroup;
    string sNPC = ListGetString(oObject,sVarName,1);
    int nAlways;
    nMax = ListGetElementCount(oObject,sVarName);
    n = 1;
    nCount = 0;
    while(sNPC != "")
    {
        nAlways = GetLocalInt(oObject,"MIN_GROUP_"+snGroup+"_"+IntToString(n));
        if(nAlways)
        {
            nCount+= nAlways;
            ListSetInt(oObject,sVarName,n,nAlways);
        }
        sNPC = ListGetString(oObject,sVarName,++n);
    }
    if(nCount < nSpawnCount)//nCount = number of always spawning npcs is less than total number of npcs we want to spawn
    {
        n = 0;
        nCould = nSpawnCount-nCount;//remaining number of npcs to be spawned
        while(nCould > 0)
        {
            if(n++ < nMax)//loop all list members
            {
                nAlways = ListGetInt(oObject,sVarName,n);//whether and how many times to sppawn
                nCount = GetLocalInt(oObject,"MAX_GROUP_"+snGroup+"_"+IntToString(n));//maximum npcs that can be spawned
                if(nCount > 0)//if maximum is set
                {
                    if(nAlways >= nCount)//maximum reached or exceeded
                    {
                        continue;
                    }
                    else
                    {
                        nCount-= nAlways;//maximum npcs we can yet to add
                    }
                }
                nMin = Random(nCould+1);
                if(nMin)
                {
                    if(nCount > 0 && nMin > nCount)
                    {
                        nMin = nCount;
                    }
                    ListSetInt(oObject,sVarName,n,nAlways+nMin);
                }
                nCould-= nMin;
            }
            else
            {
                n = 0;
            }
        }
    }
    else if(nCount > nSpawnCount)
    {
        //number of always spawning NPCs is greater than max number of npcs group can spawn
        //assumming builders intent, ignoring this
    }
//////////////////////////the actual spawning process///////////////////////////
    n = 0;
    nCount = 0;
    nCould = GetLocalInt(oObject,"SPAWN_VFX");
    int despawn = GetLocalInt(oObject,"Despawn");
    string script;
    object oNPC;
    location l;
    while(n++ < nMax)
    {
        sNPC = ListGetString(oObject,sVarName,n);
        nAlways = ListGetInt(oObject,sVarName,n);
        ListSetInt(oObject,sVarName,n,0);
        if(sNPC != "" && nAlways)//sanity check
        {
            oNPC = GetLocalObject(oObject,"WP_GROUP_"+snGroup+"_"+IntToString(n));
            if(oNPC != OBJECT_INVALID)
            {
                l = GetLocation(oNPC);
            }
            else
            {
                l = lWhere;
            }
            for(nMin=0;nMin++ < nAlways;)
            {
                oNPC = CreateObject(OBJECT_TYPE_CREATURE,sNPC,l);
                if(GetIsObjectValid(oNPC))
                {
                    if(nCould)
                    {
                        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(nCould),GetLocation(oNPC));
                    }
                    if(despawn)
                    {
                        AssignCommand(oNPC, DelayCommand(IntToFloat(despawn), Despawn()));
                    }
                    script = GetEventScript(oNPC,EVENT_SCRIPT_CREATURE_ON_DEATH);
                    SetEventScript(oNPC,EVENT_SCRIPT_CREATURE_ON_DEATH,"enc_npcdeath");
                    SetLocalString(oNPC,"ORIGINAL_SCRIPT_ONDEATH",script);
                    SetLocalInt(oNPC,"GET_IS_FROM_ENCOUNTER",TRUE);
                    SetLocalObject(oNPC,"ENCOUNTER_FROM",oObject);
                    nCount++;
                }
                else
                {
                    WriteTimestampedLogEntry("SPAWN SYSTEM WARNING: spawn trigger "+GetTag(oObject)+" in area "+GetName(GetArea(oObject))+": invlid creature resref : "+sNPC);
                }
            }
        }
    }
    SetLocalInt(oObject,"NUM_SPAWNED_CREATURES_ALIVE",nCount);
    if(GetLocalInt(oObject,"GROUP_RESPAWN_"+snGroup))
    {
        DeleteLocalInt(oObject,snGroup+"_GROUP_SPAWN_DONE");
    }
    nCould = GetLocalInt(oObject,"NUM_TIMES_SPAWNED")+1;
    SetLocalInt(oObject,"NUM_TIMES_SPAWNED",nCould);
    sVarName = "LIMIT_GROUP_"+snGroup;
    nCould = GetLocalInt(oObject,sVarName);
    if(nCould-- > 0)
    {
        SetLocalInt(oObject,sVarName,nCould);
        if(nCould < 1)
        {
            EncounterDisableSpawnGroup(nGroup);
        }
    }
}

void SpawnInitialize()
{
    SetLocalInt(OBJECT_SELF,"SPAWN_INITIALIZED",TRUE);
    int nTh;
    string sTag,wpTag = GetTag(OBJECT_SELF)+"_WP";
    object oWP = GetObjectByTag(wpTag,nTh);
    while(GetIsObjectValid(oWP))
    {
        oWP = GetObjectByTag(wpTag,++nTh);
    }
    if(nTh > 0)//waypointy nastavene rucne
    {
        SetLocalInt(OBJECT_SELF,"NUM_SPAWN_POINT",nTh);
    }
    nTh = 1;
    sTag = GetLocalString(OBJECT_SELF,"NPC_GROUP_1");
    string s1,s2,s3,s4,s5,s6,s7,s8,s9,s10;
    int nPos,nPosNext;
    while(sTag != "")
    {
        if(GetStringRight(sTag,1) != ",")
        {
            sTag+= ",";
        }
        s1 = "";
        s2 = "";
        s3 = "";
        s4 = "";
        s5 = "";
        s6 = "";
        s7 = "";
        s8 = "";
        s9 = "";
        s10 = "";
        nPos = FindSubString(sTag,",",0);
        if(nPos > -1)
        {
            s1 = GetSubString(sTag,0,nPos);
            nPosNext = FindSubString(sTag,",",++nPos);
            if(nPosNext > -1)
            {
                s2 = GetSubString(sTag,nPos,nPosNext-nPos);
                nPos = nPosNext;
                nPosNext = FindSubString(sTag,",",++nPos);
                if(nPosNext > -1)
                {
                    s3 = GetSubString(sTag,nPos,nPosNext-nPos);
                    nPos = nPosNext;
                    nPosNext = FindSubString(sTag,",",++nPos);
                    if(nPosNext > -1)
                    {
                        s4 = GetSubString(sTag,nPos,nPosNext-nPos);
                        nPos = nPosNext;
                        nPosNext = FindSubString(sTag,",",++nPos);
                        if(nPosNext > -1)
                        {
                            s5 = GetSubString(sTag,nPos,nPosNext-nPos);
                            nPos = nPosNext;
                            nPosNext = FindSubString(sTag,",",++nPos);
                            if(nPosNext > -1)
                            {
                                s6 = GetSubString(sTag,nPos,nPosNext-nPos);
                                nPos = nPosNext;
                                nPosNext = FindSubString(sTag,",",++nPos);
                                if(nPosNext > -1)
                                {
                                    s7 = GetSubString(sTag,nPos,nPosNext-nPos);
                                    nPos = nPosNext;
                                    nPosNext = FindSubString(sTag,",",++nPos);
                                    if(nPosNext > -1)
                                    {
                                        s8 = GetSubString(sTag,nPos,nPosNext-nPos);
                                        nPos = nPosNext;
                                        nPosNext = FindSubString(sTag,",",++nPos);
                                        if(nPosNext > -1)
                                        {
                                            s9 = GetSubString(sTag,nPos,nPosNext-nPos);
                                            nPos = nPosNext;
                                            nPosNext = FindSubString(sTag,",",++nPos);
                                            if(nPosNext > -1)
                                            {
                                                s10 = GetSubString(sTag,nPos,nPosNext-nPos);
                                                nPos = nPosNext;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        DeleteLocalString(OBJECT_SELF,"NPC_GROUP_"+IntToString(nTh));
        EncounterAddSpawnGroup(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);
        sTag = GetLocalString(OBJECT_SELF,"NPC_GROUP_"+IntToString(++nTh));
    }
    nPos = GetLocalInt(OBJECT_SELF,"NUM_SPAWN_GROUPS");
    int n;
    for(n;n++ < nPos;)
    {
        for(nTh=1;nTh < 11;)
        {
            s1 = IntToString(n);
            sTag = "WP_GROUP_"+s1+"_"+IntToString(nTh++);
            nPosNext = GetLocalInt(OBJECT_SELF,sTag);
            if(nPosNext > 0)
            {
                DeleteLocalInt(OBJECT_SELF,sTag);
                oWP = GetWaypointByTag(wpTag+IntToString(nPosNext));
                if(oWP == OBJECT_INVALID)
                {
                    PrintString("SPAWN SYSTEM ERROR: Cannot find the waypoint "+wpTag+IntToString(nPosNext)+"; encounter: "+GetTag(OBJECT_SELF));
                }
                else
                {
                    SetLocalObject(OBJECT_SELF,sTag,oWP);
                }
            }
        }
    }
    if(GetLocalString(OBJECT_SELF,"OnInit") != "")
    {
        //custom OnEnter script set by user
        ExecuteScript(GetLocalString(OBJECT_SELF,"OnInit"),OBJECT_SELF);
    }
    SignalEvent(OBJECT_SELF,EventUserDefined(EVENT_ENCOUNTER_ON_INIT));
    if(GetIsObjectValid(GetObjectByTag(GetTag(OBJECT_SELF),1)))
    {
        WriteTimestampedLogEntry("SPAWN SYSTEM WARNING: spawn trigger "+GetTag(OBJECT_SELF)+" in area "+GetName(GetArea(OBJECT_SELF))+": doesn't have unique tag!");
    }
}
