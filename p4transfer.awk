BEGIN{
count=0;
time=0;
total_sent=0;
total_received=0;
}
{
if($1=="r" && $4==1 && $5=="tcp")
total_received+=$6;
if($1=="+" && $4==1 && $5=="tcp")
total_sent+=$6;
}
END{
printf("The time taken for transmission is %f\n",$2)
printf("actual data sent from server is %f Mbps\n",total_sent/1000000);
printf("Data eceived by the client is %f Mbps\n",total_received/1000000);
}
