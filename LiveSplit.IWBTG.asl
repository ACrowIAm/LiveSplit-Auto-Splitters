// 𝙈𝙖𝙙𝙚 𝘽𝙮 𝘼𝘾𝙧𝙤𝙬𝙄𝘼𝙢 (v1.6.5)


state("stdrt")
{
    // Pointer addresses        
    int frameNumber: "stdrt.exe", 0x4837C, 0x1F0;
    int nextFrameNumber: "stdrt.exe", 0x4837C, 0x1EC; 
    int guyEntrance: "stdrt.exe", 0x48380, 0x8D0, 0xAA0, 0x4C;                     
    int selecter: "stdrt.exe", 0x48380, 0x8D0, 0x2E0, 0x54;              
    int miketyson: "stdrt.exe", 0x4837C, 0x268, 0x2C;  
    int mechabirdo: "stdrt.exe", 0x4837C, 0x268, 0x38;
    int dracula: "stdrt.exe", 0x4837C, 0x268, 0x3C;            
    int kraidgief: "stdrt.exe", 0x4837C, 0x268, 0x40; 
    int wily: "stdrt.exe", 0x4837C, 0x268, 0x34;      
    int motherbrain: "stdrt.exe", 0x4837C, 0x268, 0x30;    
    int dragon: "stdrt.exe", 0x48380, 0x8D0, 0x1740, 0x246;      
    int theguy: "stdrt.exe", 0x48380, 0x8D0, 0xA38, 0x242;                             
}

startup
{
    // Settings creation            
    settings.Add("routesgroup", true, "Routes (All Categories)");
    settings.Add("splitsgroup", true, "Splits");         
    settings.Add("settingsgroup", true, "Settings");      
    settings.Add("glitchlessroute1", true, "Glitchless Route 1 (T,B,D,K,W,M)", "routesgroup");
    settings.Add("glitchlessroute2", false, "Glitchless Route 2 (T,B,D,K,M,W)", "routesgroup");
    settings.Add("glitchlessroute3", false, "Glitchless Route 3 (K,M,W,D,T,B)", "routesgroup");    
    settings.Add("glitchlessroute4", false, "Glitchless Route 4 (K,W,D,M,T,B)", "routesgroup");     
    settings.Add("glitchlessroute5", false, "Glitchless Route 5 (K,M,T,B,D,W)", "routesgroup");       
    settings.Add("glitchesroute", false, "Glitches Route (K,M,W,D,T,B)", "routesgroup");    
    settings.Add("glitchesnombsplit", false, "Glitches No Mother Brain Split", "splitsgroup"); 
    settings.SetToolTip("glitchesnombsplit", "Removes the Mother Brain split for the glitches route.");           
    settings.Add("tenthousandkmsplit", false, "10000km Split", "splitsgroup");         
    settings.SetToolTip("tenthousandkmsplit", "Splits when you enter the minecart area.");      
    settings.Add("guyfightentrancesplit", false, "The Guy Fight Entrance Split", "splitsgroup");         
    settings.SetToolTip("guyfightentrancesplit", "tenshots's Split for when he enters the room for the boss fight.");               
    settings.Add("tenshotsdragonsplit", false, "tenshots Dragon Split", "splitsgroup");    
    settings.SetToolTip("tenshotsdragonsplit", "Splits on the transition to the next area after the fight.");   
    settings.Add("tesdragonsplit", true, "Tesivonius Dragon Split", "splitsgroup");  
    settings.SetToolTip("tesdragonsplit", "Splits when the Dragon flies into the wall and dies.");  
    settings.Add("bogandragonsplit", false, "Bogan Dragon Split", "splitsgroup");  
    settings.SetToolTip("bogandragonsplit", "Splits where he splits");      
    settings.Add("logicpqdragonsplit", false, "LogicPQ Dragon Split", "splitsgroup");  
    settings.SetToolTip("logicpqdragonsplit", "Splits where he splits");               
    settings.Add("automaticresets", true, "Automatic Resets", "settingsgroup");        
    settings.Add("warning1", true, "IMPORTANT: Make sure you only have ONE route, or dragon setting selected at once!");   

    // Sets the refresh rate of the script to the game's native framerate.     
    refreshRate = 50;                                    
}

