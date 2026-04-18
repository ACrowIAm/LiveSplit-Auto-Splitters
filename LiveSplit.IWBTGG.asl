// 𝙈𝙖𝙙𝙚 𝘽𝙮 𝘼𝘾𝙧𝙤𝙬𝙄𝘼𝙢 (v1.1.1)


state("iwbtgg")
{
    int start: "iwbtgg.exe", 0x2A49EBC, 0xF48;
    int reset: "iwbtgg.exe", 0x2A1C4F4, 0xDF4;	   
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
    settings.Add("warning1", true, "IMPORTANT: Don't use this Auto Splitter."); 
} 

init
{
    vars.lastSplitTime = 0.0;
    vars.stage1SplitDelay = 0.0;
    vars.stage3SplitDelay = 0.0;
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
    return old.start != 1 && current.start == 1;
}

split
{
    double currentTime = timer.CurrentTime.RealTime.GetValueOrDefault().TotalMilliseconds;

    if (currentTime < (vars.lastSplitTime + 500.0))
    {
        return false;
    }

    if (timer.CurrentSplitIndex == 0)
    {
        if (old.stage1 != 1 && current.stage1 == 1)
        {
            vars.stage1SplitDelay = currentTime;
            return false;
        }

        if (current.stage1 == 1 && vars.stage1SplitDelay > 0 && currentTime >= vars.stage1SplitDelay + 2012.0) // Adjust the time after the "+" to change the splits timing.
        {
            vars.stage1SplitDelay = 0.0;
            vars.lastSplitTime = currentTime;
            return true;
        }

        if (current.stage1 != 1 && vars.stage1SplitDelay > 0)
        {
            vars.stage1SplitDelay = 0.0;
        }
    }
            
    if (timer.CurrentSplitIndex == 1)
    {
        if (old.stage3 != 1 && current.stage3 == 1)
        {
            vars.stage3SplitDelay = currentTime;
            return false;
        }

        if (current.stage3 == 1 && vars.stage3SplitDelay > 0 && currentTime >= vars.stage3SplitDelay + 0988.0) // Leave this time alone as the run should always end after around 1.065 seconds.
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
    return old.reset != 1 && current.reset == 1; 
}
