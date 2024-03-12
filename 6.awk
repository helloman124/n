BEGIN {
	rcvd = 0
	start = 999
	stop = 0
}
{
	ev = $1
	time = $2
	pkt = $8
	lvl = $4
	if (lvl == "AGT" && ev=="s" && pkt>=512) {
		if (start > time) {
			start = time
		}
	}
	if (lvl == "AGT" && ev=="r" && pkt>=512) {
		if(stop < time) {
			stop = time
		}
		hdr = pkt%512
		pkt -= hdr
		rcvd +=pkt
	}
}

END {
	printf("Average Throughput = %.2f Mbps\nStart Time = %.2f\n Stop Time = %.2f\n", (rcvd/(stop-start))*(8/1e6), start, stop)
}
