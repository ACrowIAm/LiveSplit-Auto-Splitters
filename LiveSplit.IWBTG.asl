// 𝙈𝙖𝙙𝙚 𝘽𝙮 𝘼𝘾𝙧𝙤𝙬𝙄𝘼𝙢 (v1.3.0


state("stdrt")
{
    // Pointer addresses        
    int frameNumber: "stdrt.exe", 0x4837C, 0x1F0;
    int nextFrameNumber: "stdrt.exe", 0x4837C, 0x1EC;        
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
    settings.Add("settingsgroup", true, "Settings");      
    settings.Add("glitchlessroute1", true, "Glitchless Route 1 (T,B,D,K,W,M)", "routesgroup");
    settings.Add("glitchlessroute2", false, "Glitchless Route 2 (T,B,D,K,M,W)", "routesgroup");
    settings.Add("glitchlessroute3", false, "Glitchless Route 3 (K,M,W,D,T,B)", "routesgroup");    
    settings.Add("glitchlessroute4", false, "Glitchless Route 4 (K,W,D,M,T,B)", "routesgroup");     
    settings.Add("glitchlessroute5", false, "Glitchless Route 5 (K,M,T,B,D,W)", "routesgroup");       
    settings.Add("regularglitchesroute", false, "Regular Glitches Route", "routesgroup");           
    settings.Add("logicpqglitchesroute", false, "LogicPQ Glitches Route (K,W,D,T,B)", "routesgroup"); 
    settings.SetToolTip("logicpqglitchesroute", "Select his dragon split in Settings for his timing");               
    settings.Add("tenshotsdragonsplit", false, "tenshots Dragon Split", "settingsgroup");    
    settings.SetToolTip("tenshotsdragonsplit", "Splits on the transition to the next area after the fight");   
    settings.Add("tesdragonsplit", true, "Tesivonius Dragon Split", "settingsgroup");  
    settings.SetToolTip("tesdragonsplit", "Splits when the Dragon flies into the wall and dies");  
    settings.Add("logicpqdragonsplit", false, "LogicPQ Dragon Split", "settingsgroup");  
    settings.SetToolTip("logicpqdragonsplit", "Splits where he splits");               
    settings.Add("automaticresets", true, "Automatic Resets", "settingsgroup");        
    settings.Add("warning1", true, "IMPORTANT: Make sure you only select ONE route, or Dragon setting at once!");                                 
}

