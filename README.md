random_scripts
==============

A variety of useful scripts, mostly here for archival purposes

java\_thread\_dumps
-------------------
Scripts for doing surface-level analysis of Java thread dumps as captured by jstack. Both can be used with stdin as well.

* extract\_stacks\_by\_regex

    An awk script that will extract any stack trace in a thread dump where any line contains the passed-in regex.
    
    Usage: awk -f extract\_\stacks\_by\_regex -v regex=_regex_ _file_ 
    
* summarize\_thread\_dump
    
    An awk script that will provide a quick summary of a thread dump. It will show number of threads in various states and then summarize the number of threads in each
    code path by finding the first line in a stack that doesn't have java or sun in it (in other words, the first code likely to be yours or a third-party library you're using)
    and then aggregating those lines to show the sum. 
    
    Usage: awk -f summarize\_thread\_dump _file_
  
