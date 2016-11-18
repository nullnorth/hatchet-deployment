enable-netfirewallrule -displaygroup "Windows Remote Management"
enable-netfirewallrule -displaygroup "Remote Event Log Management"
enable-netfirewallrule -displaygroup "Remote Volume Management"
enable-netfirewallrule -displaygroup "Windows Firewall Remote Management"
set-service VDS -StartupType Automatic