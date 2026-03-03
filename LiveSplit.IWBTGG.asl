// 𝙈𝙖𝙙𝙚 𝘽𝙮 𝘼𝘾𝙧𝙤𝙬𝙄𝘼𝙢 (v1.1.2)


state("iwbtgg")
{
    // Pointer addresses
    int start: "iwbtgg.exe", 0x2A49EBC, 0xF48;
    int reset: "iwbtgg.exe", 0x2A1C4F4, 0xDF4;	
    int stageEnter: "iwbtgg.exe", 0x2AE8A18, 0x605;	    
    int stage1: "iwbtgg.exe", 0x2AE87B4, 0x2DC;  
    int stage3: "iwbtgg.exe", 0x2AE8A18, 0x619;
}

startup
{
    // Settings creation
    settings.Add("splittiminggroup", true, "Split Timing");        
    settings.Add("splittiming1", true, "Boss Door Entry", "splittiminggroup");  
    settings.Add("splittiming2", false, "Forth Beep", "splittiminggroup"); 
    settings.Add("splittiming3", false, "Completion Time", "splittiminggroup");     
    settings.Add("splittiming4", false, "World Map", "splittiminggroup");          
    settings.Add("bugwarning", false, "WARNING: There's a bug with the stage 1 value where it goes to 1 during the stage sometimes and causes it to split.");                              
}

init
{
    // Variables     
    vars.stage1GateTime = 0.0;
    vars.stage1SplitDelay = 0.0;
    vars.stage3SplitDelay = 0.0; 
    vars.lastSplitTime = 0.0;    
    vars.splitTiming = 0000.0; 
}

update
{

// Setting toggle logic
if (settings["splittiming1"]) {
        vars.splitTiming = 0081;
    }
    else if (settings["splittiming2"]) {
        vars.splitTiming = 2012;
    }
    else if (settings["splittiming3"]) {
        vars.splitTiming = 3967;
    }
    else if (settings["splittiming4"]) {
        vars.splitTiming = 9167;
    }
    else {
        vars.splitTiming = 0081;
    }   

    // Debug
    // print("Split Timing: " + vars.splitTiming.ToString());                        
}

start
{
    // Start logic
    return old.start != 1 && current.start == 1;
}

split
{
    // Stage 1 split logic
    double currentTime = timer.CurrentTime.RealTime.GetValueOrDefault().TotalMilliseconds;

    if (timer.CurrentSplitIndex == 0)
        {
        if (old.stageEnter != 1 && current.stageEnter == 1)
        {
            vars.stage1GateTime = currentTime;      
        }

        bool stage1Allowed =
            vars.stage1GateTime > 0 &&
            currentTime >= vars.stage1GateTime + 8000.0;

        if (stage1Allowed && old.stage1 != 1 && current.stage1 == 1)
        {
            vars.stage1SplitDelay = currentTime;
            return false;
        }

            if (vars.stage1SplitDelay > 0 &&
            currentTime >= vars.stage1SplitDelay + vars.splitTiming)
        {
            vars.stage1SplitDelay = 0.0;
            vars.stage1GateTime = 0.0;
            vars.lastSplitTime = currentTime;
            return true;
    }
}
    // Stage 3 split logic     
    if (timer.CurrentSplitIndex == 1)
    {
        if (old.stage3 != 1 && current.stage3 == 1)
        {
            vars.stage3SplitDelay = currentTime;
            return false;
        }

        if (current.stage3 == 1 && vars.stage3SplitDelay > 0 && currentTime >= vars.stage3SplitDelay + 0988.0) // Leave this time alone as the run should always end after around 0.988 seconds after the trigger.
        {
            vars.stage3SplitDelay = 0.0;
            vars.lastSplitTime = currentTime;
            return true;
        }

        if (current.stage3 != 1 && vars.stage3SplitDelay > 0)
        {
            vars.stage3SplitDelay = 0.0;
        }
    }
    
    return false;
}

reset
{
    // Reset logic
    if (old.reset != 1 && current.reset == 1)   
    
    {
        // Sets variables back to default.
        vars.stage1GateTime = 0.0;
        vars.stage1SplitDelay = 0.0;           
        vars.stage3SplitDelay = 0.0;

        return true;

    }

    return false;        
}


