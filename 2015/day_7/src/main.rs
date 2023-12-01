#[derive(Debug)]
struct Action {
    instruction: Instruction,
    target: String,
}

#[derive(Debug)]
enum InstructionInput {
    Wire(String),
    Current(u16),
}

#[derive(Debug)]
enum Instruction {
    And {
        left: InstructionInput,
        right: InstructionInput,
    },
    Or {
        left: InstructionInput,
        right: InstructionInput,
    },
    LShift {
        left: String,
        right: u16,
    },
    RShift {
        left: String,
        right: u16,
    },
    Not(String),
    NumberAssignment(u16),
    WireAssignment(String),
}

fn main() {
    let input = parse_input();
    println!("{:#?}", input);
}

fn parse_input() -> Vec<Action> {
    let mut actions: Vec<Action> = vec![];
    let file = std::fs::read_to_string("input.txt").unwrap();

    for line in file.lines() {
        let segments = line.split_ascii_whitespace().collect::<Vec<&str>>();
        println!("{:#?}", segments);
        let instruction: Instruction;

        instruction = Instruction::And {
            left: InstructionInput::Current(23),
            right: InstructionInput::Current(24),
        };

        actions.push(Action {
            instruction,
            target: segments.last().unwrap().to_owned().to_owned(),
        })
    }

    actions
}
