#!/bin/bash
# Test cron script
# Appends timestamp to a log file

echo "Cron ran at:  $(date)" >> ~/devops-learning/cron-test.log
# >> = append to file (doesn't overwrite)
# $(date) = current date/time

