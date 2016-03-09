# zap-security

This is a simple project to demonstrate the integration of OWASP ZAP with automated tests written in Ruby.

For this project to work properly, you have to set up your desired browser's proxy to localhost:8095 and reflect this configuration in ZAP.

Also, you need to configure the ZAP executable path in the code: functions.rb -> $zap_path (i know, i know there are much better ways :) ) 