init
{   
    // Variables  
    vars.splitGate = 0;
    vars.splitGateFrames = 48;    
    vars.selecterDelay = 0;          
    vars.selecterFlag = 0;
    vars.glitchlessRoute = 1;        
    vars.glitchesRoute = false;    
    vars.logicpqGlitchesRoute = false;     
    vars.tenshotsDragonSplit = false;  
    vars.tesDragonSplit = true;      
    vars.logicpqDragonSplit = false;
    vars.logicpqDragonSplitDelay = 0.0;         
    vars.automaticResets = true;      
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

if (settings["regularglitchesroute"]) {
        vars.glitchesRoute = true;

    }
    else {
        vars.glitchesRoute = false;
    }             

if (settings["logicpqglitchesroute"]) {
        vars.logicpqGlitchesRoute = true;

    }
    else {
        vars.logicpqGlitchesRoute = false;
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
            
// Selecter delay/flag logic   
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

    if (current.selecter == 239 && current.frameNumber == 6)
    {
        vars.selecterFlag = 1;
    }
    else if (current.selecter == 207 && current.frameNumber == 6)
    {
        vars.selecterFlag = 0;
    }  

    // Debug
    // print("Glitchless Route: " + vars.glitchlessRoute.ToString());       
    // print("Regular Glitches Route: " + vars.glitchesRoute.ToString());    
    // print("LogicPQ Glitches Route: " + vars.logicpqGlitchesRoute.ToString());    
    // print("tenshots Dragon Split: " + vars.tenshotsDragonSplit.ToString());     
    // print("Tesivonius Dragon Split: " + vars.tesDragonSplit.ToString()); 
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
        // Blocks splits for 48 frames
        if (vars.splitGate > 0)
                return false;      

        // For debounce
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

        // Regular Glitches Route (Gief, Mother Brain, Wily, Dracula, Tyson, Birdo) 

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}    
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 1 && old.motherbrain != 1 && current.motherbrain == 1) {
	        return true;           
        }              
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 2 && old.wily != 1 && current.wily == 1) {
	        return true;           
        }  
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 3 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}    
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 4 && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}  
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 5 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}          

        // LogicPQ Glitches Route (Gief, Wily, Dracula, Tyson, Birdo) 

        if (vars.logicpqGlitchesRoute == true && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}                 
        if (vars.logicpqGlitchesRoute == true && timer.CurrentSplitIndex == 1 && old.wily != 1 && current.wily == 1) {
	        return true;           
        }  
        if (vars.logicpqGlitchesRoute == true && timer.CurrentSplitIndex == 2 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}    
        if (vars.logicpqGlitchesRoute == true && timer.CurrentSplitIndex == 3 && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}  
        if (vars.logicpqGlitchesRoute == true && timer.CurrentSplitIndex == 4 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}                                    

        // tenshots All Glitcheless Routes (Dragon)
        
        if (vars.glitchlessRoute > 0 && vars.tenshotsDragonSplit == true && vars.tesDragonSplit == false && vars.logicpqDragonSplit == false && timer.CurrentSplitIndex == 6 && old.frameNumber != 10 && current.frameNumber == 10) {
	        return true;
        }  

        // Tesivonius All Glitcheless Routes (Dragon)   

        if (vars.glitchlessRoute > 0 && vars.tenshotsDragonSplit == false && vars.tesDragonSplit == true && vars.logicpqDragonSplit == false && timer.CurrentSplitIndex == 6 && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50010) {
	        return true;
        }                        

        // tenshots Regular Glitches Route (Dragon)

        if (vars.glitchesRoute == true && vars.tenshotsDragonSplit == true && vars.tesDragonSplit == false && vars.logicpqDragonSplit == false && timer.CurrentSplitIndex == 6 && old.frameNumber != 10 && current.frameNumber == 10) {
	        return true;
        } 

        // Tesivonius Regular Glitches Route (Dragon)   

        if (vars.glitchesRoute == true && vars.tenshotsDragonSplit == false && vars.tesDragonSplit == true && vars.logicpqDragonSplit == false && timer.CurrentSplitIndex == 6 && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50010) {
	        return true;
        }         

        // LogicPQ All Glitcheless Routes (Dragon)         

        if (vars.glitchlessRoute > 0 && vars.tenshotsDragonSplit == false && vars.tesDragonSplit == false && vars.logicpqDragonSplit == true && timer.CurrentSplitIndex == 6 && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50010) {
                vars.logicpqDragonSplitDelay = currentTime;
	        return false;
        }                
                if (vars.logicpqDragonSplitDelay > 0 &&
                currentTime >= vars.logicpqDragonSplitDelay + 6680) 
        {                  
                vars.logicpqDragonSplitDelay = 0.0;     
                return true;        
        }           

       // LogicPQ Glitches Route (Dragon)         

        if (vars.glitchesRoute == true && vars.tenshotsDragonSplit == false && vars.tesDragonSplit == false && vars.logicpqDragonSplit == true && timer.CurrentSplitIndex == 6 && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50010) {
                vars.logicpqDragonSplitDelay = currentTime;
	        return false;
        }                
                if (vars.logicpqDragonSplitDelay > 0 &&
                currentTime >= vars.logicpqDragonSplitDelay + 6680) 
        {                  
                vars.logicpqDragonSplitDelay = 0.0;     
                return true;        
        }        

       // For LogicPQ Glitches Route (Dragon)         

        if (vars.logicpqGlitchesRoute == true && vars.tenshotsDragonSplit == false && vars.tesDragonSplit == false && vars.logicpqDragonSplit == true && timer.CurrentSplitIndex == 5 && old.dragon < 50000 && current.dragon >= 50000 && current.dragon <= 50010) {
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

        if (vars.glitchlessRoute > 0 && timer.CurrentSplitIndex == 7 && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }      

        // Regular Glitches Route (The Guy)           

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 7 && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }       


        // For LogicPQ Glitches Route (The Guy)           

        if (vars.logicpqGlitchesRoute == true && timer.CurrentSplitIndex == 6 && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }                                                                                                           
}    

reset
{
    // Reset logic    
    if (vars.automaticResets == true && vars.selecterFlag == 1 && old.nextFrameNumber != 1 && current.nextFrameNumber == 1)   

    {
        // Sets variables back to default      
        vars.logicpqDragonSplitDelay = 0.0;      

        return true;

    }

    return false;        
}

