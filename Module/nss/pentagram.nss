//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
//
//                                 Advanced Pentagram Script by Ruediger Nagel
//                                       any suggestions or bug reports to:
//                                                rnprod@gmx.de
//
//                                             version 20.09.2003
//
//--------------------------------------------------------------------------------------------------------------
//----------------------------------------------  DESCRIPTION  -------------------------------------------------
//    Generates an either good (holybeams and pentagram 2edges down one up) or evil (evilbeams and 180degrees
//    turned pentagram) around an given object. In order to generate it it will also generate edge figures
//    standart are the gargoyle statues ("plc_statue3"). After the VFX have been shown the User gets teleported
//    to a WAYPOINT somewhere in the modul. The waypoint is the TAG of the placeable that runs the script!
//
//--------------------------------------------------------------------------------------------------------------
//------------------------------  VARIABLES TO BE CHANGED DEPENDING ON INTENDET USE   --------------------------
//--------------------------------------------------------------------------------------------------------------

const int   testmode    = 0;   //testmode 0=off 1=on  on gives additional status of the script while running...
const int   remove      = 1;   // 1= remove generated objects after portal is used 0 lets them in place
const float portalReset = 4.0f;//the time between 2activation circles.its strongly recommended to keep em
                               //above 3.5f for this is the runtime of the script itself.
string what        = "plc_statue3";//The bluepriint refferenc of the object to be the edges of the pentagram
//
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
//  I M P O R T A N T   Safes are used for setting up the pentagram, so dont forget to change them
//
//                      legal Values   default    sets
//    Fortitude Safe       0 or 1         1       good or evil pentagram
//    Reflex Safe          3 to 15        8       diameter of the pentagram in metres
//    Will Safe            0 or 1         1       shake screen or not while script is running
//
//    TAG                  all existing   -       sets the jumpoint for the portal
//                         waypoints
//--------------------------------------------------------------------------------------------------------------
location l_center = GetLocation(OBJECT_SELF);
vector   v_center = GetPosition(OBJECT_SELF);
object   a_center = GetArea(OBJECT_SELF);

object   o_user   = GetLastUsedBy();

vector   v_point;
location l_point0, l_point1, l_point2, l_point3, l_point4;

effect   eBeam0, eBeam1, eBeam2, eBeam3, eBeam4;
object   o_plc0, o_plc1, o_plc2, o_plc3, o_plc4;

string   waypoint    = GetTag(OBJECT_SELF);//the TAG of the Object defines the jumppoint for the portal

int      ready       = GetLocalInt(OBJECT_SELF,"ready"); //used to get skript readiness

int      good        = 1;   //will hold information whether to create a good or evil looking pentagram
                            //default value 1 = good
int      shake       = 1;   //will hold informtion whether screen should shake or not
                            //default value 1 = YES screen will shake
float    skale       = 8.0f;//will hold the information about the diametre of the pentagram
                            //default radius =8.0m

//returns the orientation of the running object
float    orientation = GetFacing(OBJECT_SELF);

void setupVariables(){
  int nSetup;  // the safes of the calling Object are used for setting up the pentagram

  nSetup = GetFortitudeSavingThrow(OBJECT_SELF);//Good or evil pentagram
  if(nSetup == 0 || nSetup==1) {
    good = nSetup;  //if the saving throw is set to either 0 (evil) or 1(good) it will be taken
  }
  nSetup = GetWillSavingThrow(OBJECT_SELF);//Screenshake YES or NO
  if(nSetup == 0 || nSetup==1) {
    shake = nSetup;  //if the saving throw is set to either 0 (NO) or 1(YES) it will be taken
  }
  nSetup = GetReflexSavingThrow(OBJECT_SELF); //radius of the pentagram
  if(nSetup >= 3 && nSetup <=15) {
    skale = IntToFloat(nSetup);  //radius will be 3-15m or default 8.0m
  }
}


void calcLocation(vector vec){
float f_dreh=-90.0f;
  if(good==1){
    f_dreh=orientation;
  }
  else{
    f_dreh=orientation+90.0f;
  }

  float f_angle0=   0.0f + f_dreh;
  float f_angle1=  72.0f + f_dreh;
  float f_angle2= 144.0f + f_dreh;
  float f_angle3= 216.0f + f_dreh;
  float f_angle4= 288.0f + f_dreh;

//generationg the 5 vectors and afterwards the new locations out of vectors
//and adjusts facing of the placebles in the direction facing to the center of the pentagram
  v_point.x = vec.x + sin(f_angle0)*skale; v_point.y = vec.y + cos(f_angle0)*skale; v_point.z = vec.z;
    l_point0 = Location(a_center,v_point, 90.0f - f_dreh);
  v_point.x = vec.x + sin(f_angle1)*skale; v_point.y = vec.y + cos(f_angle1)*skale; v_point.z = vec.z;
    l_point1 = Location(a_center,v_point, 18.0f - f_dreh);
  v_point.x = vec.x + sin(f_angle2)*skale; v_point.y = vec.y + cos(f_angle2)*skale; v_point.z = vec.z;
    l_point2 = Location(a_center,v_point,306.0f - f_dreh);
  v_point.x = vec.x + sin(f_angle3)*skale; v_point.y = vec.y + cos(f_angle3)*skale; v_point.z = vec.z;
    l_point3 = Location(a_center,v_point,234.0f - f_dreh);
  v_point.x = vec.x + sin(f_angle4)*skale; v_point.y = vec.y + cos(f_angle4)*skale; v_point.z = vec.z;
    l_point4 = Location(a_center,v_point,162.0f - f_dreh);

  if(testmode==1){
   FloatingTextStringOnCreature("calcLocation...DONE",o_user,TRUE);
  }
}

