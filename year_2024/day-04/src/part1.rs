pub fn process(input: &str) -> String {
    let mut result = 0;

    let word_grid = input.lines().map(|i| i.chars().collect()).collect();

    count_xmas(&mut result, &word_grid);
    count_xmas(&mut result, &rotate_90(&word_grid));
    count_xmas(&mut result, &rotate_45_cw(&word_grid));
    count_xmas(&mut result, &rotate_45_ccw(&word_grid));

    result.to_string()
}

fn count_xmas(result: &mut usize, word_grid: &Vec<Vec<char>>) {
    let stringified = grid_to_string(word_grid);

    *result +=
        stringified.match_indices("XMAS").count() + stringified.match_indices("SAMX").count();
}

fn grid_to_string(word_grid: &Vec<Vec<char>>) -> String {
    let mut word_grid = word_grid.to_owned();

    word_grid.iter_mut().for_each(|line| line.push('\n'));

    word_grid
        .iter()
        .map(|line| line.iter().collect::<String>())
        .collect()
}

fn rotate_90(word_grid: &Vec<Vec<char>>) -> Vec<Vec<char>> {
    let mut output = vec![vec!['l'; word_grid[0].len()]; word_grid[0].len()];

    for (y, line) in word_grid.iter().enumerate() {
        for (x, item) in line.iter().enumerate() {
            output[x][word_grid.len() - 1 - y] = item.clone();
        }
    }

    output
}

fn rotate_45_cw(word_grid: &Vec<Vec<char>>) -> Vec<Vec<char>> {
    let mut output = word_grid.to_owned();

    for (i, line) in output.iter_mut().enumerate() {
        for _ in 0..word_grid.len() - i - 1 {
            line.insert(0, 'l');
        }

        for _ in 0..i {
            line.push('l');
        }
    }

    rotate_90(&output)
}

fn rotate_45_ccw(word_grid: &Vec<Vec<char>>) -> Vec<Vec<char>> {
    let mut output = word_grid.to_owned();

    for (i, line) in output.iter_mut().enumerate() {
        for _ in 0..i {
            line.insert(0, 'l');
        }

        for _ in 0..word_grid.len() - i - 1 {
            line.push('l');
        }
    }

    rotate_90(&output)
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_process() {
        let result = process(include_str!("../test_input1.txt"));
        let expected = 18.to_string();
        assert_eq!(result, expected);
    }
}
