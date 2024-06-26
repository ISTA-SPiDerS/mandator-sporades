scenario=$1
arrival=$2
replicaBatchSize=$3
replicaBatchTime=$4
setting=$5 # LAN or WAN
pipelineLength=$6
conflicts=$7
clientWindow=$8
clientBatchSize=$9
collectClientLogs=${10}
isLeaderKill=${11}
iteration=${12}

pwd=$(pwd)
. "${pwd}"/experiments/setup-5/ip.sh

remote_algo_path="/mandator/binary/epaxos_server"
remote_ctl_path="/mandator/binary/epaxos_client"
remote_master_path="/mandator/binary/epaxos_master"

echo "Starting execution latency test"

output_path="${pwd}/experiments/${scenario}/logs/epaxos/${arrival}/${replicaBatchSize}/${replicaBatchTime}/${setting}/${pipelineLength}/${conflicts}/${clientWindow}/${clientBatchSize}/${iteration}/execution/"
rm -r "${output_path}" ; mkdir -p "${output_path}"
echo "Removed old local log files"

for i in "${machines[@]}"
do
   echo "killing instances and removing old files in ${i}"
   sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f "$i" "${reset_logs}; ${kill_command}; ${kill_command}; ${kill_command}"
done

sleep 2

echo "starting master"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica1} ".${remote_master_path} -N 5 " >${output_path}1.log &

sleep 5

echo "starting replicas"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica1} ".${remote_algo_path}  -port 10070 -maddr ${replica1_ip} -addr ${replica1_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -exec  -dreply -e" >${output_path}2.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica2} ".${remote_algo_path}  -port 10071 -maddr ${replica1_ip} -addr ${replica2_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -exec  -dreply -e" >${output_path}3.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica3} ".${remote_algo_path}  -port 10072 -maddr ${replica1_ip} -addr ${replica3_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -exec  -dreply -e" >${output_path}4.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica4} ".${remote_algo_path}  -port 10073 -maddr ${replica1_ip} -addr ${replica4_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -exec  -dreply -e" >${output_path}5.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica5} ".${remote_algo_path}  -port 10074 -maddr ${replica1_ip} -addr ${replica5_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -exec  -dreply -e" >${output_path}6.log &
sleep 5


echo "Starting client[s]"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client1} ".${remote_ctl_path} -name 7     -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 0 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}21.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client2} ".${remote_ctl_path} -name 8     -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 1 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}22.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client3} ".${remote_ctl_path} -name 9     -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 2 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}23.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client4} ".${remote_ctl_path} -name 10    -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 3 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}24.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client5} ".${remote_ctl_path} -name 11    -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 4 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}25.log &

sleep 10

if [[ "${isLeaderKill}" == "yes" ]]
then
  echo "killing the first leader"
  sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} "${replica1}" "${kill_command};${kill_command}"
fi

sleep 100

echo "Completed Client[s]"

if [[ "${collectClientLogs}" == "yes" ]]
then
  echo "collecting client logs"
  scp -i ${cert} ${client1}:${remote_log_path}7.txt  ${output_path}21.txt
  scp -i ${cert} ${client2}:${remote_log_path}8.txt  ${output_path}22.txt
  scp -i ${cert} ${client3}:${remote_log_path}9.txt  ${output_path}23.txt
  scp -i ${cert} ${client4}:${remote_log_path}10.txt ${output_path}24.txt
  scp -i ${cert} ${client5}:${remote_log_path}11.txt ${output_path}25.txt
fi

echo "finished execution latency test"

######################
pwd=$(pwd)
. "${pwd}"/experiments/setup-5/ip.sh

echo "Starting commit latency test"

output_path="${pwd}/experiments/${scenario}/logs/epaxos/${arrival}/${replicaBatchSize}/${replicaBatchTime}/${setting}/${pipelineLength}/${conflicts}/${clientWindow}/${clientBatchSize}/${iteration}/commit/"
rm -r "${output_path}" ; mkdir -p "${output_path}"
echo "Removed old local log files"


for i in "${machines[@]}"
do
   echo "killing instances and removing old files in ${i}"
   sshpass ssh -o "StrictHostKeyChecking no" -i ${cert}  -n -f "$i" "${reset_logs}; ${kill_command}; ${kill_command}; ${kill_command}"
done

sleep 2

echo "starting master"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica1} ".${remote_master_path} -N 5 " >${output_path}1.log &

sleep 5

echo "starting replicas"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica1} ".${remote_algo_path}  -port 10070 -maddr ${replica1_ip} -addr ${replica1_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -e" >${output_path}2.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica2} ".${remote_algo_path}  -port 10071 -maddr ${replica1_ip} -addr ${replica2_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -e" >${output_path}3.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica3} ".${remote_algo_path}  -port 10072 -maddr ${replica1_ip} -addr ${replica3_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -e" >${output_path}4.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica4} ".${remote_algo_path}  -port 10073 -maddr ${replica1_ip} -addr ${replica4_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -e" >${output_path}5.log &
sleep 5
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica5} ".${remote_algo_path}  -port 10074 -maddr ${replica1_ip} -addr ${replica5_ip} -batchSize ${replicaBatchSize} -batchTime ${replicaBatchTime}  -pipeline ${pipelineLength}    -e" >${output_path}6.log &
sleep 5


echo "Starting client[s]"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client1} ".${remote_ctl_path} -name 7     -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 0 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}21.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client2} ".${remote_ctl_path} -name 8     -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 1 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}22.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client3} ".${remote_ctl_path} -name 9     -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 2 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}23.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client4} ".${remote_ctl_path} -name 10    -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 3 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}24.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client5} ".${remote_ctl_path} -name 11    -maddr ${replica1_ip} -w 50  -c ${conflicts} -arrivalRate ${arrival} -clientBatchSize ${clientBatchSize} -defaultReplica 4 -logFilePath ${remote_log_path} --window ${clientWindow}" >${output_path}25.log &

sleep 10

if [[ "${isLeaderKill}" == "yes" ]]
then
  echo "killing the first leader"
  sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} "${replica1}" "${kill_command}; ${kill_command}"
fi

sleep 100

echo "Completed Client[s]"

if [[ "${collectClientLogs}" == "yes" ]]
then
  echo "collecting client logs"
  scp -i ${cert} ${client1}:${remote_log_path}7.txt  ${output_path}21.txt
  scp -i ${cert} ${client2}:${remote_log_path}8.txt  ${output_path}22.txt
  scp -i ${cert} ${client3}:${remote_log_path}9.txt  ${output_path}23.txt
  scp -i ${cert} ${client4}:${remote_log_path}10.txt ${output_path}24.txt
  scp -i ${cert} ${client5}:${remote_log_path}11.txt ${output_path}25.txt
fi

echo "finished commit latency test"