init
{   
    // Variables  
    vars.splitGate = 0;
    vars.splitGateFrames = 48;
    vars.selecterFlag = 0;       
    vars.selecterDelay = 0;          
    vars.glitchlessRoute = 0;        
    vars.glitchesRoute = false;
    vars.wilySplitIndex = 0;    
    vars.draculaSplitIndex = 0;    
    vars.tysonSplitIndex = 0;    
    vars.birdoSplitIndex = 0;  
    vars.tenThousandkmSplitIndex = 0;          
    vars.dragonSplitIndex = 0;  
    vars.guyEntranceSplitIndex = 0;         
    vars.theguySplitIndex = 0;     
    vars.noMBSplitGlitches = false;      
    vars.tenThousandkmSplit = false;   
    vars.guyEntranceSplit = false;                      
    vars.tenshotsDragonSplit = false;  
    vars.tesDragonSplit = false;     
    vars.boganDragonSplit = false;
    vars.boganDragonSplitDelay = 0.0;      
    vars.logicpqDragonSplit = false;
    vars.logicpqDragonSplitDelay = 0.0;             
    vars.automaticResets = false;      
}

update
{

// Setting toggle logic
if (settings["glitchlessroute1"]) { 
        vars.glitchlessRoute = 1;
    }
    else if (settings["glitchlessroute2"]) {
        vars.glitchlessRoute = 2;
    }
    else if (settings["glitchlessroute3"]) {
        vars.glitchlessRoute = 3;
    }
    else if (settings["glitchlessroute4"]) {
        vars.glitchlessRoute = 4;
    }
    else if (settings["glitchlessroute5"]) {
        vars.glitchlessRoute = 5;
    }
    else {
        vars.glitchlessRoute = 0;
    }  

if (settings["glitchesroute"]) {
        vars.glitchesRoute = true;

    }
    else {
        vars.glitchesRoute = false;
    }                     

bool noMB = settings["glitchesnombsplit"];
bool tenK = settings["tenthousandkmsplit"];
bool guyEnt = settings["guyfightentrancesplit"];

if (noMB) {
    vars.wilySplitIndex = 1;    
    vars.draculaSplitIndex = 2;    
    vars.tysonSplitIndex = 3;    
    vars.birdoSplitIndex = 4; 
    vars.dragonSplitIndex = 5;   
    vars.theguySplitIndex = 6;  
    vars.noMBSplitGlitches = true;             
} else {
    vars.wilySplitIndex = 2;    
    vars.draculaSplitIndex = 3;    
    vars.tysonSplitIndex = 4;    
    vars.birdoSplitIndex = 5; 
    vars.dragonSplitIndex = 6;   
    vars.theguySplitIndex = 7;                
    vars.noMBSplitGlitches = false;        
}

vars.tenThousandkmSplit = tenK;

if (tenK) {
    vars.tenThousandkmSplitIndex = noMB ? 5 : 6;

    vars.dragonSplitIndex += 1;
    vars.theguySplitIndex += 1;
}

vars.guyEntranceSplit = guyEnt;

if (guyEnt) {

    vars.guyEntranceSplitIndex = noMB ? 6 : 7;

    if (tenK) {
        vars.guyEntranceSplitIndex += 1;
    }

    vars.theguySplitIndex = vars.guyEntranceSplitIndex + 1;
}       

if (settings["tenshotsdragonsplit"]) {
        vars.tenshotsDragonSplit = true;

    }
    else {
        vars.tenshotsDragonSplit = false;
    }       

if (settings["tesdragonsplit"]) {
        vars.tesDragonSplit = true;

    }
    else {
        vars.tesDragonSplit = false;
    }      

if (settings["bogandragonsplit"]) {
        vars.boganDragonSplit = true;

    }
    else {
        vars.boganDragonSplit = false;
    }       

if (settings["logicpqdragonsplit"]) {
        vars.logicpqDragonSplit = true;

    }
    else {
        vars.logicpqDragonSplit = false;
    }      

if (settings["automaticresets"]) {
        vars.automaticResets = true;

    }
    else {
        vars.automaticResets = false;
    }                  

// Split gate logic
bool resetByNextFrame  = (old.nextFrameNumber != 1 && current.nextFrameNumber == 1);
bool resetByCurrentFrame = (old.frameNumber != 1 && current.frameNumber == 1);

if (resetByNextFrame || resetByCurrentFrame)
    {
        vars.splitGate = vars.splitGateFrames;
    }
    else if (vars.splitGate > 0)
    {
        vars.splitGate--;
    }          
            
// Selecter flag/delay logic 
if (current.selecter == 239 && current.frameNumber == 6)
    {
        vars.selecterFlag = 1;
    }
    else if (current.selecter == 207 && current.frameNumber == 6)
    {
        vars.selecterFlag = 0;
    }  

if (current.frameNumber == 1)
    {
        if (old.frameNumber != 1)
        {
            vars.selecterDelay = 4; 
        }
        else if (vars.selecterDelay > 0)
        {
            vars.selecterDelay--;
            if (vars.selecterDelay == 0)
            {
                vars.selecterFlag = 0;
            }
        }
    }
    else
    {
        vars.selecterDelay = 0;
    }

    // Debug
    // print("Glitchless Route: " + vars.glitchlessRoute.ToString());       
    // print("Glitches Route: " + vars.glitchesRoute.ToString());                  
    // print("Wily Split Index: " + vars.wilySplitIndex.ToString());      
    // print("Dracula Split Index: " + vars.draculaSplitIndex.ToString());      
    // print("Mike Tyson Split Index: " + vars.tysonSplitIndex.ToString());           
    // print("Mecha Birdo Split Index: " + vars.birdoSplitIndex.ToString());     
    // print("10000km Split Index: " + vars.tenThousandkmSplitIndex.ToString());                    
    // print("Dragon Split Index: " + vars.dragonSplitIndex.ToString()); 
    // print("Guy Fight Entrance Split Index: " + vars.guyEntranceSplitIndex.ToString());            
    // print("The Guy Split Index: " + vars.theguySplitIndex.ToString()); 
    // print("Glitches No Mother Brain Split: " + vars.noMBSplitGlitches.ToString());    
    // print("Tes 10000km Split: " + vars.tenThousandkmSplit.ToString());         
    // print("Guy Fight Entrance Split: " + vars.guyEntranceSplit.ToString());                   
    // print("tenshots Dragon Split: " + vars.tenshotsDragonSplit.ToString());     
    // print("Tesivonius Dragon Split: " + vars.tesDragonSplit.ToString()); 
    // print("Bogan Dragon Split: " + vars.boganDragonSplit.ToString());     
    // print("LogicPQ Dragon Split: " + vars.logicpqDragonSplit.ToString());      
    // print("Automatic Resets: " + vars.automaticResets.ToString());             
}

