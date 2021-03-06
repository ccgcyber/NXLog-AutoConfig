$caption = (Get-WmiObject -class Win32_OperatingSystem).Caption
if(($caption -match "2003") -or ($caption -match "XP")){
    $win_module = "im_mseventlog"
} else {
    $win_module = "im_msvistalog"
}

$conf += "<Input eventlog>
"
$conf += "    Module      $win_module
"
$conf += '	Exec if string($EventID) =~ /5156/ drop(); 								# Filter out Windows Firewall has allowed a connection
    Exec if string($EventID) =~ /5145/ drop(); 								# Filter out network share object access check
    Exec if string($EventID) =~ /^16$/ drop(); 								# Filter out counter could not be modified
	Exec if string($EventID) =~ /4656/ drop();
    Exec if string($EventID) =~ /36887/ drop();								# A handle to an object was requested
	Exec if string($EventID) =~ /4658/ drop();								# The handle to an object was closed
	Exec if string($EventID) =~ /4663/ drop();								# An attempt was made to access an object
	Exec if string($EventID) =~ /5158/ drop(); 								# Filter out Windows Firewall has allowed local bind
	Exec if string($EventID) =~ /5154/ drop(); 								# Filter out Windows Firewall has allowed a port
	Exec if string($EventID) =~ /4985/ drop(); 								# Filter out Windows state of a transaction has changed
	Exec if string($DestAddress) =~ /255\.255\.255\.255/ drop();			# Drop broadcast traffic
	Exec if string($DestAddress) =~ /\.255$/ drop();						# Drop broadcast traffic
	Exec if string($SourceAddress) =~ /\.255$/ drop();						# Drop broadcast traffic
	Exec if string($DestAddress) =~ /224\.0\.0\./ drop();					# Drop multicast traffic
	Exec if string($SourceAddress) =~ /224\.0\.0\./ drop();					# Drop multicast traffic
	Exec if string($DestAddress) =~ /^ff02/ drop();							# Drop IPv6 multicast traffic
	Exec if string($SourceAddress) =~ /^ff02/ drop();						# Drop IPv6 multicast traffic
	Exec if string($DestAddress) =~ /239\.255\.255\.250/ drop();			# Drop multicast traffic
	Exec if string($PrivilegeList) =~ /SeSystemtimePrivilege/ drop();		# Drop Time Privilege events
	Exec if string($PrivilegeList) =~ /SeBackupPrivilege/ drop();			# Drop SeBackupPrivilege until users are not admins
	Exec if string($PrivilegeList) =~ /SeCreateGlobalPrivilege/ drop();		# Drop SeCreateGlobalPrivilege use
	Exec if string($RuleId) =~ /CoreNet-Teredo-In/ drop();					# Drop CoreNet-Teredo-In rule failures as it is going to happen
	Exec if string($RuleId) =~ /CoreNet-IPHTTPS-In/ drop();					# Drop CoreNet-IPHTTPS-In rule failures as it is going to happen
	Exec if string($Application) =~ /ntp/ drop();							# Drop ntp related application logs
	Exec if string($ProcessName) =~ /ntpd/ drop();							# Drop ntpd related application logs
	Exec if string($ProcessName) =~ /dellpad/ drop();						# Drop dell related application logs
	Exec if string($ProcessName) =~ /hidfind/ drop();						# Drop dell hidfind related application logs
	Exec if string($CommandLine) =~ /esif_assist/ drop();						# Drop intel NIC sysmon events
	Exec if string($Image) =~ /HPNetworkCommunicator/ drop();					# Drop HP sysmon events
	Exec if string($Image) =~ /nessus/ drop();					# Drop nessus sysmon events
	Exec if string($Image) =~ /NetApp/ drop();						# Drop Sysmon NetApp related application logs
	Exec if string($Image) =~ /lwldatasvc/ drop();						# Drop Sysmon Liquidware related application logs
	Exec if string($Image) =~ /PrintIsolationHost/ drop();						# Drop Sysmon PrintIsolationHost related application logs
	Exec if string($EventID) =~ /5158/ and string($Application) =~ /chrome/ drop(); # Drop chrome logs
	Exec if string($EventID) =~ /5157/ and string($Application) =~ /svchost/ drop(); # Drop svchost firewall blocks
	Exec if string($EventID) =~ /5157/ and string($Application) =~ /System/ drop(); # Drop system firewall blocks
	Exec if string($EventID) =~ /5157/ and string($Application) =~ /mcscript_inuse/ drop(); # Drop mcafee firewall blocks
	Exec if string($EventID) =~ /4674/ and string($Application) =~ /chrome/ drop(); # Drop chrome logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /System/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /lsass/ drop(); # Drop lsass listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /svchost/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /winit/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /services/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /tunnelserver/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /teamviewer/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /spoolsv/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /liquidware/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /mdnsresponder/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /5154/ and string($Application) =~ /applemobiledeviceservice/ drop(); # Drop system listening port logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Dentrix/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /spoolsv/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /System/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Intel/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Trophy/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /F5/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /CommVault/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /dfsrs/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Proxy Networks/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /apache/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /mDNSResponder/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Liquidware/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Lync/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /w3wp/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /EagleSoft/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /TeamViewer/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Netapp/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /taskhost/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /TW/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /SQL/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Epicor/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /BlueNote/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /EMET/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Skype/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Exchange/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /dfssvc/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /DigitalHighway/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /3/ and string($Image) =~ /Teleopti/ drop(); # Drop network connection logs
	Exec if string($EventID) =~ /4624/ and string($TargetUserName) =~ /Solarwinds/ drop(); # Drop Solarwinds Logons
	Exec if string($EventID) =~ /4634/ and string($TargetUserName) =~ /Solarwinds/ drop(); # Drop Solarwinds Logons
	Exec if string($EventID) =~ /4648/ and string($TargetUserName) =~ /Solarwinds/ drop(); # Drop Solarwinds Logons
	Exec if string($ProcessName) =~ /mcshield/ drop();	
	Exec if string($dns_domain) =~ /mcafee/ drop();	
    Exec $EventReceivedTime = integer($EventReceivedTime) / 1000000;
    Exec $NXLogHostname = '
    $conf += "'"
    $conf += $env:computername
    $conf += "';"
    $conf += '
    Exec to_json();
</Input>
 
<Processor windows_buffer>
    Module      pm_buffer
    # 1Mb buffer
    MaxSize 10240
    Type Mem
    # warn at 512k
    WarnLimit 5120
</Processor>

<Output out_windows>
    Module      om_tcp
    Host        '
    $conf += $script:logstashHost
    $conf += '
    Port        5999
</Output>
 
<Route windows>
   Path eventlog => windows_buffer => out_windows
</Route>

'
