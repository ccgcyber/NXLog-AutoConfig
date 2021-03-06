if(Test-Path "$script:binPath\autorunsc.exe"){
    Start-Process -FilePath "$script:binPath\autorunsc.exe" -ArgumentList "/accepteula -a * -ct -h -m -s -t" -RedirectStandardOutput "C:\Windows\Temp\autorun.csv"
}

$conf += '<Input autorun_in>
  Module	im_file
  File		"C:\Windows\Temp\autorun.csv"
  Exec $NXLogHostname = '
  $conf += "'"
  $conf += $env:computername
  $conf += "';"
  $conf += '
  Exec to_json();
</Input>

<Processor autorun_buffer>
    Module      pm_buffer
    # 1Mb buffer
    MaxSize 1024
    Type Mem
    # warn at 512k
    WarnLimit 512
</Processor>
 
<Output autorun_out>
    Module      om_tcp
    Host        '
    $conf += $script:logstashHost
    $conf += '
    Port        5001
</Output>

<Route autorun>
   Path autorun_in => autorun_buffer => autorun_out
</Route>

'
