#include <iostream>
#include <fstream>
#include <vector>

uint do_slope(const std::vector<std::string>& slope, uint x_step, uint y_step){
	uint x_pos = 0;
	uint nr_of_obstacles = 0;

	for (uint i = 0; i < slope.size(); i+=y_step){
		static int const x_len = slope.at(i).size();

		if (slope.at(i).at(x_pos) == '#'){
			nr_of_obstacles++;
		}

		x_pos = (x_pos + x_step) % x_len;
	}

	return nr_of_obstacles;
}

int main(int argc, char* argv[]) {
	if (argc < 2) {
		std::cout << "Please provide input file" << std::endl;
		return 1;
	}
	std::ifstream infile;
	infile.open(argv[1]);

	if (!infile.good()) {
		std::cout << "Could not open file" << std::endl;
		return 1;
	}

	std::string line;
	uint x_pos = 0;
	std::vector<std::string> slope;
	while (std::getline(infile, line)) {
		slope.push_back(line);
	}
	infile.close();

	std::cout << "Obstacles (Part 1): " << do_slope(slope, 3, 1) << std::endl;

	uint part2 = do_slope(slope, 1, 1)
			* do_slope(slope, 3, 1)
			* do_slope(slope, 5, 1)
			* do_slope(slope, 7, 1)
			* do_slope(slope, 1, 2);
	std::cout << "Obstacles (Part 2): " << part2 << std::endl;

	return 0;
}
