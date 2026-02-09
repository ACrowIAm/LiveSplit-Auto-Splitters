// 𝙈𝙖𝙙𝙚 𝘽𝙮 𝘼𝘾𝙧𝙤𝙬𝙄𝘼𝙢 (v1.1.4)


state("stdrt")
{
    // Pointer addresses    
	// test 2
    int frameNumber: "stdrt.exe", 0x48384, 0x18, 0x1EC;
    int selecter: "stdrt.exe", 0x48380, 0x8D0, 0x2E0, 0x108;      
    int startReset: "stdrt.exe", 0x4837C, 0x140, 0xB39;         
    int miketyson: "stdrt.exe", 0x4837C, 0x268, 0x2C;  
    int mechabirdo: "stdrt.exe", 0x4837C, 0x268, 0x38;
    int dracula: "stdrt.exe", 0x4837C, 0x268, 0x3C;            
    int kraidgief: "stdrt.exe", 0x4837C, 0x268, 0x40; 
    int wily: "stdrt.exe", 0x4837C, 0x268, 0x34;      
    int motherbrain: "stdrt.exe", 0x4837C, 0x268, 0x30; 
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
    settings.Add("glitchesroute", false, "Glitches Route", "routesgroup");    
    settings.Add("automaticresets", true, "Automatic Resets", "settingsgroup");                               
}

init
{   
    // Variables  
    vars.splitGate = 0;
    vars.splitGateFrames = 48;    
    vars.selecterDelay = 0;          
    vars.selecterFlag = 0;
    vars.glitchlessRoute = 0;
    vars.glitchesRoute = false; 
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

if (settings["glitchesroute"]) {
        vars.glitchesRoute = true;

    }
    else {
        vars.glitchesRoute = false;
    }     

if (settings["automaticresets"]) {
        vars.automaticResets = true;

    }
    else {
        vars.automaticResets = false;
    }            

// Split gate logic
bool resetByFlag  = (old.startReset != 2 && current.startReset == 2);
bool resetByFrame = (old.frameNumber != 1 && current.frameNumber == 1);

if (resetByFlag || resetByFrame)
    {
        vars.splitGate = vars.splitGateFrames;
    }
    else if (vars.splitGate > 0)
    {
        vars.splitGate--;
    }  
            
// selecter delay/flag logic   
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
    // print("Glitches Route: " + vars.glitchesRoute.ToString());
    // print("Automatic Resets: " + vars.automaticResets.ToString());    
}

start
{
    // Start logic            
    if (vars.selecterFlag == 1 && old.startReset != 2 && current.startReset == 2)
	        return true;	
}

split
{
        // Blocks splits for 48 frames
        if (vars.splitGate > 0)
                return false;      
                  
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

        // Glitches Route (Gief, Wily, Dracula, Tyson, Birdo) 

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 0 && old.kraidgief != 1 && current.kraidgief == 1) {
	        return true; 
	}    
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 1 && old.wily != 1 && current.wily == 1) {
	        return true;           
        }
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 2 && old.dracula != 1 && current.dracula == 1) {
	        return true;            
	}    
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 3 && old.miketyson != 1 && current.miketyson == 1) {
	        return true;            
	}  
        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 4 && old.mechabirdo != 1 && current.mechabirdo == 1) {
	        return true;            
	}                       
             
        // All Glitchless Routes (Dragon)   

        if (vars.glitchlessRoute > 0 && timer.CurrentSplitIndex == 6 && old.frameNumber != 10 && current.frameNumber == 10) {
	        return true;
        }     

        // Glitches Route (Dragon)   

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 5 && old.frameNumber != 10 && current.frameNumber == 10) {
	        return true;
        }            

        // All Glitchless Routes (The Guy)    

        if (vars.glitchlessRoute > 0 && timer.CurrentSplitIndex == 7 && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }      

        // Glitches Route (The Guy)           

        if (vars.glitchesRoute == true && timer.CurrentSplitIndex == 6 && old.theguy != 4500 && current.theguy == 4500) {
	        return true;     
        }                                                                                                       
}    

reset
{
    // Reset logic    
    if (vars.automaticResets == true && vars.selecterFlag == 1 && old.startReset != 2 && current.startReset == 2)
        return true;        

}


