set ns [new Simulator]
set tf [open p4.tr w]
$ns trace-all $tf
set nf [open p4.nam w]
$ns namtrace-all $nf
$ns color 1 Orange
set n0 [$ns node]
set n1 [$ns node]
$n0 color Red
$n1 color Blue
$n0 label "server"
$n1 label "client"
$ns duplex-link $n0 $n1 0.3Mb 10ms DropTail
$ns duplex-link-op $n0 $n1 orient right
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
$tcp1 set packetSize_ 1500
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1
set ftp [new Application/FTP]
$ftp attach-agent $tcp1
$tcp1 set fid_ 1
$ns at 0.1 "$ftp start"
$ns at 12.0 "finish"
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam p4.nam &
exec awk -f p4transfer.awk p4.tr &
exec awk -f p4convert.awk p4.tr > convert.tr &
exec xgraph convert.tr -geometry 800*400 -t "bytes received at client" -x "time in sec" -y "bytes in bps" &
}

$ns run
