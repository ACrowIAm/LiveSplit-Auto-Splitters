// 𝙈𝙖𝙙𝙚 𝘽𝙮 𝘼𝘾𝙧𝙤𝙬𝙄𝘼𝙢 (v1.0.0)


state("iwbtggv1d2b")
{
    // Pointer addresses
    int start: "iwbtggv1d2b.exe", 0x2B82E98, 0x48;
    int reset: "iwbtggv1d2b.exe", 0x2B82904, 0xA2;	
    int stageEnter: "iwbtggv1d2b.exe", 0x2B7AE4C, 0x5;	    
    int stage1: "iwbtggv1d2b.exe", 0x2B7BBFC, 0xDC;  
    int stage2: "iwbtggv1d2b.exe", 0x2B7B17C, 0x5C;
    int stage3: "iwbtggv1d2b.exe", 0x2B7AE4C, 0x19;
}

startup
{
    // Setting creation
    settings.Add("splittiminggroup", true, "Split Timing");        
    settings.Add("splittiming1", true, "Boss Door Entry", "splittiminggroup");  
    settings.Add("splittiming2", false, "Forth Beep", "splittiminggroup"); 
    settings.Add("splittiming3", false, "Completion Time", "splittiminggroup");     
    settings.Add("splittiming4", false, "World Map", "splittiminggroup");                                 
}

init
{
    // Variables
    vars.startCheck = 0;       
    vars.stage1GateTime = 0.0;
    vars.stage2GateTime = 0.0;
    vars.stage1GateUsed = false;
    vars.stage2GateUsed = false;
    vars.stage1SplitDelay = 0.0;
    vars.stage2SplitDelay = 0.0;
    vars.stage3SplitDelay = 0.0; 
    vars.lastSplitTime = 0.0;    
    vars.splitTiming = 0000.0; 
}

update
{

// Setting toggle logic
if (settings["splittiming1"]) {
        vars.splitTiming = 0000;
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
        vars.splitTiming = 0000;
    }   

    // Start check logic
    if (old.start != 1 && current.start == 1)
        vars.startCheck = 1;
        return true;  
          
    if (old.reset != 1 && current.reset == 1)
        vars.startCheck = 0;
        return true;   

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
        if (vars.stage1GateUsed == false && old.stageEnter != 1 && current.stageEnter == 1)
        {
            vars.stage1GateTime = currentTime;
            vars.stage1GateUsed = true;        
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

    // Stage 2 split logic
    if (timer.CurrentSplitIndex == 1)
        {
        if (vars.stage2GateUsed == false && old.stageEnter != 1 && current.stageEnter == 1)
        {
            vars.stage2GateTime = currentTime;
            vars.stage2GateUsed = true;        
        }

        bool stage2Allowed =
            vars.stage2GateTime > 0 &&
            currentTime >= vars.stage2GateTime + 8000.0;

        if (stage2Allowed && old.stage2 != 1 && current.stage2 == 1)
        {
            vars.stage2SplitDelay = currentTime;
            return false;
        }

        if (vars.stage2SplitDelay > 0 &&
            currentTime >= vars.stage2SplitDelay + vars.splitTiming)
        {
            vars.stage2SplitDelay = 0.0;
            vars.stage2GateTime = 0.0;
            vars.lastSplitTime = currentTime;
            return true;
    }
}

    // Stage 3 split logic     
    if (timer.CurrentSplitIndex == 2)
    {
        if (old.stage3 != 1 && current.stage3 == 1)
        {
            vars.stage3SplitDelay = currentTime;
            return false;
        }

        if (current.stage3 == 1 && vars.stage3SplitDelay > 0 && currentTime >= vars.stage3SplitDelay + 0975.0) // Leave this time alone as the run should always end after around 0.975 seconds after the trigger.
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
    if (vars.startCheck == 1 && old.reset != 1 && current.reset == 1)   
    
    {
        // Sets variables back to default
        vars.stage1GateTime = 0.0;
        vars.stage2GateTime = 0.0;
        vars.stage1GateUsed = false;
        vars.stage2GateUsed = false;   
        vars.stage1SplitDelay = 0.0;       
        vars.stage2SplitDelay = 0.0;      
        vars.stage3SplitDelay = 0.0;

        return true;

    }

    return false;        

}



