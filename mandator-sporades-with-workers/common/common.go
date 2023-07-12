package common

import (
	"async-consensus/configuration"
	"async-consensus/proto"
	"bytes"
	"encoding/gob"
	"fmt"
	"strconv"
	"strings"
	"time"
)

/*
	RPC pair assigns a unique uint8 to each type of message defined in the proto files
*/

type RPCPair struct {
	Code uint8
	Obj  proto.Serializable
}

/*
	Outgoing RPC assigns a rpc to its intended destination
*/

type OutgoingRPC struct {
	RpcPair *RPCPair
	Peer    int32
}

/*
	Returns the self ip:port
*/

func GetAddress(nodes []configuration.Instance, name int32) string {
	for i := 0; i < len(nodes); i++ {
		if nodes[i].Name == strconv.Itoa(int(name)) {
			return nodes[i].Address
		}
	}
	return ""
}

/*
	prints the debug message to stdout, depending on the debug level
*/

func Debug(message string, level int, currentLevel int, isDebugOn bool) {
	if isDebugOn && level >= currentLevel {
		fmt.Printf(message + "\n")
	}
}

/*
	Accepts a unique id of them form id.sequence and returns the [id, sequence]
*/

func ExtractSequenceNumber(unique_id string) (int32, int) {
	strSequence := strings.Split(unique_id, ".")[1]
	intSequence, _ := strconv.Atoi(strSequence)

	strNode := strings.Split(unique_id, ".")[0]
	intNode, _ := strconv.Atoi(strNode)
	int32Node := int32(intNode)

	return int32Node, intSequence
}

/*
	Accepts a map[int32]int and returns a random key
*/

func Get_Some_Node(m map[int32]int) int32 {
	for k := range m {
		return k // go map iteration is random!
	}
	return 0
}

/*
	Timer for triggering event upon timeout
*/

type TimerWithCancel struct {
	d time.Duration
	t *time.Timer
	c chan interface{}
	f func()
}

/*
	instantiate a new timer with cancel
*/

func NewTimerWithCancel(d time.Duration) *TimerWithCancel {
	t := &TimerWithCancel{}
	t.d = d
	t.c = make(chan interface{}, 5)
	return t
}

/*
	Start the timer
*/

func (t *TimerWithCancel) Start() {
	t.t = time.NewTimer(t.d)
	go func() {
		for true {
			select {
			case <-t.t.C:
				t.f()
				return
			case <-t.c:
				return
			default:
				time.Sleep(time.Duration(1) * time.Millisecond)
			}
		}
	}()
}

/*
	Set a function to call when timeout
*/

func (t *TimerWithCancel) SetTimeoutFuntion(f func()) {
	t.f = f
}

/*
	Cancel timer

*/
func (t *TimerWithCancel) Cancel() {
	select {
	case t.c <- nil:
		// Success
		break
	default:
		//Unsuccessful
		break
	}

}

/*
	A util function to get the size of a message
*/

func GetRealSizeOf(v interface{}) (int, error) {
	b := new(bytes.Buffer)
	if err := gob.NewEncoder(b).Encode(v); err != nil {
		return 0, err
	}
	return b.Len(), nil
}