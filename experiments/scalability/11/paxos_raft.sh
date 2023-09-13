scenario="scalability-11"
arrival=$1
replicaBatchSize=3000
replicaBatchTime=5000
clientBatchSize=50
clientBatchTime=1000
setting="WAN" # LAN or WAN
pipelineLength=10
algo="paxos"
asyncTimeout=0
benchmarkMode=1 # 0 or 1
asyncTimeEpochSize=500
viewTimeout=300000000
clientWindow=1000
collectClientLogs="no"
isLeaderKill="no"
iteration=1

pwd=$(pwd)
. "${pwd}"/experiments/setup-11/ip.sh

remote_algo_path="/mandator/binary/pa_ra_replica"
remote_ctl_path="/mandator/binary/pa_ra_client"


remote_config_path="/home/${user_name}/mandator/binary/paxos.yml"

echo "Starting test"

output_path="${pwd}/experiments/${scenario}/logs/paxos/${arrival}/"
rm -r "${output_path}" ; mkdir -p "${output_path}"

echo "Removed old local log files"

for i in "${machines[@]}"
do
   echo "killing instances and removing old files in ${i}"
   sshpass ssh -o "StrictHostKeyChecking no" -i ${cert}  -n -f "$i" "${reset_logs}; ${kill_command}; ${kill_command}; ${kill_command}"
done


nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica1}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 1  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}1.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica2}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 2  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}2.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica3}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 3  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}3.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica4}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 4  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}4.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica5}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 5  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}5.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica6}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 6  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}6.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica7}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 7  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}7.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica8}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 8  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}8.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica9}  ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 9  --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}9.log  &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica10} ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 10 --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}10.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} -n -f ${replica11} ".${remote_algo_path} --asyncTimeout ${asyncTimeout} --batchSize ${replicaBatchSize} --batchTime ${replicaBatchTime} --benchmarkMode ${benchmarkMode} --config ${remote_config_path}  --consAlgo ${algo} --isAsync --logFilePath ${remote_log_path} --name 11 --pipelineLength ${pipelineLength} --timeEpochSize ${asyncTimeEpochSize} --viewTimeout ${viewTimeout} " >${output_path}11.log &

sleep 10

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client1} ".${remote_ctl_path} --name 21 --config ${remote_config_path} --logFilePath ${remote_log_path} --requestType status --operationType 1" >${output_path}status1.log &
echo "Sent initial status"

sleep 15

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client2} ".${remote_ctl_path} --name 22 --config ${remote_config_path} --logFilePath ${remote_log_path} --requestType status --operationType 3" >${output_path}status3.log &
echo "Sent consensus start up"

sleep 30

echo "Starting client[s]"

nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client1}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 21 --requestType request --window ${clientWindow} " >${output_path}21.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client2}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 22 --requestType request --window ${clientWindow} " >${output_path}22.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client3}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 23 --requestType request --window ${clientWindow} " >${output_path}23.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client4}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 24 --requestType request --window ${clientWindow} " >${output_path}24.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client5}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 25 --requestType request --window ${clientWindow} " >${output_path}25.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client6}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 26 --requestType request --window ${clientWindow} " >${output_path}26.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client7}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 27 --requestType request --window ${clientWindow} " >${output_path}27.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client8}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 28 --requestType request --window ${clientWindow} " >${output_path}28.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client9}  ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 29 --requestType request --window ${clientWindow} " >${output_path}29.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client10} ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 30 --requestType request --window ${clientWindow} " >${output_path}30.log &
nohup sshpass ssh -o "StrictHostKeyChecking no" -i ${cert} ${client11} ".${remote_ctl_path} --arrivalRate ${arrival} --batchSize ${clientBatchSize} --batchTime ${clientBatchTime} --config ${remote_config_path} --logFilePath ${remote_log_path} --name 31 --requestType request --window ${clientWindow} " >${output_path}31.log &

sleep 15

sleep 110

echo "Completed Client[s]"

echo "Finish test"