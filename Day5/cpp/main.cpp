#include <iostream>
#include <fstream>
#include <list>

uint const nr_of_rows = 127;
uint const nr_of_cols = 7;

uint get_row(std::string * row_str){
	uint row_high = nr_of_rows;
	uint row_low = 0;

	for (char & c : *row_str) {
		if ( c == 'F' ) {
			row_high = row_high - 1 - ((row_high - row_low) / 2);
		} else {
			row_low = 1 + row_low + ((row_high - row_low) / 2);
		}
	}

	if (row_high != row_low){
		std::cout << "high!=low" << std::endl;
		return 0;
	}

	return row_high;
}

uint get_col(std::string * col_str){
	uint col_high = nr_of_cols;
	uint col_low = 0;

	for (char & c : *col_str){
		if ( c == 'L' ) {
			col_high = col_high - 1 - ((col_high - col_low) / 2);
		} else {
			col_low = 1 + col_low + ((col_high - col_low) / 2);
		}
	}

	if (col_high != col_low){
		std::cout << "high!=low" << std::endl;
		return 0;
	}

	return col_high;
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
	uint highest_id = 0;
	std::list<uint> all_ids;

	while (std::getline(infile, line)) {
		std::string row_str = line.substr(0, 7);
		std::string col_str = line.substr(7, std::string::npos);
		uint row = get_row(&row_str);
		uint col = get_col(&col_str);

		uint id = row * 8 + col;
		all_ids.push_back(id);
		if (id > highest_id){
			highest_id = id;
		}
	}
	infile.close();

	all_ids.sort();

	uint prev = 0;
	for (auto & elem : all_ids){
		if (elem != prev + 1){
			if (prev != 0){
				std::cout << "found missing seat: " << elem - 1 << std::endl;
			}
		}
		prev = elem;
	}

	std::cout << "Highest id: " << highest_id << std::endl;
}