void generateObjects(){
  if(testmode==1){
   FloatingTextStringOnCreature("This object: '"+what+"' should be generated",o_user,TRUE);
  }
// ...and creates them
  CreateObject(OBJECT_TYPE_PLACEABLE,what,l_point0,FALSE,"statue");
  CreateObject(OBJECT_TYPE_PLACEABLE,what,l_point1,FALSE,"statue");
  CreateObject(OBJECT_TYPE_PLACEABLE,what,l_point2,FALSE,"statue");
  CreateObject(OBJECT_TYPE_PLACEABLE,what,l_point3,FALSE,"statue");
  CreateObject(OBJECT_TYPE_PLACEABLE,what,l_point4,FALSE,"statue");

  if(testmode==1){
   FloatingTextStringOnCreature("generateObjects...DONE",o_user,TRUE);
  }
}
void addBeamType(int type){
  eBeam0 = EffectBeam(type, o_plc0,BODY_NODE_CHEST, FALSE);
  eBeam1 = EffectBeam(type, o_plc1,BODY_NODE_CHEST, FALSE);
  eBeam2 = EffectBeam(type, o_plc2,BODY_NODE_CHEST, FALSE);
  eBeam3 = EffectBeam(type, o_plc3,BODY_NODE_CHEST, FALSE);
  eBeam4 = EffectBeam(type, o_plc4,BODY_NODE_CHEST, FALSE);
}

void generateBeams(){
  int i_beam;
  o_plc0 = GetObjectByTag("statue",0);
  o_plc1 = GetObjectByTag("statue",1);
  o_plc2 = GetObjectByTag("statue",2);
  o_plc3 = GetObjectByTag("statue",3);
  o_plc4 = GetObjectByTag("statue",4);
// creating the several different beams to lighten up the pentagram
// 1st beamgroup
  i_beam=VFX_BEAM_LIGHTNING; //sets next beamgroup to Lightning effects

  addBeamType(i_beam);
  DelayCommand(0.2f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam0,o_plc2,0.3));
  DelayCommand(0.2f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam3,o_plc0,0.4));
  DelayCommand(0.5f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam4,o_plc1,0.5));
  DelayCommand(0.8f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam2,o_plc4,0.3));
  DelayCommand(0.8f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam0,o_plc2,0.4));
  DelayCommand(1.1f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam1,o_plc3,0.2));
  DelayCommand(1.1f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam2,o_plc4,0.3));

// 2nd beamgroup
  if(good==1){
    i_beam=VFX_BEAM_HOLY;
  }
  else{
    i_beam=VFX_BEAM_EVIL;
  }
  addBeamType(i_beam);
  DelayCommand(1.3f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam0,o_plc2,1.7));
  DelayCommand(1.2f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam2,o_plc4,1.8));
  DelayCommand(1.1f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam4,o_plc1,1.9));
  DelayCommand(1.4f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam1,o_plc3,1.6));
  DelayCommand(0.7f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam3,o_plc0,2.3));



  if(shake==1){
   DelayCommand(1.4f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectVisualEffect(356), OBJECT_SELF,1.5f));
  }
  if(testmode==1){
    FloatingTextStringOnCreature("GenerateBeams...DONE",o_user,TRUE);
  }

}

void teleport(){
  //in case the TAG isnt set to a valid waypoint nothing will happen but the visual effects
  effect eStrike, eVis, eEff;
  if(good==1){
    eStrike = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
    eVis    = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
  }
  else{
    eStrike = EffectVisualEffect(VFX_FNF_PWKILL);
    eVis    = EffectVisualEffect(246);
  }
  eEff = EffectLinkEffects(eVis,eStrike);
  DelayCommand(2.8f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eEff,o_user,0.5f));
  object target =  GetObjectByTag(waypoint,0);
  if(target==OBJECT_SELF){
    target = GetObjectByTag(waypoint,1);
  }
  DelayCommand(3.0f,AssignCommand(o_user, ActionJumpToLocation(GetLocation(target))));
}

void removePlc(){
  int number      = 0;
  object o_vanish;
  effect e_vanish = EffectVisualEffect(VFX_IMP_SONIC);

  while(number<=4){
    o_vanish = GetObjectByTag("statue",number);
    DelayCommand((3.5f+(IntToFloat(number)/5)),ApplyEffectToObject(DURATION_TYPE_INSTANT,e_vanish,o_vanish,0.7f));
    DelayCommand((3.5f+(IntToFloat(number)/5)),ApplyEffectToObject(DURATION_TYPE_INSTANT,e_vanish,o_vanish,1.0f));
    DelayCommand((3.6f+(IntToFloat(number)/5)),DestroyObject(o_vanish,0.0f));
    number+=1;
  }
}


void main()
{
  setupVariables();

  if(ready==0){
    //checks if the scripts last circle is completet by controlling "ready" of the calling object
    //ready is going to be reset to 0 after specified time.
    SetLocalInt(OBJECT_SELF,"ready",1);

    if(testmode==1){
        FloatingTextStringOnCreature("Next procedure calcLocation",o_user,TRUE);
    }
    calcLocation(v_center);

    if(testmode==1){
      FloatingTextStringOnCreature("Next procedure generateObjects",o_user,TRUE);
    }
    generateObjects();

    if(testmode==1){
      FloatingTextStringOnCreature("Next procedure generateBeams",o_user,TRUE);
    }
    generateBeams();

    if(remove==1){
      removePlc();
    }
    teleport();
    //resets the variable ready so the script may activiate the portal again.
    DelayCommand(portalReset,SetLocalInt(OBJECT_SELF,"ready",0));
  }
}

