# this file assigns the ip address of each replica and client to variables
pwd=$(pwd)
cert=${pwd}/experiments/private_key_aws/pasindu2023
user_name="ubuntu"

replica1_name=ec2-3-27-164-21.ap-southeast-2.compute.amazonaws.com
replica1=${user_name}@${replica1_name}

replica2_name=ec2-52-68-193-183.ap-northeast-1.compute.amazonaws.com
replica2=${user_name}@${replica2_name}

replica3_name=ec2-13-125-56-107.ap-northeast-2.compute.amazonaws.com
replica3=${user_name}@${replica3_name}

client1_name=ec2-54-206-135-165.ap-southeast-2.compute.amazonaws.com
client1=${user_name}@${client1_name}

client2_name=ec2-52-194-247-6.ap-northeast-1.compute.amazonaws.com
client2=${user_name}@${client2_name}

client3_name=ec2-52-79-90-1.ap-northeast-2.compute.amazonaws.com
client3=${user_name}@${client3_name}

declare -a machines=(${replica1} ${replica2} ${replica3}  ${client1} ${client2} ${client3})
echo "ip addresses loaded"

replica1_ip="3.27.164.21"
replica2_ip="52.68.193.183"
replica3_ip="13.125.56.107"

client1_ip="54.206.135.165"
client2_ip="52.194.247.6"
client3_ip="52.79.90.1"


kill_command="pkill epaxos_master ; pkill epaxos_server; pkill epaxos_client; pkill man_client; pkill man_replica;  pkill pa_ra_replica ; pkill pa_ra_client; pkill pipe_client; pkill pipe_replica; pkill rabia"
remote_log_path="/home/${user_name}/mandator/logs/"
reset_logs="rm -r ${remote_log_path} ; mkdir -p ${remote_log_path}"

for i in "${machines[@]}"
do
   echo "killing instances and removing old files in ${i}"
   sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} "$i" "${reset_logs}; ${kill_command}; ${kill_command}; ${kill_command}"
done

