//::///////////////////////////////////////////////
//:: Pentagram star
//:: penta_inc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Comments: CracyD@Krynnhaven.com
     Heavily modified for use with pc vampire
     scripts. -Fallen
*/
//:://////////////////////////////////////////////
//:: Created By: CracyD
//:: Created On: 07-01-2003
//:: Last update: 25-05-2003
//:://////////////////////////////////////////////

// This function will produce a pentagram at
// lTargetLoc using nBeamFX for nDuration seconds.
// nScale determines the size of the pentagram (nScale = 2.0 => Double size etc.)
// nPentagon is a boolean which determines wheter to draw a pentagon with the pentagram
// nPentagonFX is the effect used for the Pentagon (Beam Effect)
// Note: Requires placable "nonstaticinvis" <- moved to custom1
void pentagram(location lTargetLoc, int nBeamFX=VFX_BEAM_EVIL, float fDuration=4.0, float fRate = 0.4, float nScale=0.3);

void pentagram(location lTargetLoc, int nBeamFX=VFX_BEAM_EVIL, float fDuration=4.0, float fRate = 0.4, float nScale=0.3)
{
        // Get center
        object oArea = GetAreaFromLocation(lTargetLoc);
        // Define vertices for pentagram
        vector v = GetPositionFromLocation(lTargetLoc);
        v = Vector(v.x,v.y+7.0*nScale,v.z);
        location l1= Location(oArea,v,0.0);
        v = Vector(v.x-4.0*nScale,v.y-12.5*nScale,v.z);
        location l2= Location(oArea,v,0.0);
        v = Vector(v.x+10.5*nScale,v.y+8.0*nScale,v.z);
        location l3= Location(oArea,v,0.0);
        v = Vector(v.x-13*nScale,v.y,v.z);
        location l4= Location(oArea,v,0.0);
        v = Vector(v.x+10.5*nScale,v.y-8.0*nScale,v.z);
        location l5= Location(oArea,v,0.0);
        // Create verticies objects
        object oS1 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l1);
        object oS2 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l2);
        object oS3 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l3);
        object oS4 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l4);
        object oS5 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l5);
        // Connect vertices with beams
        effect eVis1 = EffectBeam(nBeamFX,oS1,BODY_NODE_CHEST);
        effect eVis2 = EffectBeam(nBeamFX,oS2,BODY_NODE_CHEST);
        effect eVis3 = EffectBeam(nBeamFX,oS3,BODY_NODE_CHEST);
        effect eVis4 = EffectBeam(nBeamFX,oS4,BODY_NODE_CHEST);
        effect eVis5 = EffectBeam(nBeamFX,oS5,BODY_NODE_CHEST);
        // Make pentagram visible
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis1,oS2,fDuration);
        DelayCommand((fRate * 1.0),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis2,oS3,fDuration));
        DelayCommand((fRate * 2.0),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis3,oS4,fDuration));
        DelayCommand((fRate * 3.0),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis4,oS5,fDuration));
        DelayCommand((fRate * 4.0),ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis5,oS1,fDuration));
        // Remove objects
        DelayCommand(fDuration,DestroyObject(oS1));
        DelayCommand(fDuration,DestroyObject(oS2));
        DelayCommand(fDuration,DestroyObject(oS3));
        DelayCommand(fDuration,DestroyObject(oS4));
        DelayCommand(fDuration,DestroyObject(oS5));
}
