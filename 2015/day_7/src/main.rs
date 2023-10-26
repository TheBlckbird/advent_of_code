use std::thread::panicking;

use pest::Parser;
use pest_derive::Parser;

#[derive(Debug)]
struct Action {
    instruction: Instruction,
    target: String,
}

#[derive(Debug)]
enum Instruction {
    And {
        left_number: Option<u16>,
        right_number: Option<u16>,
        left_wire: Option<String>,
        right_wire: Option<String>,
    },
    Or {
        left_number: Option<u16>,
        right_number: Option<u16>,
        left_wire: Option<String>,
        right_wire: Option<String>,
    },
    LShift {
        left_number: Option<u16>,
        right_number: Option<u16>,
        left_wire: Option<String>,
        right_wire: Option<String>,
    },
    RShift {
        left_number: Option<u16>,
        right_number: Option<u16>,
        left_wire: Option<String>,
        right_wire: Option<String>,
    },
    Not(String),
    NumberAssignment(u16),
    WireAssignment(String),
}
fn main() {
    let input = parse_input();
    println!("{:#?}", input);
}

#[derive(Parser)]
#[grammar = "grammar.pest"]
pub struct InputParser;

fn parse_input() -> Vec<Action> {
    let mut actions: Vec<Action> = vec![];
    let unparsed_file = std::fs::read_to_string("input.txt").unwrap();
    let parsed_file =
        InputParser::parse(Rule::file, &unparsed_file).unwrap_or_else(|e| panic!("{}", e));

    for line in parsed_file {
        let mut parsed_instruction = line.into_inner().next().unwrap().into_inner();
        let mut instruction: Instruction;
        let mut target: String = parsed_instruction.next().unwrap().as_str().to_owned();

        match parsed_instruction.len() {
            1 => {
                match parsed_instruction.next().unwrap().as_rule() {
                    Rule::wire => {
                        ////
                        instruction = Instruction::WireAssignment(
                            parsed_instruction.next().unwrap().as_str().to_owned(),
                        )
                    }
                    Rule::number => {
                        instruction = Instruction::NumberAssignment(
                            parsed_instruction
                                .next()
                                .unwrap()
                                .as_str()
                                .to_owned()
                                .trim()
                                .parse()
                                .unwrap(),
                        )
                    }
                    _ => unreachable!(),
                }
            }
            2 => {
                parsed_instruction.next();
                instruction =
                    Instruction::Not(parsed_instruction.next().unwrap().as_str().to_owned());
            }
            3 => {
                let left = parsed_instruction.next().unwrap();

                let instruction_action = parsed_instruction.next().unwrap().as_str();

                let left_number: Option<u16>;
                let left_wire: Option<String>;
                let right_number: Option<u16>;
                let right_wire: Option<String>;

                match left.as_str().parse::<u16>() {
                    Ok(number) => {
                        left_number = Some(number);
                        left_wire = None;
                    }
                    Err(_) => {
                        left_number = None;
                        left_wire = Some(left.as_str().to_owned());
                    }
                }

                // let right_number: Result<u16, _> =

                match parsed_instruction.next().unwrap().as_str().parse() {
                    Ok(number) => {
                        right_number = Some(number);
                        right_wire = None;
                    }
                    Err(_) => {
                        right_number = None;
                        right_wire = Some(parsed_instruction.next().unwrap().as_str().to_owned());
                    }
                }

                match instruction_action {
                    "AND" => {
                        instruction = Instruction::And {
                            left_number,
                            left_wire,
                            right_number,
                            right_wire,
                        }
                    }
                    "OR" => {
                        instruction = Instruction::Or {
                            left_number,
                            left_wire,
                            right_number,
                            right_wire,
                        }
                    }
                    "LSHIFT" => {
                        instruction = Instruction::LShift {
                            left_number,
                            left_wire,
                            right_number,
                            right_wire,
                        }
                    }
                    "RSHIFT" => {
                        instruction = Instruction::RShift {
                            left_number,
                            left_wire,
                            right_number,
                            right_wire,
                        }
                    }
                    _ => unreachable!(),
                }
                // println!("{:#?}", parsed_instruction);
            }
            _ => unreachable!(),
        }

        actions.push(Action {
            instruction,
            target,
        })
        // println!("{:#?}", line.into_inner().next().unwrap().into_inner());
    }

    actions
}
