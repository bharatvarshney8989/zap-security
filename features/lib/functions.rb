#encoding: UTF-8

def launch_owasp_zap
  $zap_path = '/Users/amermer/Desktop/ZAP_2.4.3'
  Dir.chdir($zap_path){
    if determine_os == 'windows'
      system("taskkill /im java.exe /f")
      system("taskkill /im javaw.exe /f")
      IO.popen("zap.bat -daemon")
    else
      system("pkill java")
      IO.popen("./zap.sh -daemon")
    end
    sleep 5
  }
  p "Owasp Zap launch completed"
  sleep 20
end

def determine_os
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    return 'windows'
  elsif (/darwin/ =~ RUBY_PLATFORM) != nil
    return 'mac'
  else
    return 'linux'
  end
end