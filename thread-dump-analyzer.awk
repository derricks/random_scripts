# interactive thread dump analyzer
BEGIN {
	total_stacks = 1
	current_stack = ""
}

# you're in a stack if the line starts with ". Note that there's some header info that doesn't start with
# " and we deliberately ignore those.
/^[ \t]*"/ {in_stack = true}

# Once you hit a line break, if you're in a stack, capture the current_stack into stack_list
# and reset state-tracking variables
in_stack == true && /^[ \t]*$/ {
  stack_list[total_stacks] = current_stack

  in_stack = false
  current_stack = ""
  total_stacks = total_stacks + 1
}

# if you're in a stack, add this line to the current_stack
in_stack == true {
	current_stack = current_stack "\n" $0
}

function parse_command(command, args) {
}

END {
  prompt = ""
  command = ""

  #while(command != "quit") {
    printf (prompt ":")
    getline line < "-"
    
    # parse into command and arguments
    num_tokens = split(line, line_components, " ")
    command = line_components[1]

    if (num_tokens > 1) {
      for (token_index = 2; token_index <= num_tokens; token_index++) {
        args[token_index - 1] = line_components[token_index]
      }
    }

    parse_command(command, args)
  #}
}