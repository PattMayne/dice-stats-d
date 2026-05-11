import std.algorithm, std.stdio;
import std.stdio : writeln;
import std.variant;
import std.sumtype;
import std.random;
import std.typecons;
import std.string;
import std.conv;

// Trying a lambda to get the distance
// we use auto to mark a lambda, unless we 
auto get_distance = (int real_score, int middle_possible_score) => 
    (middle_possible_score > real_score) ? 
    middle_possible_score - real_score : 
    real_score - middle_possible_score;

// multiply the piece by 100 first to prevent int rounding down first
auto get_percentage_distance = (int piece, int whole) =>
    piece * 100 / whole;


auto all_rolls = (int sides, int rolls, ref Random rnd) {
    int score = 0;
    foreach (_; 1 .. rolls + 1) {
        score += uniform(1, sides + 1, rnd);
    }

    return score;
};

void main() {

	// The seed for random numbers
    Random rnd = Random(unpredictableSeed);

    int min_sides = 6;
    int max_sides = 20;
    int min_rolls = 100;
    int max_rolls = 1_000_000;

    writeln("Number of sides (6-20):");
    string sides_input = readln().strip;
    int sides = to!int(sides_input); // parses string to int

    int lowest_possible_roll = 1;
    int highest_possible_roll = sides;

    writeln("Number of rolls (100-1000000):");
    string rolls_input = readln().strip;
    int rolls = to!int(rolls_input); // parses string to int    

    int min_score = lowest_possible_roll * rolls;
    int max_score = highest_possible_roll * rolls;

    int middle_possible_score = ((max_score - min_score) / 2) + min_score;
    int range_of_scores = max_score - min_score;

    int real_score = all_rolls(sides, rolls, rnd);

    int distance_from_middle = get_distance(real_score, middle_possible_score);
    int percent_distance = get_percentage_distance(distance_from_middle, range_of_scores);

    writeln("min score: ", min_score);
    writeln("max score: ", max_score);
    writeln("middle score: ", middle_possible_score);
    writeln("real score: ", real_score);
    writeln("distance from middle: ", distance_from_middle);
    writeln("range of scores: ", range_of_scores);
    writeln("percentage from middle: ", percent_distance);
}

/*
 * So D-Lang is really simple and beautiful.
 * You can do very declarative style programming
 * with c-style syntax.
 *
*/