////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Weather System
//  orw_mod_onload
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Module Onload Event
//  If you use the ORS  ors_mod_onload  this script is not required
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oMod = OBJECT_SELF;

//:****************************************************************************/
//: OLANDER'S REALISTIC WEATHER

    int nWEATHERGLOBAL = 1;//Set this to globally turn on or off the Weather System (0 is OFF)

    //Debug Messages (Temperature and Humidity will always be seen)
    int nRWDebug = 0;//Debug Meesages (0 is OFF)

    int nSKYBOX = 1;//New Feature to diable Sky Box changes Dynamically
                    //Note:
                    /*There are some 'Hiccups' encountered with the Aurora Engine
                      thay may cause the computer to go to 100% and cause the Server
                      to diconnect (very much like a never ending loop!!). If you
                      have this issue turn this off first then check to see if the
                      issue went away. Should.  */

    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERGLOBAL", nWEATHERGLOBAL));
    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERCYCLE",2));
    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERDUBUG",nRWDebug));
    AssignCommand(oMod,SetLocalInt(oMod,"WEATHERSKYBOX", nSKYBOX));

//: OLANDER'S REALISTIC WEATHER
//:****************************************************************************/
}
