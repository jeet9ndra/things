package tasks

import "core:fmt"
import "core:os"
import "core:strings"
import "core:time/datetime"


allowed: string = ``

inbytes: [256]byte
inbytesCount: int = 0
err: os.Error

main :: proc() {
	fmt.println(actions)
	fmt.printfln("%p == %p  = %v", actions, keywords, &actions == &keywords)

	for {
	fmt.print("type command:\n")
	inbytesCount, err = os.read(os.stdin, inbytes[:])
	if(inbytesCount>1){
	fmt.print(string(inbytes[:inbytesCount - 1]))
	lex_input()
	}
	else{break}
	}
}


keywords: []string = {
	"create",
	"remove",
	"complete",
	"edit",
	"exit","quit",
	//--> actions
	"task",
	"remainder",
	"event",
	"switch",
	//--> data_types
}
actions: []string = keywords[:6]

action_sequence :: struct {
	action:   int,
	datatype: int,
}

lex_input :: proc() {

	fmt.println(strings.split_n(string(inbytes[:inbytesCount - 2]), " ", 3))

	items:=strings.split_n(string(inbytes[:inbytesCount - 2]), " ", 3)
	
	if items[0]== actions[4] ||items[0]== actions[5] {
		os.exit(0)
	}
	for a in items{
		
	}

}




default_remainder_tune :: ""

remainder :: struct {
	status:        u8,
	name:          string,
	description:   string,
	reminder_time: datetime.DateTime,
	tune:          string,
}

task :: struct {
	status: u8,
	name:   string,
}

task_link :: struct {
	v:         task,
	next_task: ^task,
}
task_linked_list :: struct {
	start: task_link,
	last:  task_link,
	count: int,
}

all_tasks: task_linked_list

in_task_name: string
in_task_status: u8

new_task :: proc() {

}
