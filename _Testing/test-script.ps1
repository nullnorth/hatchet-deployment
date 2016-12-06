configuration DSC-test-script 
{

    Node $AllNodes.Where{$_.Role -eq "Primary DC"}.Nodename
    {
    LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true
        }
        
    script Scripttest
        {
            GetScript = 
            {
                $env:COMPUTERNAME
            }
            TestScript = 
            {
            }
            SetScript = 
            {
            }    
        }         
    }
}