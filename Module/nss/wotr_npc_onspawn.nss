#include "aps_include"
#include "tokenizer_inc"

void main()
{
    string name = "";
    string myProf = "Commoner";

    string mytag = GetTag(OBJECT_SELF);
    string resref = GetResRef(OBJECT_SELF);
    location loc = GetLocation(OBJECT_SELF);
    string areatag = GetTag(GetArea(OBJECT_SELF));

    SQLExecDirect("select name,profession from npc_state where tag='"+mytag+"'");
    if(SQLFetch()==SQL_SUCCESS) {
        name = SQLGetData(1);
        myProf = SQLGetData(2);

        SetName(OBJECT_SELF,name);
        SQLExecDirect("update npc_state set resref='"+resref+"', location='"+APSLocationToString(loc)+"', area='"+areatag+"' where tag='"+mytag+"'");
    }
    else
    {
        int race = GetRacialType(OBJECT_SELF);
        switch(race) {
            case RACIAL_TYPE_HUMAN:
                    {
                    string first = "";
                    switch(GetGender(OBJECT_SELF)) {
                        case GENDER_FEMALE:
                                first = RandomName(NAME_FIRST_HUMAN_FEMALE);
                                break;
                        case GENDER_MALE:
                                first = RandomName(NAME_FIRST_HUMAN_MALE);
                                break;
                    }
                    string last = RandomName(NAME_LAST_HUMAN);
                    name = first+" "+last;
                    SetName(OBJECT_SELF,name);
                    break;
                    }
            case RACIAL_TYPE_HALFELF:
                    {
                    string first = "";
                    switch(GetGender(OBJECT_SELF)) {
                        case GENDER_FEMALE:
                                first = RandomName(NAME_FIRST_ELF_FEMALE);
                                break;
                        case GENDER_MALE:
                                first = RandomName(NAME_FIRST_ELF_MALE);
                                break;
                    }
                    string last = RandomName(NAME_LAST_ELF);
                    name = first+" "+last;
                    SetName(OBJECT_SELF,name);
                    break;
                    }
            case RACIAL_TYPE_ELF:
                    {
                    string first = "";
                    switch(GetGender(OBJECT_SELF)) {
                        case GENDER_FEMALE:
                                first = RandomName(NAME_FIRST_ELF_FEMALE);
                                break;
                        case GENDER_MALE:
                                first = RandomName(NAME_FIRST_ELF_MALE);
                                break;
                    }
                    string last = RandomName(NAME_LAST_ELF);
                    name = first+" "+last;
                    SetName(OBJECT_SELF,name);
                    break;
                    }
            case RACIAL_TYPE_DWARF:
                    {
                    string first = "";
                    switch(GetGender(OBJECT_SELF)) {
                        case GENDER_FEMALE:
                                first = RandomName(NAME_FIRST_DWARF_FEMALE);
                                break;
                        case GENDER_MALE:
                                first = RandomName(NAME_FIRST_DWARF_MALE);
                                break;
                    }
                    string last = RandomName(NAME_LAST_DWARF);
                    name = first+" "+last;
                    SetName(OBJECT_SELF,name);
                    break;
                    }
            case RACIAL_TYPE_HALFLING:
                    {
                    string first = "";
                    switch(GetGender(OBJECT_SELF)) {
                        case GENDER_FEMALE:
                                first = RandomName(NAME_FIRST_HALFLING_FEMALE);
                                break;
                        case GENDER_MALE:
                                first = RandomName(NAME_FIRST_HALFLING_MALE);
                                break;
                    }
                    string last = RandomName(NAME_LAST_HALFLING);
                    name = first+" "+last;
                    SetName(OBJECT_SELF,name);
                    break;
                    }
            case RACIAL_TYPE_HALFORC:
                    {
                    string first = "";
                    switch(GetGender(OBJECT_SELF)) {
                        case GENDER_FEMALE:
                                first = RandomName(NAME_FIRST_HALFORC_FEMALE);
                                break;
                        case GENDER_MALE:
                                first = RandomName(NAME_FIRST_HALFORC_MALE);
                                break;
                    }
                    string last = RandomName(NAME_LAST_HALFORC);
                    name = first+" "+last;
                    SetName(OBJECT_SELF,name);
                    break;
                    }
        }
        SQLExecDirect("select name from npc_professions");
        int count=0;
        string professions = "";

        while(SQLFetch()==SQL_SUCCESS) {
            professions+=SQLGetData(1)+"|";
        }
        int pick = Random(GetTokenCount(professions)-1)+1;
        myProf = GetTokenFromString(pick,professions);

        SQLExecDirect("insert into npc_state (resref,location,area,name,tag,profession) values ('"+resref+"','"+APSLocationToString(loc)+"','"+areatag+"','"+name+"','"+mytag+"','"+myProf+"')");
    }

    // Get my profession
    SQLExecDirect("select firstdesc from npc_professions where name='"+myProf+"'");
    SQLFetch();
    string firstdesc = SQLGetData(1);
    SetLocalString(OBJECT_SELF,"#WOTR_NPC_PROFESSION_DESC",firstdesc);
    SetLocalString(OBJECT_SELF,"#WOTR_NPC_PROFESSION",myProf);

    // This section picks a rumor to add to this NPC. Each restart, a different local rumor is chosen
    SQLExecDirect("select name,rumor from npc_rumors where (area='"+areatag+"' and profession='') or (area='"+areatag+"' and profession='"+myProf+"')");
    string rumors = "";
    string names = "";
    while(SQLFetch()==SQL_SUCCESS) {
        string tname = SQLGetData(1);
        string rumor= SQLGetData(2);
        names+=tname+"|";
        rumors+=rumor+"|";
    }
    int rumorCount = GetTokenCount(names);
    int pick = Random(rumorCount-1)+1;
    if(pick<=0) pick==1;

    string rname = GetTokenFromString(pick,names);
    string rtext = GetTokenFromString(pick,rumors);

    SetLocalString(OBJECT_SELF,"#WOTR_NPC_RUMOR_NAME_1",rname);
    SetLocalString(OBJECT_SELF,"#WOTR_NPC_RUMOR_TEXT_1",rtext);

    // This section picks a tidbit about another NPC in the area.
    // Basically, it will add another NPC's name to the conversation and
    // provide info about what that other NPC does for a living.
    string query = "select npc_state.name,npc_professions.thirddesc from npc_state,npc_professions where (npc_professions.area=npc_state.area and npc_state.profession=npc_professions.name) and npc_state.name!='"+name+"'";
    SQLExecDirect(query);

    string npcNames = "";
    // Need to pick random here
    while(SQLFetch()==SQL_SUCCESS) {
        string npcName = SQLGetData(1);
        string desc = SQLGetData(2);
        npcNames+=npcName+":"+desc+"|";
    }
    int num = GetTokenCount(npcNames);
    int nPick = Random(num-1)+1;

    string pickStr = GetTokenFromString(nPick,npcNames,"|");
    string nName = GetTokenFromString(1,pickStr,":");
    string nDesc = GetTokenFromString(2,pickStr,":");

    SetLocalString(OBJECT_SELF,"#WOTR_NPC_KNOWS_NAME",nName);
    SetLocalString(OBJECT_SELF,"#WOTR_NPC_KNOWS_DESC",nDesc);
    SetLocalObject(GetModule(),name,OBJECT_SELF);
}
