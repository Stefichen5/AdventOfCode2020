#include <iostream>
#include <fstream>
#include <vector>

#define TARGET_VALUE 2020

void part_1(std::vector<int> int_values){
	for (int i = 0; i < int_values.size(); i++){
		for (int j = i+1; j < int_values.size(); j++){
			if(int_values.at(i) + int_values.at(j) == TARGET_VALUE){
				std::cout << "Part 1 result: "
				<< (int_values.at(i) * int_values.at(j))
				<< std::endl;
			}
		}
	}
}

void part_2(std::vector<int> int_values){
	for (int i = 0; i < int_values.size(); i++){
		for (int j = i+1; j < int_values.size(); j++){
			for (int k = j+1; k < int_values.size(); k++){
				if(int_values.at(i) + int_values.at(j) + int_values.at(k) == TARGET_VALUE){
					std::cout << "Part 2 result: "
					<< (int_values.at(i) * int_values.at(j) * int_values.at(k))
					<< std::endl;
				}
			}
		}
	}
}

int main(int argc, char* argv[]) {
	std::cout << "Hello, World!" << std::endl;

	if (argc < 2){
		std::cout << "Please provide input file" << std::endl;
		return 1;
	}
	std::ifstream infile;
	infile.open(argv[1]);

	if(!infile.good()){
		std::cout << "Could not open file" << std::endl;
		return 1;
	}

	std::string line;
	std::vector<int> int_values;
	while(std::getline(infile, line)){
		int_values.push_back(std::stoi(line));
	}

	infile.close();

	part_1(int_values);
	part_2(int_values);

	return 0;
}