start
{
    // Start logic            
    if (vars.selecterFlag == 1 && old.nextFrameNumber != 1 && current.nextFrameNumber == 1)
	        return true;	
}

split
{
        // Blocks splits for 48 frames.
        if (vars.splitGate > 0)
                return false;      

        // For split delays
        double currentTime = timer.CurrentTime.RealTime.GetValueOrDefault().TotalMilliseconds;                 
                  
                  
        // Glitchless Route 1 (Tyson, Birdo, Dracula, Gief, Wily, Mother Brain)

        if (vars.glitchlessRoute == 1 && timer.CurrentSplitIndex == 0 && old.miketyson != 1 && current.miketyson == 1) {
	        return true; 
	}
        if (vars.glitchlessRoute == 1 && timer.CurrentSplitIndex == 1 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 1 && timer.CurrentSplitIndex == 2 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}                
        if (vars.glitchlessRoute == 1 && timer.CurrentSplitIndex == 3 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true;            
	}     
        if (vars.glitchlessRoute == 1 && timer.CurrentSplitIndex == 4 && old.wily != 1 && current.wily == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 1 && timer.CurrentSplitIndex == 5 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;            
        }          

        // Glitchless Route 2 (Tyson, Birdo, Dracula, Gief, Mother Brain, Wily)

        if (vars.glitchlessRoute == 2 && timer.CurrentSplitIndex == 0 && old.miketyson != 1 && current.miketyson == 1) {
	        return true; 
	}
        if (vars.glitchlessRoute == 2 && timer.CurrentSplitIndex == 1 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 2 && timer.CurrentSplitIndex == 2 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}                
        if (vars.glitchlessRoute == 2 && timer.CurrentSplitIndex == 3 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true;            
	}     
        if (vars.glitchlessRoute == 2 && timer.CurrentSplitIndex == 4 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 2 && timer.CurrentSplitIndex == 5 && old.wily != 1 && current.wily == 1) {
	        return true;            
        }   
    
        // Glitchless Route 3 (Gief, Mother Brain, Wily, Dracula, Tyson, Birdo)   
        
        if (vars.glitchlessRoute == 3 && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}
        if (vars.glitchlessRoute == 3 && timer.CurrentSplitIndex == 1 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 3 && timer.CurrentSplitIndex == 2 && old.wily != 1 && current.wily == 1) {
	        return true;            
	}                
        if (vars.glitchlessRoute == 3 && timer.CurrentSplitIndex == 3 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}     
        if (vars.glitchlessRoute == 3 && timer.CurrentSplitIndex == 4 && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 3 && timer.CurrentSplitIndex == 5 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
        }   

        // Glitchless Route 4 (Gief, Wily, Dracula, Mother Brain, Tyson, Birdo)           
                                                        
        if (vars.glitchlessRoute == 4 && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}
        if (vars.glitchlessRoute == 4 && timer.CurrentSplitIndex == 1 && old.wily != 1 && current.wily == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 4 && timer.CurrentSplitIndex == 2 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}                
        if (vars.glitchlessRoute == 4 && timer.CurrentSplitIndex == 3 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;            
	}     
        if (vars.glitchlessRoute == 4 && timer.CurrentSplitIndex == 4 && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 4 && timer.CurrentSplitIndex == 5 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
        }

        // Glitchless Route 5 (Gief, Mother Brain, Tyson, Birdo, Dracula, Wily)           

        if (vars.glitchlessRoute == 5 && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}
        if (vars.glitchlessRoute == 5 && timer.CurrentSplitIndex == 1 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 5 && timer.CurrentSplitIndex == 2 && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}                
        if (vars.glitchlessRoute == 5 && timer.CurrentSplitIndex == 3 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}     
        if (vars.glitchlessRoute == 5 && timer.CurrentSplitIndex == 4 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}
        if (vars.glitchlessRoute == 5 && timer.CurrentSplitIndex == 5 && old.wily != 1 && current.wily == 1) {
	        return true;           
        }         

        // Glitches Route (Gief, Mother Brain, Wily, Dracula, Tyson, Birdo) 

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}    
        if (vars.glitchesRoute == true && vars.noMBSplitGlitches == false && timer.CurrentSplitIndex == 1 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;           
        }              
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == vars.wilySplitIndex && old.wily != 1 && current.wily == 1) {
	        return true;           
        }  
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == vars.draculaSplitIndex && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}    
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == vars.tysonSplitIndex && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}  
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == vars.birdoSplitIndex && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}                                      

        // Tesivonius 10000km Split

        if (vars.tenThousandkmSplit == true && timer.CurrentSplitIndex == vars.tenThousandkmSplitIndex && old.nextFrameNumber != 9 && current.nextFrameNumber == 9) {
	        return true;            
	}  

        // tenshots Guy Fight Entrance Split

        if (vars.guyEntranceSplit == true && timer.CurrentSplitIndex == vars.guyEntranceSplitIndex && old.guyEntrance < 3196 && current.guyEntrance >= 3196 && current.guyEntrance <= 4021) {
	        return true;            
	}         

        // tenshots All Glitchless Routes (Dragon)
        
        if (vars.glitchlessRoute > 0 && vars.tenshotsDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.frameNumber != 10 && current.frameNumber == 10) {
	        return true;
        }                  

        // Tesivonius All Glitchless Routes (Dragon)   

        if (vars.glitchlessRoute > 0 && vars.tesDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50021) {
	        return true;
        }             

        // Bogan All Glitchless Routes (Dragon)   

        if (vars.glitchlessRoute > 0 && vars.boganDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50021) {
                vars.boganDragonSplitDelay = currentTime;
	        return false;
        }                
                if (vars.boganDragonSplitDelay > 0 &&
                currentTime >= vars.boganDragonSplitDelay + 3988) 
        {                  
                vars.boganDragonSplitDelay = 0.0;     
                return true;        
        }             

        // LogicPQ All Glitchless Routes (Dragon)         

        if (vars.glitchlessRoute > 0 && vars.logicpqDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50021) {
                vars.logicpqDragonSplitDelay = currentTime;
	        return false;
        }                
                if (vars.logicpqDragonSplitDelay > 0 &&
                currentTime >= vars.logicpqDragonSplitDelay + 6680) 
        {                  
                vars.logicpqDragonSplitDelay = 0.0;     
                return true;        
        }                                                                       

        // tenshots Glitches Route (Dragon)

        if (vars.glitchesRoute == true && vars.tenshotsDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.frameNumber != 10 && current.frameNumber == 10) {
	        return true;
        }                           

        // Tesivonius Glitches Route (Dragon)   

        if (vars.glitchesRoute == true && vars.tesDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50021) {
	        return true;
        }              

        // Bogan Glitches Route (Dragon)   

        if (vars.glitchesRoute == true && vars.boganDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50021) {
                vars.boganDragonSplitDelay = currentTime;
	        return false;
        }                
                if (vars.boganDragonSplitDelay > 0 &&
                currentTime >= vars.boganDragonSplitDelay + 3988) 
        {                  
                vars.boganDragonSplitDelay = 0.0;     
                return true;        
        }                                                   

        // LogicPQ Glitches Route (Dragon)         

        if (vars.glitchesRoute == true && vars.logicpqDragonSplit == true && timer.CurrentSplitIndex == vars.dragonSplitIndex && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50021) {
                vars.logicpqDragonSplitDelay = currentTime;
	        return false;
        }                
                if (vars.logicpqDragonSplitDelay > 0 &&
                currentTime >= vars.logicpqDragonSplitDelay + 6680) 
        {                  
                vars.logicpqDragonSplitDelay = 0.0;     
                return true;        
        }                                              

        // All Glitchless Routes (The Guy)    

        if (vars.glitchlessRoute > 0 && timer.CurrentSplitIndex == vars.theguySplitIndex && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }            

        // Glitches Route (The Guy)           

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == vars.theguySplitIndex && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }                                                                                                                                                                                                                                                          
}

reset
{
    // Reset logic    
    if (vars.automaticResets == true && vars.selecterFlag == 1 && old.nextFrameNumber != 1 && current.nextFrameNumber == 1)   

    {
        // Sets variables back to default.      
        vars.boganDragonSplitDelay = 0.0;            
        vars.logicpqDragonSplitDelay = 0.0;      

        return true;

    }

    return false;        
}
