# curl-metrics

I often have to measure the performance of web assets. 

There are a lot of tools and services out there, and for global performance measurement I use Catchpoint anyway, but now and then a simple script to download an asset a 100 times is more than enough. 

curl supports the -w or --write-out switch, which can be used to output request and response variables, including important metrics. 
The timing script runs curl multiple times and outputs each invocation's metrics to a CSV file for further processing. 
